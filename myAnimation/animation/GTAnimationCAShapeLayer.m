//
//  animationCAShapeLayer.m
//  myAnimation
//
//  Created by liuqing on 15/6/7.
//  Copyright (c) 2015年 liuqing. All rights reserved.
//

#import "GTAnimationCAShapeLayer.h"

@interface GTAnimationCAShapeLayer ()

@property (nonatomic, assign) CGFloat initialProgress;

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@end


@implementation GTAnimationCAShapeLayer

- (instancetype)init
{
    if ((self = [super init])) {
        [self setupLayer];
    }
    return self;
}

- (void)layoutSublayers {
    
    self.path = [self drawPathWithArcCenter];
    self.progressLayer.path = [self drawPathWithArcCenter];
    [super layoutSublayers];
}

- (void)setupLayer
{
    self.path = [self drawPathWithArcCenter];
    self.fillColor = [UIColor clearColor].CGColor;
    self.strokeColor = [UIColor colorWithRed:0.86f green:0.86f blue:0.86f alpha:0.4f].CGColor;
    self.lineWidth = 15;
    
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.path = [self drawPathWithArcCenter];
    self.progressLayer.fillColor = [UIColor clearColor].CGColor;
    self.progressLayer.strokeColor = [UIColor redColor].CGColor;
    self.progressLayer.lineWidth = 5;
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.lineJoin = kCALineJoinRound;
    [self addSublayer:self.progressLayer];
}

- (CGPathRef)drawPathWithArcCenter
{
    CGFloat position_y = self.frame.size.height / 2;
    CGFloat position_x = self.frame.size.width / 2;
    return [UIBezierPath bezierPathWithArcCenter:CGPointMake(position_x, position_y)
                                          radius:position_y
                                      startAngle:(-M_PI / 2)
                                        endAngle:(3 * M_PI / 2)
                                       clockwise:YES].CGPath;
}

- (double)percent
{
    _percent = [self calculatePercent:_elapsedTime toTime:_timeLimit];
    return _percent;
}

- (void)setElapsedTime:(NSTimeInterval)elapsedTime
{
    _initialProgress = [self calculatePercent:_elapsedTime toTime:_timeLimit];
    _elapsedTime = elapsedTime;
    self.progressLayer.strokeEnd = self.percent;
    [self startAnimation];
}

- (void)setProgressColor:(UIColor *)progressColor
{
    self.progressLayer.strokeColor = progressColor.CGColor;
}

- (double)calculatePercent:(NSTimeInterval)fromTime toTime:(NSTimeInterval)toTime
{
    if ((toTime > 0) && (fromTime > 0)) {
        CGFloat progress = 0;
        progress = fromTime / toTime;
        if ((progress * 100) > 100) {
            progress = 1.0f;
        }
        return progress;
    } else {
        return 0;
    }
}

- (void)startAnimation
{
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1;
    pathAnimation.fromValue = @(self.initialProgress);
    pathAnimation.toValue = @(self.percent);
    pathAnimation.removedOnCompletion = YES;
    [self.progressLayer addAnimation:pathAnimation forKey:nil];
}

@end
