//
//  RootViewController.m
//  UIImageView
//
//  Created by 刘hong on 15/8/20.
//  Copyright (c) 2015年 LH. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化要播放的图片数组
    NSMutableArray *mimgArray = [NSMutableArray arrayWithCapacity:1];
    for (int i = 1; i < 32; i++) {
        NSString *fileName = [NSString stringWithFormat:@"footballFunny－%d（被拖移）.tiff",i];
        
         UIImage *image = [UIImage imageNamed:fileName];
        [mimgArray addObject:image];
                           
    }
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 200, 300)];
    //设置需要播放的图片数组
    imageView.animationImages = mimgArray;
    //设置整组图片播放完成的时间，默认为0.0f
    imageView.animationDuration = 4.0f;
    //设置重复播放的次数，默认为不限重复播放次数
    //imageView.animationRepeatCount = 2;

    //启动animationImages中的图片播放
    [imageView startAnimating];
    
    
    
    
    NSLog(@"animationDuration:%f",imageView.animationDuration);
    NSLog(@"imageView.animationRepeatCount:%i",imageView.animationRepeatCount);
    //判断该图片对象中中的animationImages图片是否在播放
    NSLog(@"imageView.isAnimating:%i",imageView.isAnimating);
    
    //停止animationImages中的图片播放
//    [imageView stopAnimating];
//    NSLog(@"imageView.isAnimating:%i",imageView.isAnimating);


    
    
    
    [self.view addSubview:imageView];
    [imageView release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
