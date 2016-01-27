//
//  DeviceAddingView.m
//  HongYunBell
//
//  Created by imac on 15/11/12.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "DeviceAddingView.h"
#import "AddingItem.h"
#import "SearchViewController.h"

@implementation DeviceAddingView

/**
 *  初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self createItems];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

/**
 *  创建子视图
 */
- (void)createItems {

    //添加门铃
    AddingItem *addBell = [[AddingItem alloc] initWithFrame:CGRectMake(kScreenWidth / 15, kScreenHeight / 668 * 25, kScreenWidth / 5 * 2, kScreenWidth / 5 * 2)];
    [addBell setItemWithPattern:[UIImage imageNamed:@"门锁初始配置_25"] title:@"添加门铃"];
    [addBell.itemButton addTarget:self action:@selector(addDeviceAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBell];
    
    //添加路由器
    AddingItem *addRoute = [[AddingItem alloc] initWithFrame:CGRectMake(kScreenWidth / 375 * 201, kScreenHeight / 668 * 25, kScreenWidth / 5 * 2, kScreenWidth / 5 * 2)];
    [addRoute setItemWithPattern:[UIImage imageNamed:@"门锁初始配置_07.png"] title:@"添加路由器"];
    [self addSubview:addRoute];
    
    //添加门锁
    AddingItem *addLock = [[AddingItem alloc] initWithFrame:CGRectMake(kScreenWidth / 15, addBell.bottom + kScreenWidth / 15, kScreenWidth / 5 * 2, kScreenWidth / 5 * 2)];
    [addLock setItemWithPattern:[UIImage imageNamed:@"门锁初始配置_15.png"] title:@"添加门锁"];
    [self addSubview:addLock];
    
    //添加网关
    AddingItem *addGateway = [[AddingItem alloc] initWithFrame:CGRectMake(kScreenWidth / 375 * 201, addBell.bottom + kScreenWidth / 15, kScreenWidth / 5 * 2, kScreenWidth / 5 * 2)];
    [addGateway setItemWithPattern:[UIImage imageNamed:@"门锁初始配置_10.png"] title:@"添加网关"];
    [self addSubview:addGateway];
}

- (void)addDeviceAction:(UIButton *)button {
    //出现搜索界面
    SearchViewController *searchVC = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:[NSBundle mainBundle]];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.controller.navigationController pushViewController:searchVC animated:YES];
}

@end
