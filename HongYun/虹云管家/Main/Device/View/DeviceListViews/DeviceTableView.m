//
//  DeviceTableView.m
//  HongYunBell
//
//  Created by imac on 15/11/10.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "DeviceTableView.h"
#import "LongPressSettingView.h"
#define kDeviceCellIdentifier @"DeviceCellIdentifier"

@interface DeviceTableView ()

@property (nonatomic, strong)UIView *configurationView;
@property (nonatomic, strong)LongPressSettingView *longPressSettingView;

@end

@implementation DeviceTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        [self initTable];
    }
    return self;
}
/**
 *  初始化视图
 */
- (void)initTable {
    self.dataSource = self;
    self.delegate = self;
    self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:kDeviceCellIdentifier];
    
    //隐藏多余分割线
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    [self setTableFooterView:view];
    
    //添加长按手势
    [self addLongPressGesture];
}

#pragma mark - UITableViewDataSource
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _deviceArray.count;
}
//生成组视图
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"identifier";
    DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"DeviceTableViewCell"
                                                       owner:nil
                                                     options:nil];
        cell = [array lastObject];
    }
    //cell内容填充
    DeviceModel *device = _deviceArray[indexPath.row];
    cell.device = device;

    return  cell;
}

#pragma mark - UITableViewDelegate
//组视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125 / 2;
}
//选中试图
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DeviceModel *model = _deviceArray[indexPath.row];

    if ([model.type isEqualToString:@"RING"]) {
        NSLog(@"进入门铃");
        BellViewController *bellVc = [[BellViewController alloc] init];
        bellVc.deviceModel = model;
        [self.controller.navigationController pushViewController:bellVc animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 长按设备操作

/**
 *  添加长按手势
 */
- (void)addLongPressGesture {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    longPress.minimumPressDuration = 0.6f;
    [self addGestureRecognizer:longPress];
}
/**
 *  长按操作
 *
 *  @param gesture 手势
 */
- (void)longPressAction:(UIGestureRecognizer *)gesture {

    //长按的点坐标
    CGPoint point = [gesture locationInView:self];
    //获取点击路径
    NSIndexPath *indexPath = [self indexPathForRowAtPoint:point];
    //取出Model
    DeviceModel *device = self.deviceArray[indexPath.row];
    //回调Block
    if (gesture.state == UIGestureRecognizerStateBegan && self.longPressAction) {
        self.longPressAction (device);
    }
}

@end
