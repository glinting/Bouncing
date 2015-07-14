//
//  ViewController.m
//  myAnimation
//
//  Created by liuqing on 15/6/7.
//  Copyright (c) 2015年 liuqing. All rights reserved.
//

#import "GTViewController.h"
#import "GTAnimationViewController.h"

@implementation GTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubView];
}

- (void)setupSubView
{
    UIButton *actionButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 60, self.view.frame.size.height / 2, 120, 30)];
    [actionButton addTarget:self action:@selector(actionButtonClick) forControlEvents:UIControlEventTouchDown];
    [actionButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [actionButton setTitle:@"startAnimation" forState:UIControlStateNormal];
    [actionButton setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:actionButton];
}

- (void)actionButtonClick
{
    [GTAnimationViewController pushAnimationViewController:self.navigationController];
}

@end
