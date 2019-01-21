//
//  HBTestLayCtr.m
//  HBVideoHelper
//
//  Created by 胡勃 on 1/21/19.
//  Copyright © 2019 胡勃. All rights reserved.
//

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#import "HBTestLayCtr.h"

@interface HBTestLayCtr () {
    CAShapeLayer *shapeLayer;
}
@property (strong, nonatomic) CAShapeLayer *shapeLayer;
@property (strong, nonatomic) NSTimer *timer;


@end

@implementation HBTestLayCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI2];
}

- (void)viewDisappear:(BOOL)animated {
    [_timer invalidate];
    _timer = nil;
}

- (void)tap:(UITapGestureRecognizer*)tap {

    
}

- (void)setup {
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 120, 200)];
    [btn setTitle:@"点击显示动画" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchDown];
}

- (CALayer *)replicatorLayer_Circle {
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 0, 350, 350);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 350, 350)].CGPath;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    shapeLayer.opacity = 0.0;
    return shapeLayer;
}

- (void)createUI2 {
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.frame = CGRectMake(0, 0, 200, 200);
    _shapeLayer.position = self.view.center;
    _shapeLayer.path = [self getStarOneBezierPath].CGPath;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer.strokeColor = [UIColor redColor].CGColor;
    _shapeLayer.lineWidth = 2.0f;
    [self.view.layer addSublayer:_shapeLayer];

    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(bezierPathAnimation) userInfo:nil repeats:YES];
    
}

/// 执行bezierPath的动画
- (void)bezierPathAnimation {
    static int i = 0;
    if (i++ % 2 == 0) {
        CABasicAnimation * circleAnim = [CABasicAnimation animationWithKeyPath:@"path"];
        circleAnim.removedOnCompletion = NO;
        circleAnim.duration = 2;
        circleAnim.fromValue = (__bridge id _Nullable)([self getStarOneBezierPath].CGPath);
        circleAnim.toValue = (__bridge id _Nullable)([self getStarTwoBezierPath].CGPath);
        _shapeLayer.path = [self getStarTwoBezierPath].CGPath;
        [_shapeLayer addAnimation:circleAnim forKey:@"animateCirclePath"];
    }else {
        CABasicAnimation * circleAnim = [CABasicAnimation animationWithKeyPath:@"path"];
        circleAnim.removedOnCompletion = NO;
        circleAnim.duration = 2;
        circleAnim.fromValue = (__bridge id _Nullable)([self getStarTwoBezierPath].CGPath);
        circleAnim.toValue = (__bridge id _Nullable)([self getStarOneBezierPath].CGPath);
        _shapeLayer.path = [self getStarOneBezierPath].CGPath;
        [_shapeLayer addAnimation:circleAnim forKey:@"animateCirclePath"];
    }
}

/// 贝塞尔曲线1
- (UIBezierPath *)getStarOneBezierPath {
    // draw star
    UIBezierPath * starPath = [UIBezierPath bezierPath];
    [starPath moveToPoint:CGPointMake(22.5, 2.5)];
    [starPath addLineToPoint:CGPointMake(28.32, 14.49)];
    [starPath addLineToPoint:CGPointMake(41.52, 16.32)];
    [starPath addLineToPoint:CGPointMake(31.92, 25.56)];
    [starPath addLineToPoint:CGPointMake(34.26, 38.68)];
    [starPath addLineToPoint:CGPointMake(22.5, 32.4)];
    [starPath addLineToPoint:CGPointMake(10.74, 38.68)];
    [starPath addLineToPoint:CGPointMake(13.08, 25.56)];
    [starPath addLineToPoint:CGPointMake(3.48, 16.32)];
    [starPath addLineToPoint:CGPointMake(16.68, 14.49)];
    [starPath closePath];
    
    return starPath;
}

// 贝塞尔曲线2
- (UIBezierPath *)getStarTwoBezierPath {
    // draw star
    UIBezierPath * starPath = [UIBezierPath bezierPath];
    [starPath moveToPoint:CGPointMake(22.5, 2.5)];
    [starPath addLineToPoint:CGPointMake(32.15, 9.21)];
    [starPath addLineToPoint:CGPointMake(41.52, 16.32)];
    [starPath addLineToPoint:CGPointMake(38.12, 27.57)];
    [starPath addLineToPoint:CGPointMake(34.26, 38.68)];
    [starPath addLineToPoint:CGPointMake(22.5, 38.92)];
    [starPath addLineToPoint:CGPointMake(10.74, 38.68)];
    [starPath addLineToPoint:CGPointMake(6.88, 27.57)];
    [starPath addLineToPoint:CGPointMake(3.48, 16.32)];
    [starPath addLineToPoint:CGPointMake(12.85, 9.21)];
    [starPath closePath];
    
    return starPath;
}


@end
