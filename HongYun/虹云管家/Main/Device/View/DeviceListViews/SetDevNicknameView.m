//
//  SetDevNicknameView.m
//  HongYunBell
//
//  Created by ZZ on 16/1/24.
//  Copyright © 2016年 zhangzheng. All rights reserved.
//

#import "SetDevNicknameView.h"
#import "AppDelegate.h"

@implementation SetDevNicknameView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.image = [UIImage imageNamed:@"修改昵称_03"];
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        self.userInteractionEnabled = YES;
        [self createSubviews];
    }
    return self;
}

/**
 *  创建子视图
 */
- (void)createSubviews {
    
    //获取window
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = appdele.window;
    [window addSubview:self];
    
    //输入框
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.height / 3, self.width - 20, self.height / 3)];
    self.textField.placeholder = @"输入昵称对方注册虹云帐号的手机号码";
    self.textField.layer.cornerRadius = 4;
    self.textField.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.textField];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height / 3)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"设备分享";
    label.textColor = [UIColor blackColor];
    [self addSubview:label];
    
    //确定按钮
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.height / 3 * 2, self.width / 2, self.height / 3)];
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftButton];

    //取消按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width/2, self.height/3*2, self.width/2, self.height/3)];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightButton];
}

/**
 *  取消操作
 *
 *  @param button 按钮
 */
- (void)cancelAction:(UIButton *)button {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

/**
 *  确定按钮
 *
 *  @param button 按钮
 */
- (void)confirmAction:(UIButton *)button {
    if (self.confirmBlock) {
        NSString *nickname = self.textField.text;
        self.confirmBlock(nickname);
    }
}

@end
