//
//  DeviceModel.m
//  HongYunBell
//
//  Created by imac on 15/11/10.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "DeviceModel.h"

@implementation DeviceModel

/**
 *  映射字典
 *
 *  @return 字典
 */
- (NSDictionary *)attributeMapDictionary {
    //@"属性名": @"数据字典的key"
    NSDictionary *mapAtt = @{@"devID" : @"dev_id",
                             @"nickName" : @"nick_name",
                             @"type" : @"type"};
    
    return mapAtt;
}

- (void)setAttributes:(NSDictionary *)dataDic {
    
    [super setAttributes:dataDic];
    
    //设备状态
    NSInteger statusNum = [[dataDic objectForKey:@"online_status"] integerValue];
    self.status = statusNum;
    
    //分享用户的数组
    NSArray *sharedArray = [dataDic objectForKey:@"shared_to"];
    
    if (sharedArray == nil) {
        return;
    }
    self.sharedArray = [NSMutableArray array];
    for (NSDictionary *shareDic in sharedArray) {
        UserModel *model = [[UserModel alloc] initWithDataDic:shareDic];
        [self.sharedArray addObject:model];
    }
}

@end
