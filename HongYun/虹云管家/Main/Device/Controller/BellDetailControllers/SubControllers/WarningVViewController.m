//
//  WarningVViewController.m
//  HongYunBell
//
//  Created by ZZ on 15/11/17.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "WarningVViewController.h"

@interface WarningVViewController ()

@property (nonatomic, strong)NSMutableArray *dataArray;     //数据源数组
@property (nonatomic, strong)VisitorTableView *table;       //表视图


@end

@implementation WarningVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"告警信息"];
    
    [self createTable];
    
    NSString *startTime = nil;
    NSString *endTime = nil;
    [self getStartDate:&startTime endTime:&endTime];
    
    [self getDataStartTime:startTime endTime:endTime];
}

- (void)getStartDate:(NSString **)startTime endTime:(NSString **)endTime  {
    NSDate *start = [NSDate dateWithTimeIntervalSinceNow:-(60 * 60 *24 *3)];
    NSDate *end = [NSDate dateWithTimeIntervalSinceNow:0];
    *startTime = [[start description] substringToIndex:19];
    *endTime = [[end description] substringToIndex:19];
}
/**
 *  请求：获取警告信息
 *
 *  @param startTime 起始时间
 *  @param endTime   结束时间
 */
- (void)getDataStartTime:(NSString *)startTime endTime:(NSString *)endTime {
    
    [RequestMethod requestGetWarningInfoWithDevID:self.deviceModel.devID startTime:startTime endTime:endTime success:^(NSDictionary *result) {
        
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
        NSLog(@"date : %@, visitor date : %@", date, visitor.date);
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
 *  创建TableView
 */
- (void)createTable {
    self.table = [[VisitorTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:self.table];
}


@end
