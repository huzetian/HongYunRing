//
//  VisitorCell.h
//  HongYunBell
//
//  Created by ZZ on 15/11/17.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisitorModel.h"
@interface VisitorCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, strong)VisitorModel *visitor;

@end
