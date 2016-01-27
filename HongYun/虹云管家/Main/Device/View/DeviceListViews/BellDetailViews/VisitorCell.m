//
//  VisitorCell.m
//  HongYunBell
//
//  Created by ZZ on 15/11/17.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "VisitorCell.h"

@implementation VisitorCell

- (void)awakeFromNib {
    _avatar.layer.cornerRadius = _avatar.width / 2;
    _avatar.image = [UIImage imageNamed:@"门铃_07"];
}

/**
 *  选中操作
 *
 *  @param selected 是否选中
 *  @param animated 是否动画
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

/**
 *  数据填充
 *
 *  @param visitor 访客信息模型
 */
- (void)setVisitor:(VisitorModel *)visitor {
    if (_visitor != visitor) {
        _visitor = visitor;
        [self reloadData];
    }
}

- (void)reloadData {
    self.dateLabel.text = self.visitor.startDateTime;
    self.timeLabel.text = self.visitor.endDateTime;
}


@end
