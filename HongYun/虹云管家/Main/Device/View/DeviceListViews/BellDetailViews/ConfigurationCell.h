//
//  ConfigurationCell.h
//  HongYunBell
//
//  Created by ZZ on 15/11/18.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigurationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *normalTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *normalDetailLabel;

@property (weak, nonatomic) IBOutlet UILabel *switchTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *switchDetailLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switchItem;

@property (weak, nonatomic) IBOutlet UILabel *volumeTextLabel;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;

@end
