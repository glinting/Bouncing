//
//  waveView.m
//  myAnimation
//
//  Created by liuqing on 15/6/8.
//  Copyright (c) 2015年 liuqing. All rights reserved.
//

#import "GTWaveView.h"

@implementation GTWaveView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _waveX = 0;
        _waveY = 0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat swing = 0.2;
    
    if (_waveX > 55) {
        
        _waveX = 0;
        _waveY = 0;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 2);
    
    CGContextMoveToPoint(context, -55 + _waveX, 40);
    CGContextAddCurveToPoint(context, -32.5 + _waveX, 30-(swing * 20), -22.5 + _waveX, 50 + (swing * 20), 0 + _waveX, 40);
    
    CGContextMoveToPoint(context, 0 + _waveX, 40);
    CGContextAddCurveToPoint(context, 22.5 + _waveX, 30 - (swing * (20 + _waveY)), 32.5 + _waveX, 50 + (swing * (20 + _waveY)), 55 + _waveX, 40);
    
    CGContextMoveToPoint(context, 55 + _waveX, 40);
    CGContextAddCurveToPoint(context, 77.5 + _waveX, 30 - (swing * 80), 87.5 + _waveX, 50 + (swing * 80), 110 + _waveX, 40);
    
    CGContextMoveToPoint(context, 110 + _waveX, 40);
    CGContextAddCurveToPoint(context, 132.5 + _waveX, 30 - (swing * (80 - _waveY)), 142.5 + _waveX, 50 + (swing * (80 - _waveY)), 165 + _waveX, 40);
    
    CGContextMoveToPoint(context, 165 + _waveX, 40);
    CGContextAddCurveToPoint(context, 187.5 + _waveX, 30 - (swing * 20), 197.5 + _waveX, 50 + (swing * 20), 220 + _waveX, 40);
    CGContextStrokePath(context);
    
    _waveX++;
    _waveY = _waveY + 0.727;
}

@end
