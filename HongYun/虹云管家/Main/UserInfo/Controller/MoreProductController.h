//
//  MoreProductController.h
//  HongYunBell
//
//  Created by imac on 15/11/13.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "BaseViewController.h"
#import "UserInfoCell.h"

@interface MoreProductController : BaseViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)NSArray *titleArray;
@property (nonatomic, strong)NSArray *imageArray;

@end
