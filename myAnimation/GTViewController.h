//
//  ViewController.h
//  myAnimation
//
//  Created by liuqing on 15/6/7.
//  Copyright (c) 2015年 liuqing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTAnimationProgressView.h"

typedef NS_ENUM(NSUInteger, progressStatusType) {
    kprogressStatusStart,
    kprogressStatusStop,  
};

@interface GTViewController : UIViewController

@property (nonatomic, strong) GTAnimationProgressView *progressView;

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *finishDate;
@property (nonatomic, assign) NSTimeInterval progressTime;

@end

