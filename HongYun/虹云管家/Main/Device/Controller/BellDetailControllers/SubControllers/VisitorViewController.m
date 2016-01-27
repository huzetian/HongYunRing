//
//  VisitorViewController.m
//  HongYunBell
//
//  Created by ZZ on 15/11/17.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "VisitorViewController.h"
#import <CoreData/CoreData.h>


#define kCellVisitorIdentifier @"visitorCell"

@interface VisitorViewController ()

@property (nonatomic, strong)NSMutableArray *dataArray;     //数据源数组
@property (nonatomic, strong)VisitorTableView *table;       //表视图

@end

@implementation VisitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createRightButtonItem];
    [self setTitle:@"访客信息"];
    
    [self createTable];
    
    //获取最近三天的日期
    NSString *startTime = nil;
    NSString *endTime = nil;
    [self getDate:6 startDate:&startTime endTime:&endTime];
    
    //由获取的日期请求数据
    [self getDataStartTime:startTime endTime:endTime];
}

/**
 *  获取起始日期，传址调用
 *
 *  @param startTime 开始日期
 *  @param endTime   结束日期
 */
- (void)getDate:(NSInteger)days startDate:(NSString **)startTime endTime:(NSString **)endTime {
    NSTimeInterval timeInterval = 60 * 60 * 24 * days;
    NSDate *start = [NSDate dateWithTimeIntervalSinceNow:-timeInterval];
    NSDate *end = [NSDate dateWithTimeIntervalSinceNow:0];
    *startTime = [[start description] substringToIndex:19];
    *endTime = [[end description] substringToIndex:19];
}

/**
 *  请求：获取访客信息
 *
 *  @param startTime 起始时间
 *  @param endTime   结束时间
 */
- (void)getDataStartTime:(NSString *)startTime endTime:(NSString *)endTime {
    
    [RequestMethod requestGetVisitorInfoWithDevID:self.deviceModel.devID startTime:startTime endTime:endTime success:^(NSDictionary *result) {
        
        NSLog(@"%@", result);
        NSDictionary *resultDic = [result objectForKey:@"result"];
        NSArray *visitorSessions = [resultDic objectForKey:@"visitorSessions"];
        self.dataArray = [NSMutableArray array];
        for (NSDictionary *visitorSession in visitorSessions) {
            
            VisitorModel *visitor = [[VisitorModel alloc] initWithDataDic:visitorSession];
            
            [self.dataArray addObject:visitor];
        }
        
        //按日期排序（倒序）
        self.dataArray = [self sequenceSessions:self.dataArray];

        if (self.table) {
            self.table.dataArray = self.dataArray ;
        }
    } failure:^(NSError *error) {
        
    }];
    
}

/**
 *  对信息按照时间进行排序
 */
- (NSMutableArray *)sequenceSessions:(NSArray *)sessions {
    
    if (sessions.count == 0) {
        return nil;
    }
    NSMutableArray *sequenceArray = [NSMutableArray array];
    
    //取第一个（最晚的）的日期
    VisitorModel *visitor = (VisitorModel *)sessions[sessions.count - 1];
    NSString *date = visitor.date;
    
    //同一天的数组
    NSMutableArray *dailySessions = [NSMutableArray array];
    
    //倒序遍历
    for (NSInteger index = sessions.count - 1; index >= 0; index--) {
        VisitorModel *visitor = (VisitorModel *)sessions[index];
        //同一天的存入数组
//        NSLog(@"date : %@, visitor date : %@", date, visitor.date);
        if ([date isEqualToString:visitor.date]) {
            [dailySessions addObject:visitor];
        }
        //不是同一天则将dailySession存入，并初始化
        else {
            [sequenceArray addObject:dailySessions];
            date = [visitor.date copy];
            dailySessions = [NSMutableArray array];
        }
    }
    
    if (dailySessions.count != 0) {
        [sequenceArray addObject:dailySessions];
    }
    
    return sequenceArray;
}

/**
 *  创建表视图
 */
- (void)createTable {
    self.table = [[VisitorTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.table];
}

#pragma mark - NavigationBarButton
/**
 *  创建导航栏右侧编辑按钮
 */
- (void)createRightButtonItem {
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    rightButton.imageView.hidden = YES;
    [rightButton addTarget:self action:@selector(editTabel:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}
/**
 *  进入表视图编辑模式
 *
 *  @param button 触发按钮
 */
-(void)editTabel:(UIButton *)button {
    
    if (!button.selected) {
        [button setTitle:nil forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"告警信息2_03"] forState:UIControlStateNormal];
    }
    else {
        [button setTitle:@"编辑" forState:UIControlStateNormal];
        [button setImage:nil forState:UIControlStateNormal];
    }
    [_table setEditing:!button.selected animated:YES];
    button.selected = !button.selected;
}
@end
