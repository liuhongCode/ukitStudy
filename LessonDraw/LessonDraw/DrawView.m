//
//  DrawView.m
//  LessonDraw
//
//  Created by 刘hong on 15/8/4.
//  Copyright (c) 2015年 LH. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //获取绘图的当前上下文对象;获取方式1:在drawRect方法中获取上下文，2、通过image图片获取上下文。其它地方获取上下文是没有任何作用的
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    //设置绘图时画笔的颜色
    CGContextSetStrokeColorWithColor(contextRef, [UIColor redColor].CGColor);
    //设置画笔的粗细
    CGContextSetFontSize(contextRef, 1.5);
    for(int i = 0;i < _lineArray.count;i++){
        NSMutableArray *pointArray = [_lineArray objectAtIndex:i];
      
        //在触摸开始时，也加入当前的点的位置，是为了防止在触摸过程中，没有移动就结束了触摸；这时候，存储触摸过程中的点位置的数组就只是个空数组，那么这个数组的count为0类型为NSUInteger（无符号类型），在循环的时候用一个无符号类型的0-1得到的结果是－1，而无符号中的－1会是一个很大的数字（因为无符号不允许存在负数，所以会把－1存储为一个很大的数字）就会直接报错:NSRangeException  index 0 beyond bounds for empty array
        for (int j = 0; j < (int)(pointArray.count - 1); j ++) {
            CGPoint firstPoint = ((NSValue *)[pointArray objectAtIndex:j]).CGPointValue;
            CGPoint secondPoint = ((NSValue *)[pointArray objectAtIndex:j + 1]).CGPointValue;
            //笔触从上一个点移动到当前点
            CGContextMoveToPoint(contextRef, firstPoint.x, firstPoint.y);
            //把笔触当前的点与下一个点连成一条线
            CGContextAddLineToPoint(contextRef, secondPoint.x, secondPoint.y);
        }
        
    }
    CGContextStrokePath(contextRef);
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        //这里不使用变量直接赋值，采用setter方法来赋值，是因为下面这种不用手动使用alloc初始化化歌的方法返回的对象时autorelease的，也就是在这个方法外再使用这个成员变量的时候，可能已经被销毁了。使用setter方法，再声明的时候，用了copy修饰这个变量，这样即使[NSMutableArray arrayWithCapacity:1]返回的对象被release，也不会导致成员变量被销毁
        self.lineArray = [NSMutableArray arrayWithCapacity:1];
        UIButton *undoButton = [UIButton buttonWithType:UIButtonTypeSystem];
        
        undoButton.frame = CGRectMake((frame.size.width - 100) / 2, frame.size.height - 50, 100, 30);
        undoButton.backgroundColor = [UIColor whiteColor];
        [undoButton setTitle:@"撤销" forState:UIControlStateNormal];
        [undoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        undoButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [undoButton addTarget:self action:@selector(undo:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:undoButton];
       
    }
    
    return self;
}


- (void)undo:(UIButton *)button{
   
    [self setNeedsDisplay];
    [_lineArray removeLastObject];
    NSLog(@"_lineArray.count:%i",_lineArray.count);
    if([[self superview] isKindOfClass:[DrawView class]] && _lineArray.count == 0){
        [self removeFromSuperview];
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //每次触摸都创建一个可变数组，来存储这次触摸移动所经过的点的位置
    NSMutableArray *pointArray = [NSMutableArray arrayWithCapacity:1];

    [self.lineArray addObject:pointArray];

    
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //把每个触摸移动经过的点，存在这次触摸开始时建立的一个数组中
    NSMutableArray *pointArray = [_lineArray lastObject];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    NSValue *pointValue = [NSValue valueWithCGPoint:point];
    [pointArray addObject:pointValue];
    //重绘界面
    [self setNeedsDisplay];
    
  
    if(_lineArray.count / 10 == self.subviews.count){
        
        DrawView *dView = [[DrawView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        dView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        
        [self addSubview:dView];
        [dView release];
        
    }
    
    
    
    
    
}




- (void)dealloc{
    [_lineArray release];
    [super dealloc];
}

@end
