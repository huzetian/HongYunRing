
//
//  LongView.m
//  门铃
//
//  Created by TIAN on 15/12/29.
//  Copyright © 2015年 Tian. All rights reserved.
//

#import "LongPressSettingView.h"

@implementation LongPressSettingView

- (instancetype)initWithFrame:(CGRect)frame tapAction:(void (^)(UIButton *, NSInteger))action {
    
    if (self = [super initWithFrame:frame]) {
        [self createButtons];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        self.tapAction = action;
    }
    return self;
}

/**
 *  创建按钮
 */
- (void)createButtons {
    
    CGFloat buttonWidth = self.width;
    CGFloat buttonHeight = self.height / 3;
    UIColor *buttonTitleColor = ColorMakeRGB(100, 100, 100);
    //按钮1：修改昵称
    UIButton *firstButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
    [firstButton setTitle:@"修改备注名称" forState:UIControlStateNormal];
    [firstButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    [firstButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //按钮2：分享设备
    UIButton *secondButton = [[UIButton alloc] initWithFrame:CGRectMake(0, buttonHeight, buttonWidth, buttonHeight)];
    [secondButton setTitle:@"设备分享" forState:UIControlStateNormal];
    [secondButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    [secondButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //按钮3：解除绑定
    UIButton *thirdButton = [[UIButton alloc] initWithFrame:CGRectMake(0, buttonHeight * 2, buttonWidth, buttonHeight)];
    [thirdButton setTitle:@"解除绑定" forState:UIControlStateNormal];
    [thirdButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    [thirdButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    firstButton.tag =   100;
    secondButton.tag =  101;
    thirdButton.tag =   102;
    [self addSubview:firstButton];
    [self addSubview:secondButton];
    [self addSubview:thirdButton];
}

- (void)buttonAction:(UIButton *)button {
    if (self.tapAction) {
        self.tapAction(button, button.tag - 100);
    }
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self _drawLine:context];
}

/**
 *  画水平分割线
 *
 *  @param context 图形上下文
 */
- (void)_drawLine:(CGContextRef)context {
    //创建路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGContextSetLineWidth(context, 0.5);
    //绘制
    CGPathMoveToPoint(path, NULL, 0, self.height / 3);
    CGPathAddLineToPoint(path, NULL, self.width, self.height / 3);
    CGContextAddPath(context, path);
    CGPathMoveToPoint(path, NULL, 0, self.height / 3 * 2);
    CGPathAddLineToPoint(path, NULL, self.width, self.height / 3 *2);
    CGContextAddPath(context, path);
    [[UIColor grayColor] setStroke];
    //在上下文中绘制线条
    CGContextDrawPath(context, kCGPathStroke);
    //释放
    CGPathRelease(path);
}

@end
