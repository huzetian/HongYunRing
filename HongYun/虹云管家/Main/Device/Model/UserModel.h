//
//  SharedModel.h
//  HongYunBell
//
//  Created by ZZ on 15/12/11.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "BaseModel.h"

/**
 *  用户模型
 */
@interface UserModel : BaseModel

@property (nonatomic, copy)NSString *nickName;      //用户昵称
@property (nonatomic, copy)NSString *userID;        //用户账号
@property (nonatomic, copy)NSString *userPwd;       //账号密码

@end
