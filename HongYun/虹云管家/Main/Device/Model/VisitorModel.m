//
//  VisitorModel.m
//  HongYunBell
//
//  Created by ZZ on 15/11/17.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "VisitorModel.h"

@implementation VisitorModel

/**
 *  映射字典
 *
 *  @return 字典
 */
- (NSDictionary *)attributeMapDictionary {
    //@"属性名": @"数据字典的key"
    NSDictionary *mapAtt = @{@"devID":@"dev_id",
                             @"endDateTime":@"end_date_time",
                             @"startDateTime":@"start_date_time"};
    
    return mapAtt;
}

- (void)setAttributes:(NSDictionary *)dataDic {
    
    [super setAttributes:dataDic];
    
    //操作记录的数组
    NSArray *actionsArray = [dataDic objectForKey:@"session"];
    if (actionsArray != nil) {
        self.sessionArray = [NSMutableArray array];
        for (NSDictionary *actionDic in actionsArray) {
            ActionModel *action = [[ActionModel alloc] initWithDataDic:actionDic];
            [self.sessionArray addObject:action];
        }
    }
    
    //操作记录的数组
    NSArray *userIDsArray = [dataDic objectForKey:@"user_ids"];
    if (userIDsArray != nil) {
        self.userIDs = [NSMutableArray array];
        for (NSString *userID in userIDsArray) {
            [self.userIDs addObject:userID];
        }
    }

}

- (NSString *)date {
    if (self.startDateTime) {
        NSString *date = [self.startDateTime substringWithRange:NSMakeRange(0, 10)];
        return date;
    }
    return nil;
}
- (NSString *)time {
    if (self.startDateTime) {
        NSString *time = [self.startDateTime substringWithRange:NSMakeRange(11, 18)];
        return time;
    }
    return nil;
}

@end
