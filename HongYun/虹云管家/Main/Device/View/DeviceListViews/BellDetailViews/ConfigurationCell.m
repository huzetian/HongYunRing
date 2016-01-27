//
//  ConfigurationCell.m
//  HongYunBell
//
//  Created by ZZ on 15/11/18.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "ConfigurationCell.h"

@implementation ConfigurationCell

- (void)awakeFromNib {
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    if (_volumeSlider) {
        [_volumeSlider setThumbImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
