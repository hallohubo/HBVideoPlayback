//
//  HBMainMovieCtr.m
//  HBMoviePlay
//
//  Created by 胡勃 on 1/16/19.
//  Copyright © 2019 胡勃. All rights reserved.
//
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


#import "HBMainMovieCtr.h"
#import "HBTouchMenuView.h"
#import <Masonry/Masonry.h>

@interface HBMainMovieCtr ()<UIGestureRecognizerDelegate, CAAnimationDelegate> {
    IBOutlet UIView *vPlayer;
    HBTouchMenuView *test;
    CAShapeLayer *shapeLayer;
}

@end

@implementation HBMainMovieCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view from its nib.
}

- (void)setup {
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-120, 510, 120, 200)];
    [btn setTitle:@"点击显示动画" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchDown];
    [self addNewAnimation];
    // UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    //gesture.delegate = self;
    //gesture.cancelsTouchesInView    = NO;
    //[test addGestureRecognizer:gesture];
}

- (void)addNewAnimation {
    if (test) {
        [test removeFromSuperview];
        [vPlayer layoutIfNeeded];
    }
    test = [[HBTouchMenuView alloc] initWithFrame:CGRectMake(kScreenWidth-150, 0, 150, 200)];
    //test.backgroundColor = [UIColor redColor];

    CALayer *layer = [self replicatorLayer_Circle];
    test.clipsToBounds = YES;
    [test.layer addSublayer:layer];
    
    
//    [vPlayer addSubview:test];
 
    //[test setUserInteractionEnabled:YES];
    [vPlayer addSubview:test];
}

- (void)removeFinishedAnition {
    [test removeFromSuperview];
    [vPlayer layoutIfNeeded];
}


#pragma mark - event

- (void)tap:(UITapGestureRecognizer*)tap {
    [self addNewAnimation];
    
}

-(void)hidden {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 1;
    [test.layer addAnimation:animation forKey:nil];
    test.hidden = YES;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - animation example
- (CALayer *)replicatorLayer_Circle {
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 0, 350, 350);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 350, 350)].CGPath;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    shapeLayer.opacity = 0.0;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.delegate = self;
    animationGroup.animations = @[[self alphaAnimation],[self scaleAnimation]];
    animationGroup.duration = 1.0;//动画快慢
    animationGroup.autoreverses = NO;
    //animationGroup.repeatCount = HUGE;
    animationGroup.repeatCount = 2;//动画只展示1次
    [shapeLayer addAnimation:animationGroup forKey:@"animationGroup"];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    //replicatorLayer.frame = CGRectMake(-50, -78.1, 80, 80);//调整中心点
    replicatorLayer.frame = CGRectMake(0, -75, 150, 200);//调整中心点
    replicatorLayer.instanceDelay = 0.01;                //向外扩散的速度
    replicatorLayer.instanceCount = 1;                  //hubo有多少层
    //    replicatorLayer.instanceAlphaOffset = 1.f;//hubo
    [replicatorLayer addSublayer:shapeLayer];
    return replicatorLayer;
}

- (CABasicAnimation *)alphaAnimation {
    CABasicAnimation *alpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alpha.fromValue = @(0.7);
    alpha.toValue = @(0.01);
    return alpha;
}

- (CABasicAnimation *)scaleAnimation {
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 0.2)];
    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 1.0)];
    return scale;
}

#pragma mark -CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim {
//    NSLog(@"animationDidStart%@",self.layer.animationKeys);
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
//    [self removeFinishedAnition];
}



@end
