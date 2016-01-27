//
//  DeviceModel.h
//  HongYunBell
//
//  Created by imac on 15/11/10.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "BaseModel.h"
#import "UserModel.h"

typedef NS_ENUM(NSInteger, DeviceStatus) {
    DeviceOffLine = 0,
    DeviceOnline = 1,
};
    
/**
 *  设备模型
 */
@interface DeviceModel : BaseModel

@property (nonatomic, strong)NSString *devID;       //设备号
@property (nonatomic, copy)  NSString *nickName;    //设备昵称
@property (nonatomic, strong)NSString *type;        //设备种类
@property (nonatomic, assign)DeviceStatus status;   //设备状态
@property (nonatomic, strong)NSMutableArray *sharedArray;  //分享给的用户

@end
