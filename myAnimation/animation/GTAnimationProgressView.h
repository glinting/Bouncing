//
//  animationProgressView.h
//  myAnimation
//
//  Created by liuqing on 15/6/7.
//  Copyright (c) 2015年 liuqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTAnimationProgressView : UIControl

@property (nonatomic, assign) NSTimeInterval elapsedTime;
@property (nonatomic, assign) NSTimeInterval timeLimit;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, assign) CGFloat percent;

@property (nonatomic, strong) UILabel *progressLabel;

@end
