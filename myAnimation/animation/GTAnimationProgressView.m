//
//  animationProgressView.m
//  myAnimation
//
//  Created by liuqing on 15/6/7.
//  Copyright (c) 2015年 liuqing. All rights reserved.
//

#import "GTAnimationProgressView.h"
#import "GTAnimationCAShapeLayer.h"

@interface GTAnimationProgressView ()

@property (nonatomic, strong) GTAnimationCAShapeLayer *progressLayer;

@property (nonatomic, strong) NSTimer *timer;

@end


@implementation GTAnimationProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.progressLayer.frame = self.bounds;
    [self.progressLabel sizeToFit];
    self.progressLabel.center = CGPointMake(self.center.x - self.frame.origin.x, self.center.y- self.frame.origin.y + 45);
}

- (UILabel *)progressLabel
{
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.backgroundColor = [UIColor clearColor];
        _progressLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:_progressLabel];
    }
    return _progressLabel;
}

- (CGFloat)percent
{
    return self.progressLayer.percent;
}

- (NSTimeInterval)timeLimit
{
    return self.progressLayer.timeLimit;
}

- (void)setTimeLimit:(NSTimeInterval)timeLimit
{
    self.progressLayer.timeLimit = timeLimit;
}

- (void)setElapsedTime:(NSTimeInterval)elapsedTime
{
    _elapsedTime = elapsedTime;
    self.progressLayer.elapsedTime = elapsedTime;
    self.progressLabel.text = [self stringFromTimeInterval:elapsedTime];
}

- (void)setupViews
{
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = false;
    self.progressLayer = [[GTAnimationCAShapeLayer alloc] init];
    self.progressLayer.frame = self.bounds;
    self.progressLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.progressLayer.progressColor = [UIColor whiteColor];
    self.progressLabel.textColor = [UIColor whiteColor];
    [self.layer addSublayer:self.progressLayer];
}

- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval
{
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
}

@end
