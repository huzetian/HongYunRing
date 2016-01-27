//
//  TabBarBackgroundView.m
//  门铃
//
//  Created by Tian on 10/11/15.
//  Copyright © 2015年 Tian. All rights reserved.
//

#import "TabBarBackgroundView.h"

@implementation TabBarBackgroundView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self _drawLine:context];
}

//在view上面正中间画一道竖杠
- (void)_drawLine:(CGContextRef)context
{
    //创建路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGContextSetLineWidth(context, 0.5);
    //绘制
    CGPathMoveToPoint(path, NULL, self.width / 2, self.height / 4);
    CGPathAddLineToPoint(path, NULL, self.width / 2, self.height * 3 / 4);
    CGContextAddPath(context, path);
    [[UIColor grayColor] setStroke];
    //在上下文中绘制线条
    CGContextDrawPath(context, kCGPathStroke);
    //释放
    CGPathRelease(path);
}

@end
