//
//  ViewController.m
//  HBVideoHelper
//
//  Created by 胡勃 on 1/21/19.
//  Copyright © 2019 胡勃. All rights reserved.
//

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "HBTouchMenuView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup1];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setup1 {
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    HBTouchMenuView *test = [[HBTouchMenuView alloc]initWithFrame:CGRectMake(kScreenWidth-120, 64, 120, 200)];
    test.backgroundColor = [UIColor clearColor];
    // UIView *dottedLine = [[UIView alloc]initWithFrame:CGRectMake(8, 64, 290 - 16, 1)];
    //绘制虚线
    [self.view addSubview:test];
}

- (void)setup {
    CGFloat width = 200;
    CGRect viewframe = CGRectMake((kScreenWidth - width) / 2, 150, width, width);
    
    UIView *aniView = [[UIView alloc] initWithFrame:viewframe];
    [self.view addSubview:aniView];
    CALayer *layer = [self replicatorLayer_Circle];
    [aniView.layer addSublayer:layer];
    aniView.clipsToBounds = YES;
    self.view.backgroundColor = [UIColor grayColor];
}

#pragma mark - animation example
- (CALayer *)replicatorLayer_Circle {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 0, 250, 250);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 250, 250)].CGPath;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    shapeLayer.opacity = 0.0;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[[self alphaAnimation],[self scaleAnimation]];
    animationGroup.duration = 4.0;//动画快慢
    animationGroup.autoreverses = NO;
    animationGroup.repeatCount = HUGE;
    //animationGroup.repeatCount = 1;//动画只展示1次
    [shapeLayer addAnimation:animationGroup forKey:@"animationGroup"];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(0, 0, 30, 30);
    replicatorLayer.instanceDelay = 0.5;                //向外扩散的速度
    replicatorLayer.instanceCount = 1;                  //hubo有多少层
    //    replicatorLayer.instanceAlphaOffset = 1.f;//hubo
    [replicatorLayer addSublayer:shapeLayer];
    return replicatorLayer;
}

- (CABasicAnimation *)alphaAnimation{
    CABasicAnimation *alpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alpha.fromValue = @(0.3);
    alpha.toValue = @(0.0);
    return alpha;
}

- (CABasicAnimation *)scaleAnimation{
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    return scale;
}

- (CALayer *)createMaskLayerWithView : (UIView *)view{
    
    CGFloat viewWidth = CGRectGetWidth(view.frame);
    CGFloat viewHeight = CGRectGetHeight(view.frame);
    
    CGFloat rightSpace = 10.;
    CGFloat topSpace = 15.;
    
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(viewWidth-rightSpace, 0);
    CGPoint point3 = CGPointMake(viewWidth-rightSpace, topSpace);
    CGPoint point4 = CGPointMake(viewWidth, topSpace);
    CGPoint point5 = CGPointMake(viewWidth-rightSpace, topSpace+10.);
    CGPoint point6 = CGPointMake(viewWidth-rightSpace, viewHeight);
    CGPoint point7 = CGPointMake(0, viewHeight);
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point5];
    [path addLineToPoint:point6];
    [path addLineToPoint:point7];
    [path closePath];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    
    return layer;
}


@end
