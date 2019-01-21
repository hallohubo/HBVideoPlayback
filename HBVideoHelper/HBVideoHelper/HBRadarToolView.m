//
//  HBRadarToolView.m
//  HBVideoHelper
//
//  Created by 胡勃 on 1/21/19.
//  Copyright © 2019 胡勃. All rights reserved.
//
#define ThemeColor [UIColor blueColor]

#import "HBRadarToolView.h"

@implementation HBRadarToolView

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    [[UIColor whiteColor] setFill];
    
    UIRectFill(rect);
    
    NSInteger pulsingCount = 5;
    double animationDuration = 3;
    CALayer * animationLayer = [CALayer layer];
    for (int i = 0; i < pulsingCount; i++) {
        CALayer * pulsingLayer = [CALayer layer];
        pulsingLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        pulsingLayer.borderColor = ThemeColor.CGColor;
        pulsingLayer.borderWidth = 1;
        pulsingLayer.cornerRadius = rect.size.height / 2;
        CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
        animationGroup.fillMode = kCAFillModeBackwards;
        animationGroup.beginTime = CACurrentMediaTime() + (double)i * animationDuration / (double)pulsingCount;
        animationGroup.duration = animationDuration;
        animationGroup.repeatCount = HUGE;
        animationGroup.timingFunction = defaultCurve;
        
        CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = @1.0;
        scaleAnimation.toValue = @1.8;
        CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.values = @[@1, @0.9, @0.8, @0.7, @0.6, @0.5, @0.4, @0.3, @0.2, @0.1, @0];
        opacityAnimation.keyTimes = @[@0, @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1];
        animationGroup.animations = @[scaleAnimation, opacityAnimation];
        [pulsingLayer addAnimation:animationGroup forKey:@"plulsing"];
        [animationLayer addSublayer:pulsingLayer];

    }
    
    [self.layer addSublayer:animationLayer];
    
    
    //外侧圆环实现
    
    CGFloat op = 0.5/5.0;
    CGFloat scal = (1.8 - 1.4) / 5.0;
    for (int i = 0; i < 5; i++) {
        CALayer *pulsingLayer = [CALayer layer];
        pulsingLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        pulsingLayer.borderColor = ThemeColor.CGColor;
        pulsingLayer.borderWidth = 5;
        pulsingLayer.cornerRadius = rect.size.height / 2;
        pulsingLayer.opacity = 0.5 - op * i;
        pulsingLayer.transform = CATransform3DMakeScale(1.5 + scal * i, 1.5 + scal * i, 0);
        [self.layer addSublayer:pulsingLayer];

    }
    
}


@end
