//
//  RootViewController.m
//  LessonDraw
//
//  Created by 刘hong on 15/8/4.
//  Copyright (c) 2015年 LH. All rights reserved.
//

#import "RootViewController.h"
#import "DrawView.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DrawView *dView = [[DrawView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    dView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:dView];
    
    
    [dView release];
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
