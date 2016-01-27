//
//  DeviceTableView.h
//  HongYunBell
//
//  Created by imac on 15/11/10.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeviceModel.h"
#import "DeviceTableViewCell.h"
#import "BellViewController.h"

@interface DeviceTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray *deviceArray;

@property (nonatomic, copy)void(^longPressAction)(DeviceModel *device);

@end
