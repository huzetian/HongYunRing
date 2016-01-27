//
//  VisitorTableView.h
//  HongYunBell
//
//  Created by ZZ on 15/11/17.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisitorCell.h"
#import "VisitorModel.h"
#import "PMCalendar.h"
@interface VisitorTableView : UITableView <UITableViewDataSource, UITableViewDelegate, PMCalendarControllerDelegate>

@property (nonatomic, strong)NSMutableArray *dataArray;     //数据源数组

@end
