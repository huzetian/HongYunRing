//
//  SharedModel.m
//  HongYunBell
//
//  Created by ZZ on 15/12/11.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

/**
 *  映射字典
 *
 *  @return 字典
 */
- (NSDictionary *)attributeMapDictionary {
    //@"属性名": @"数据字典的key"
    NSDictionary *mapAtt = @{@"nickName":@"nick_name",
                             @"userID":@"user_id"};
    
    return mapAtt;
}

- (void)setUserID:(NSString *)userID {
    if (![_userID isEqualToString:userID]) {
        _userID = [userID copy];
        
    }
    NSLog(@"set user ID : %@", userID);
}
@end
