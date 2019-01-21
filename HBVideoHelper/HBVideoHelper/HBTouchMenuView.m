//
//  HBTouchMenuView.m
//  HBMoviePlay
//
//  Created by 胡勃 on 1/16/19.
//  Copyright © 2019 胡勃. All rights reserved.
//

#import "HBTouchMenuView.h"

@implementation HBTouchMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
//        _frontHeight = 64.f;
//        _radii = 8.f;
//        _topRadius = 4.f;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat viewWidth = rect.size.width;
    CGFloat viewHieght = rect.size.height;
    double Y = pow((double)(viewWidth), (double)2);
    double X = pow((double)(viewHieght/2), (double)2);
    //double Z =  sqrt(X + Y);//
    
    //获取绘图上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //绘制整体背景
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, viewWidth, 0);
    CGContextAddLineToPoint(ctx, viewWidth, viewHieght);
    CGContextAddLineToPoint(ctx, 0, viewHieght);
    CGContextAddArc(ctx, viewWidth, viewHieght/2, 100, M_PI*0.75, M_PI*1.25,0);
    CGContextClosePath(ctx);
    //CGContextStrokePath(ctx);//渲染
    CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);
    
    CGContextFillPath(ctx);
    //CGContextClosePath(ctx);

    
}
@end
