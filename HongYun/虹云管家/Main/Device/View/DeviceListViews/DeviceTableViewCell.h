//
//  DeviceTableViewCell.h
//  HongYunBell
//
//  Created by imac on 15/11/10.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeviceModel.h"


@interface DeviceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *deviceKind;
@property (weak, nonatomic) IBOutlet UILabel *deviceName;
@property (weak, nonatomic) IBOutlet UILabel *deviceStatus;

@property (nonatomic, strong)DeviceModel *device;

@end
