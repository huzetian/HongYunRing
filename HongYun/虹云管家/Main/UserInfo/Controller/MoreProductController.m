//
//  MoreProductController.m
//  HongYunBell
//
//  Created by imac on 15/11/13.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "MoreProductController.h"
#define kUserCellIdentity @"identifier"

@interface MoreProductController ()

@end

@implementation MoreProductController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"更多产品"];
    [self initTableView];
}
- (void)initTableView {
    //frame
    _tableView.frame = self.view.bounds;
    //数据源、代理
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //注册单元格
    [_tableView registerNib:[UINib nibWithNibName:@"UserInfoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kUserCellIdentity];
    //隐藏多余分割线
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:view];
    //数据数组
    _titleArray = @[@"更多虹云产品", @"推荐给更多朋友", @"帮助与反馈", @"检查新版本"];
    _imageArray = @[@"更多产品图标", @"设备分享图标", @"帮助与反馈图标", @"新版本按钮"];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

//生成组视图
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = kUserCellIdentity;
    UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    //cell内容填充
    cell.cellTextLabel.text = _titleArray[indexPath.row];
    cell.cellImageView.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    return  cell;
}



@end
