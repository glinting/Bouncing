//
//  GTAnimationViewController.m
//  myAnimation
//
//  Created by liuqing on 15/6/26.
//  Copyright (c) 2015年 liuqing. All rights reserved.
//

#import "GTAnimationViewController.h"
#import "GTAnimationCAShapeLayer.h"
#import "GTWaveView.h"

@interface GTAnimationViewController ()

// action button
@property (nonatomic, strong) UIButton *actionButton;
// start button status type
@property (nonatomic, assign) progressStatusType statusType;
@property (nonatomic, strong) GTWaveView *waveView;
@property (nonatomic, strong) CAShapeLayer *startLineLayer;
@property (nonatomic, strong) CAShapeLayer *endLineLayer;
// bezier path for the top of start line
@property (nonatomic, strong) UIBezierPath *bezierPath;
// bezier path for the arrow of start line
@property (nonatomic, strong) UIBezierPath *bezierPath2;
// shapeLayer for the top of start line
@property (nonatomic, strong) CAShapeLayer *startAnimationLayerUp;
// shapeLayer for the arrow of start line
@property (nonatomic, strong) CAShapeLayer *startAnimationLayerDown;
// circle timer to draw circle
@property (nonatomic, strong) NSTimer *circleTimer;
// start animation timer to draw start animation
@property (nonatomic, strong) NSTimer *startLineTimer;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger index2;

@end


@implementation GTAnimationViewController

+ (void)pushAnimationViewController:(UINavigationController *)na
{
    if (na) {
        GTAnimationViewController *viewController = [[GTAnimationViewController alloc] init];
        [na pushViewController:viewController animated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.16 green:0.62 blue:0.94 alpha:1];
    self.index = 0;
    self.index2 = 0;
    self.statusType = kprogressStatusStop;
    [self setupSubView];
    [self drawStartLineAnimation:0 index2:0];
    [self drawEndLine];
}

- (void)setupSubView
{
    // setup circleProgressView
    self.progressView = [[GTAnimationProgressView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 90, self.view.frame.size.height / 2 - 100, 180, 180)];
    self.progressView.center = self.view.center;
    self.progressView.timeLimit = 4; // the time for cricle
    self.progressView.elapsedTime = 0; // the initial time for cricle
    self.progressView.progressLabel.hidden = YES;
    [self.view addSubview:self.progressView];
    
    // setup waveView
    self.waveView = [[GTWaveView alloc] initWithFrame:CGRectMake(120, 300, 140, 50)];
    self.waveView.backgroundColor = [UIColor clearColor];
    self.waveView.clipsToBounds = YES;
    self.waveView.hidden = YES;
    [self.view addSubview:self.waveView];
    
    //setup startButton
    self.actionButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 30, self.view.frame.size.height / 2 + 110, 60, 30)];
    [self.actionButton addTarget:self action:@selector(actionButtonClick:) forControlEvents:UIControlEventTouchDown];
    [self.actionButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.actionButton setTitle:@"start" forState:UIControlStateNormal];
    [self.actionButton setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:self.actionButton];
}

// draw start line animation
- (void)drawStartLineAnimation:(NSInteger)index index2:(NSInteger)index2
{
    // index1 控制箭头点位置下移再上移
    // index2 控制上面的点上移到圈的位置
    // index3 控制上面点的长度，最后变成一点
    NSInteger index3 = 0;
    if (index > 23) {
        index = 15;
        index3 = 17;
    } else {
        index3 += 3;
        index2 = 0;
    }
    if (self.startAnimationLayerUp) {
        [self.startAnimationLayerUp removeFromSuperlayer];
    }
    self.startAnimationLayerUp = [CAShapeLayer layer];
    self.bezierPath = [UIBezierPath bezierPath];
    [self.bezierPath moveToPoint:CGPointMake(self.view.center.x, self.view.center.y - 30 + index - index2 + index3)];
    [self.bezierPath addLineToPoint:CGPointMake(self.view.center.x, self.view.center.y + 30 - index - index2 - index3)];
    self.startAnimationLayerUp.path = self.bezierPath.CGPath;
    self.startAnimationLayerUp.strokeColor = [UIColor whiteColor].CGColor;
    self.startAnimationLayerUp.fillColor = [UIColor clearColor].CGColor;
    self.startAnimationLayerUp.lineWidth = 2;
    self.startAnimationLayerUp.lineCap = kCALineCapSquare;
    self.startAnimationLayerUp.lineJoin = kCALineJoinRound;
    [self.view.layer addSublayer:self.startAnimationLayerUp];
    
    if (self.startAnimationLayerDown) {
        [self.startAnimationLayerDown removeFromSuperlayer];
    }
    self.startAnimationLayerDown = [CAShapeLayer layer];
    self.bezierPath2 = [UIBezierPath bezierPath];
    [self.bezierPath2 moveToPoint:CGPointMake(self.view.center.x - 15 , self.view.center.y + 15)];
    [self.bezierPath2 addLineToPoint:CGPointMake(self.view.center.x, self.view.center.y + 30 - index)];
    [self.bezierPath2 addLineToPoint:CGPointMake(self.view.center.x + 15, self.view.center.y + 15)];
    self.startAnimationLayerDown.path = self.bezierPath2.CGPath;
    self.startAnimationLayerDown.strokeColor = [UIColor whiteColor].CGColor;
    self.startAnimationLayerDown.fillColor = [UIColor clearColor].CGColor;
    self.startAnimationLayerDown.lineWidth = 2;
    self.startAnimationLayerDown.lineCap = kCALineCapSquare;
    self.startAnimationLayerDown.lineJoin = kCALineJoinRound;
    [self.view.layer addSublayer:self.startAnimationLayerDown];
}

