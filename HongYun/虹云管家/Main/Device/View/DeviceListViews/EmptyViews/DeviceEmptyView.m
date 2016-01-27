//
//  DeviceAddingView.m
//  HongYunBell
//
//  Created by imac on 15/11/11.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "DeviceEmptyView.h"

@implementation DeviceEmptyView

- (void)awakeFromNib {
    //设置图片
    self.imageView.contentMode = UIViewContentModeCenter;
    self.imageView.image = [UIImage imageNamed:@"设备列表空02"];
    
    //titleLabel
    self.titleLabel.font = [UIFont systemFontOfSize:17.0];
   
    //detailLabel
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    self.detailLabel.font = [UIFont systemFontOfSize:12.0];
    NSString *text = @"赶紧把自己的智能设备添加进来吧。";
    [self.detailLabel setText:text
                    textColor:ColorMakeRGB(0xE1, 0xE1, 0xE1)
              actionTextRange:NSMakeRange(8, 4)
              actionTextColor:ColorMakeRGB(59, 126, 246)];
}


@end
