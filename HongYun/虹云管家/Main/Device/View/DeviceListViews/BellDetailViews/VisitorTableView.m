//
//  VisitorTableView.m
//  HongYunBell
//
//  Created by ZZ on 15/11/17.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "VisitorTableView.h"

#define kCellVisitorIdentifier @"visitorCell"

@interface VisitorTableView ()


@property (nonatomic, strong)UITextField *searchField;      //搜索栏
@property (nonatomic, strong)PMCalendarController *pmCC;    //日历

@end

@implementation VisitorTableView
/**
 *  获取数据
 *
 *  @param dataArray 会话数组
 */
- (void)setDataArray:(NSMutableArray *)dataArray {
    if (_dataArray != dataArray) {
        _dataArray = dataArray;
        [self reloadData];
    }
}

/**
 *  初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        [self initTable];
    }
    return self;
}
- (void)initTable {
    self.dataSource = self;
    self.delegate = self;
    self.tableHeaderView = [self createTabelHeader];
    [self registerNib:[UINib nibWithNibName:@"VisitorCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kCellVisitorIdentifier];
}

/**
 *  自定义头视图
 */
- (UIView *)createTabelHeader {
    //button
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    searchButton.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    [searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    //textField
    _searchField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 40, 30)];
    _searchField.center = searchButton.center;
    _searchField.borderStyle = UITextBorderStyleRoundedRect;
    _searchField.userInteractionEnabled = NO;
    _searchField.placeholder = @"请输入日期搜索...";
    _searchField.font = [UIFont boldSystemFontOfSize:15.0];
    [searchButton addSubview:_searchField];
    //imageView
    UIImageView *searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(_searchField.width - 30, (_searchField.height - 20) / 2, 20, 20)];
    searchImage.image = [UIImage imageNamed:@"搜索"];
    [_searchField addSubview:searchImage];
    
    return searchButton;
}
#pragma mark - UITableDataSource
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_dataArray objectAtIndex:section] count];
}
//单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = kCellVisitorIdentifier;
    VisitorCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    VisitorModel *visitor = [[_dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//    VisitorModel *visitor = self.dataArray[indexPath.row];
    if (visitor == nil) {
        NSLog(@"visitor model error");
        return nil;
    }
    [cell setVisitor:visitor];
//    cell.dateLabel.text = visitor.date;
//    cell.timeLabel.text = visitor.time;
    return cell;
}
#pragma mark - UITableDelegate
//组头试图：日期
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    VisitorModel *visitor = [[_dataArray objectAtIndex:section] objectAtIndex:0];

    if (visitor == nil) {
        NSLog(@"model error");
        return nil;
    }
    
    //编辑视图
    UIView *sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    sectionHeader.backgroundColor = ColorMakeRGB(252, 252, 253);
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, (sectionHeader.height - 21) / 2, kScreenWidth, 21)];
    dateLabel.text = visitor.date;
    dateLabel.font = [UIFont boldSystemFontOfSize:17.0];
    dateLabel.textColor = ColorMakeRGB(89, 89, 89);
    
    [sectionHeader addSubview:dateLabel];
    return sectionHeader;
}
//组头试图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
//组尾视图高度，隐藏
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
//单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

#pragma mark - ButtonAction
//打开日历
- (void)searchAction:(UIButton *)button {
    
    NSLog(@"搜索\t %p", _pmCC);
    _pmCC = [[PMCalendarController alloc] init];
    _pmCC.delegate = self;
    _pmCC.mondayFirstDayOfWeek = YES;
    [_pmCC presentCalendarFromRect:CGRectMake(0, 0, kScreenWidth, button.height)
                            inView:[button superview]
          permittedArrowDirections:PMCalendarArrowDirectionAny
                          animated:YES];
    [self calendarController:_pmCC didChangePeriod:_pmCC.period];
}
#pragma mark - PMCalendarControllerDelegate
- (void)calendarController:(PMCalendarController *)calendarController didChangePeriod:(PMPeriod *)newPeriod
{
    _searchField.placeholder = [NSString stringWithFormat:@"%@ - %@"
                                , [newPeriod.startDate dateStringWithFormat:@"dd-MM-yyyy"]
                                , [newPeriod.endDate dateStringWithFormat:@"dd-MM-yyyy"]];
}

@end
