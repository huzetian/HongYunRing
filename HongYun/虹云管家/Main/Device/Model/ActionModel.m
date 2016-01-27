//
//  ActionModel.m
//  HongYunBell
//
//  Created by ZZ on 15/12/25.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "ActionModel.h"

@implementation ActionModel

/**
 *  映射字典
 *
 *  @return 字典
 */
- (NSDictionary *)attributeMapDictionary {
    //@"属性名": @"数据字典的key"
    NSDictionary *mapAtt = @{@"action":@"action",
                             @"content":@"content",
                             @"dateTime":@"date_time",
                             @"sender":@"sender"};
    
    return mapAtt;
}

@end
