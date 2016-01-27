//
//  UserInfoHeader.h
//  HongYunBell
//
//  Created by imac on 15/11/13.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
@interface UserInfoHeader : UIView

@property (nonatomic, copy)NSString *userNickName;

@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UIButton *userName;
@property (weak, nonatomic) IBOutlet UILabel *slogan;

//@property (strong, nonatomic) UIImageView *background;
//@property (strong, nonatomic) UIImageView *userAvatar;
//@property (strong, nonatomic) UIButton *userName;
//@property (strong, nonatomic) UILabel *slogan;

@end
