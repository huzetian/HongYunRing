//
//  DeviceTableViewCell.m
//  HongYunBell
//
//  Created by imac on 15/11/10.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "DeviceTableViewCell.h"

@interface DeviceTableViewCell ()
@property (nonatomic, strong)NSArray *picNameArray;

@end

@implementation DeviceTableViewCell

- (void)awakeFromNib {
    
    _picNameArray = @[@"路由器", @"门铃图标"];

    //分割线偏移
    [self setSeparatorInset:UIEdgeInsetsMake(0, _deviceName.left, 0, 0)];
    
    //名字label
    _deviceName.font = [UIFont fontWithName:@"FZLTHJW" size:17];
    //状态label
    _deviceStatus.font = [UIFont fontWithName:@"FZLTHJW" size:15];
}

/**
 *  设置Model，gengxinUI
 *
 *  @param device 数据Model
 */
- (void)setDevice:(DeviceModel *)device {
    if (_device == device) {
        return;
    }
    _device = device;
    
    //设备名字
    self.deviceName.text = device.devID;
    
    //设备状态
    if (device.status == DeviceOffLine) {
        self.deviceStatus.text = @"设备离线";
    }
    else if (device.status == DeviceOnline) {
        self.deviceStatus.text = @"设备在线";
    }
    
    //设备图片
    NSString *imageName = _picNameArray[[device.type isEqualToString:@"RING"]];
    self.deviceKind.image = [UIImage imageNamed:imageName];
}

@end
