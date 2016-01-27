//
//  BellViewController.m
//  HongYunBell
//
//  Created by ZTM on 15/11/16.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "BellViewController.h"
#import "VisitorViewController.h"
#import "WarningVViewController.h"
//#import "ConfigurationViewController.h"

@interface BellViewController ()

@property (nonatomic, strong)UILabel *deviceStatus;

@end

@implementation BellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"门铃首页"];
    
    [self createSubviews];
    
}
- (void)viewWillAppear:(BOOL)animated {

}

/**
 *  设置模型，改变状态
 *
 *  @param deviceModel 设备模型
 */
- (void)setDeviceModel:(DeviceModel *)deviceModel {
    if (_deviceModel != deviceModel) {
        _deviceModel = deviceModel;
        if (self.deviceStatus) {
            NSArray *status = @[@"已连接到云端", @"设备未连接"];
            NSString *statusString = [NSString stringWithFormat:@"%@-%@", self.deviceModel.nickName, status[self.deviceModel.status]];
            self.deviceStatus.text = statusString;
        }
    }
}

/**
 *  创建子视图
 */
- (void)createSubviews {
    /*
     头部视图
     */
    UIImage *barBackground = [UIImage imageNamed:@"圆角矩形-1"];
    CGFloat x = 10;
    CGImageRef imageRef = CGImageCreateWithImageInRect([barBackground CGImage], CGRectMake(x, 65, 345 - x * 2, 100));
    barBackground = [UIImage imageWithCGImage:imageRef];
    
    //头部背景试图
    UIImageView *headerBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, (kScreenHeight - 64) / 2 - 35)];
    headerBackground.image = barBackground;
    [self.view addSubview:headerBackground];
    //头像
    UIImageView *userAvatar = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 130) / 2, 45, 130, 130)];
    userAvatar.image = [UIImage imageNamed:@"门铃_07"];
    [headerBackground addSubview:userAvatar];
    
    NSArray *status = @[@"已连接到云端", @"设备未连接"];
    //设备状态
    self.deviceStatus = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 150) / 2, userAvatar.bottom, 150, 21)];
    if (self.deviceModel) {
        NSString *statusString = [NSString stringWithFormat:@"%@-%@", self.deviceModel.devID, status[self.deviceModel.status]];
        self.deviceStatus.text = statusString;
    }
    self.deviceStatus.font = [UIFont boldSystemFontOfSize:15.0];
    self.deviceStatus.textColor = [UIColor whiteColor];
    self.deviceStatus.textAlignment = NSTextAlignmentCenter;
    [headerBackground addSubview:self.deviceStatus];
    
    /*
     状态栏
     */
    UIView *statusBar = [[UIView alloc] initWithFrame:CGRectMake(0, headerBackground.bottom, kScreenWidth, 30)];
    statusBar.backgroundColor = [UIColor colorWithRed:38 / 255.0 green:150 / 255.0 blue:200 / 255.0 alpha:1.0];
    [self.view addSubview:statusBar];
    //电量Label
    UILabel *deviceBetteryLabel = [[UILabel alloc] initWithFrame:CGRectMake(19, (statusBar.height - 21) / 2, 60, 21)];
    deviceBetteryLabel.text = @"设备电量";
    deviceBetteryLabel.font = [UIFont boldSystemFontOfSize:12.0];
    deviceBetteryLabel.textColor = [UIColor whiteColor];
    [statusBar addSubview:deviceBetteryLabel];
    //电量图标
    UIImageView *deviceBetteryImage = [[UIImageView alloc] initWithFrame:CGRectMake(deviceBetteryLabel.right, deviceBetteryLabel.center.y - 5, 20, 10)];
    deviceBetteryImage.image = [UIImage imageNamed:@"电量"];
    [statusBar addSubview:deviceBetteryImage];
    //升级图标
    UIButton *updateButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 80, (statusBar.height - 20) / 2, 80, 20)];
    [updateButton setBackgroundImage:[UIImage imageNamed:@"点击升级"] forState:UIControlStateNormal];
    [updateButton setTitle:@"   点击升级" forState:UIControlStateNormal];
    updateButton.titleLabel.textColor = [UIColor whiteColor];
    updateButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    [statusBar addSubview:updateButton];
    
    
    NSArray *buttonImages = @[@"访客", @"告警", @"门铃_25"];
    NSArray *buttonTitles = @[@"访客信息", @"告警信息", @"门铃设置"];
    /*
     按钮
     */
    CGFloat buttonWidth = 100;
    CGFloat spacing = (kScreenWidth - buttonWidth * 3) / 6;
    for (int i = 0; i < 3; i++) {
        //按钮
        UIButton *bellButton = [[UIButton alloc] initWithFrame:CGRectMake(spacing + (buttonWidth + spacing * 2) * i, statusBar.bottom + 60, buttonWidth, 100)];
        [bellButton setImage:[UIImage imageNamed:@"门铃_34"] forState:UIControlStateNormal];
        bellButton.tag = 100 + i;
        [bellButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bellButton];
        //图片
        UIImageView *buttonImage = [[UIImageView alloc] initWithFrame:CGRectMake((bellButton.width - 25) / 2, 30, 25, 25)];
        buttonImage.image = [UIImage imageNamed:buttonImages[i]];
        [bellButton addSubview:buttonImage];
        //文本
        UILabel *buttonLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, buttonImage.bottom, buttonWidth, 21)];
        buttonLabel.text = buttonTitles[i];
        buttonLabel.textAlignment = NSTextAlignmentCenter;
        buttonLabel.textColor = [UIColor colorWithRed:101 / 255.0 green:101 / 255.0 blue:101 / 255.0 alpha:1.0];
        buttonLabel.font = [UIFont boldSystemFontOfSize:12.0];
        [bellButton addSubview:buttonLabel];
    }
    
}

#pragma mark - 按钮操作
/**
 *  push下级界面
 *
 *  @param button 触发按钮
 */
- (void)buttonAction:(UIButton *)button {
    if (button.tag == 100) {
        NSLog(@"访客信息");
        VisitorViewController *visitorVC = [[VisitorViewController alloc] init];
        visitorVC.deviceModel = self.deviceModel;
        visitorVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:visitorVC animated:YES];
    }
    else if (button.tag == 101) {
        NSLog(@"告警信息");
        WarningVViewController *warningVC = [[WarningVViewController alloc] init];
        warningVC.deviceModel = self.deviceModel;
        warningVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:warningVC animated:YES];
    }
    else if (button.tag == 102) {
        NSLog(@"门铃设置");
//        ConfigurationViewController *configVC = [[ConfigurationViewController alloc] init];
//        configVC.deviceModel = self.deviceModel;
//        configVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:configVC animated:YES];
    }
}


@end
