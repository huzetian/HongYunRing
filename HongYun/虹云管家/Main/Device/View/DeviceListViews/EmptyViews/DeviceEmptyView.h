//
//  DeviceAddingView.h
//  HongYunBell
//
//  Created by imac on 15/11/11.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLabel.h"
@interface DeviceEmptyView : UIView 

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet MyLabel *detailLabel;

@end
