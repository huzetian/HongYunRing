//
//  MainTabBarController.m
//  HongYunBell
//
//  Created by imac on 15/11/11.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "MainTabBarController.h"
#import "TabBarBackgroundView.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (instancetype)init {
    
    if (self = [super init]) {
        
        //先设置子控制器
        [self createSubControllers];
        
        //再设置TabBar
        [self createTabBar];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 *  设置子控制器
 */
- (void)createSubControllers {
    
    NSArray *array = @[@"DeviceListController", @"UserInfo"];
    
    NSMutableArray *arrayOfVC = [NSMutableArray array];
    
    for (NSString *name in array) {
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:name bundle:nil];
        
        BaseViewController *baseViewCon = [storyBoard instantiateInitialViewController];
        
        [arrayOfVC addObject:baseViewCon];
    }
    
    self.viewControllers = arrayOfVC;
    
}

/**
 *  设置TabBar按钮
 */
- (void)createTabBar {
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
    //移除TabBarButton
    for (UIView *view in self.tabBar.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class]) {
            [view removeFromSuperview];
        }
    }
    
    
    //创建背景
    TabBarBackgroundView *mainTabBarView = [[TabBarBackgroundView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
    [self.tabBar addSubview:mainTabBarView];
    
    //创建自定义按钮
    NSArray *arrayOfImageName = @[@"我的设备",
                                  @"个人中心"];
    NSArray *arrayOfTitle = @[@"设备列表",
                              @"个人中心"];
    CGFloat buttonWidth = kScreenWidth / arrayOfImageName.count;
    
    for (int i = 0; i < arrayOfImageName.count; i++) {
        TabBarButton *button = [[TabBarButton alloc] initWithFrame:CGRectMake(i * buttonWidth, 0, buttonWidth, 49)];
        [button setTitle:arrayOfTitle[i]
                   image:[UIImage imageNamed:arrayOfImageName[i]]];
        [button addTarget:self
                   action:@selector(_selectAction:)
         forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
        [mainTabBarView addSubview:button];
    }
    
}

/**
 *  选中图片移动操作
 *
 *  @param button 触发按钮
 */
- (void)_selectAction:(UIButton *)button {
    self.selectedIndex = button.tag - 100;
}

@end