// draw the end of animation line
- (void)drawEndLine
{
    self.endLineLayer = [CAShapeLayer layer];
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(self.view.center.x - 15, self.view.center.y)];
    [bezierPath addLineToPoint:CGPointMake(self.view.center.x, self.view.center.y + 20)];
    [bezierPath addLineToPoint:CGPointMake(self.view.center.x + 30, self.view.center.y - 30)];
    self.endLineLayer.path = bezierPath.CGPath;
    self.endLineLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.endLineLayer.fillColor = [UIColor clearColor].CGColor;
    self.endLineLayer.lineWidth = 2;
    self.endLineLayer.lineCap = kCALineCapSquare;
    self.endLineLayer.lineJoin = kCALineJoinRound;
    self.endLineLayer.hidden = YES;
    [self.view.layer addSublayer:self.endLineLayer];
}

// set circle start timer
- (void)circleStartTimer
{
    self.circleTimer = [NSTimer scheduledTimerWithTimeInterval:0.0045
                                                        target:self
                                                      selector:@selector(circlePoolTimer)
                                                      userInfo:nil
                                                       repeats:YES];
}

// do things on circle timer
- (void)circlePoolTimer
{
    self.progressTime = [[NSDate date] timeIntervalSinceDate:self.startDate];
    self.progressView.elapsedTime = self.progressTime;
    if (self.progressView.elapsedTime < self.progressView.timeLimit) {
        // draw circle and wave in limit time
        [self.waveView setNeedsDisplay];
    } else {
        // finish drawing circle
        [self.circleTimer invalidate];
        self.progressView.progressLabel.hidden = YES;
        self.waveView.hidden = YES;
        [UIView animateWithDuration:100 delay:30 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.endLineLayer.hidden = NO;
        } completion:^(BOOL finished) {
        }];
        // set start button restart
        [self.actionButton setTitle:@"restart" forState:UIControlStateNormal];
        self.actionButton.enabled = YES;
    }
}

// set start animation timer
- (void)startAnimationTimer
{
    self.startLineTimer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(startAnimationPoolTimer) userInfo:nil repeats:YES];
}

// do things on start animation timer
- (void)startAnimationPoolTimer
{
    self.index += 3;
    self.index2 += 3;
    if (self.index2 < 90) {
        [self drawStartLineAnimation:self.index index2:self.index2];
    } else {
        [self.startLineTimer invalidate];
        self.index = 0;
        self.index2 = 0;
        if (self.startAnimationLayerUp) {
            [self.startAnimationLayerUp removeFromSuperlayer];
        }
        if (self.startAnimationLayerDown) {
            [self.startAnimationLayerDown removeFromSuperlayer];
        }
        self.startDate = [NSDate date];
        // when start animation finished , start draw circle
        [self circleStartTimer];
        self.waveView.hidden = NO;
        self.progressView.progressLabel.hidden = NO;
    }
}

// click start button
- (void)actionButtonClick:(id)sender
{
    if (self.statusType == kprogressStatusStop) {
        self.statusType = kprogressStatusStart;
        self.actionButton.enabled = NO;
        self.startLineLayer.hidden = YES;
        self.endLineLayer.hidden = YES;
        [self startAnimationTimer];
    } else {
        self.statusType = kprogressStatusStop;
        self.progressView.elapsedTime = 0;
        [self.actionButton setTitle:@"start" forState:UIControlStateNormal];
        
        self.endLineLayer.hidden = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self drawStartLineAnimation:0 index2:0];
        });
    }
}

@end
