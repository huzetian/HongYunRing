//
//  UserInfoHeader.m
//  HongYunBell
//
//  Created by imac on 15/11/13.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "UserInfoHeader.h"
#import "UserManager.h"
@implementation UserInfoHeader
- (void)awakeFromNib {
    //背景设置
    UIImage *backgroundImage = [UIImage imageNamed:@"圆角矩形-1"];
    CGFloat x = 10;
    CGImageRef imageRef = CGImageCreateWithImageInRect([backgroundImage CGImage], CGRectMake(x, 64, 345 - x * 2, self.height));
    backgroundImage = [UIImage imageWithCGImage:imageRef];
    
//    self.background = [[UIImageView alloc] initWithFrame:self.bounds];
    self.background.image = backgroundImage;
//    [self addSubview:self.background];
    
    //头像
//    self.userAvatar = [UIImageView alloc] initWithFrame:CGRectMake(0, 0, <#CGFloat width#>, <#CGFloat height#>)
    _userAvatar.image = [UIImage imageNamed:@"组-10"];
    _userAvatar.layer.cornerRadius = _userAvatar.width / 2;
    
    //用户名
    NSString *nickName = [UserManager shareInstance].user.nickName;
    if (nickName) {
        
        [_userName setTitle:nickName forState:UIControlStateNormal];
    }
    else {
        [_userName setTitle:@"未登录" forState:UIControlStateNormal];

    }
    
    //标语
    _slogan.text = @"享智慧，享生活";
}

- (IBAction)loginAction:(id)sender {
    //未登录状态
    if (![UserManager shareInstance].isLoggedin) {
        NSLog(@"用户登录");
        
        BaseViewController *selfVC = (BaseViewController *)self.controller;
        [selfVC presentLoginVC];
    }
}

@end
