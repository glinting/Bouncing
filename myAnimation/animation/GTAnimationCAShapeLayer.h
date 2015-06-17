//
//  animationCAShapeLayer.h
//  myAnimation
//
//  Created by liuqing on 15/6/7.
//  Copyright (c) 2015年 liuqing. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface GTAnimationCAShapeLayer : CAShapeLayer

@property (nonatomic, assign) NSTimeInterval elapsedTime;
@property (nonatomic, assign) NSTimeInterval timeLimit;
@property (nonatomic, assign) CGFloat percent;

@property (nonatomic, strong) UIColor *progressColor;

@end
