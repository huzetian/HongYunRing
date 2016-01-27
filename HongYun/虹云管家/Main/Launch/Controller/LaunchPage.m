//
//  LaunchPage.m
//  HongYunBell
//
//  Created by imac on 15/11/10.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "LaunchPage.h"

@interface LaunchPage ()

@property (nonatomic, strong)UIViewController *mainVC;

@property (strong, nonatomic)UIImageView *background;

@end

@implementation LaunchPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //背景
    self.background = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.background.image = [UIImage imageNamed:@"启动页@1242.png"];
    [self.view addSubview:self.background];
    
    self.mainVC = [[MainTabBarController alloc] init];
    //3s后跳转
    [self performSelector:@selector(showMainViewcontroller)
               withObject:nil
               afterDelay:0.5];
}

/**
 *  跳转到主视图
 */
- (void)showMainViewcontroller {
        
    [self.view.window setRootViewController:self.mainVC];
}

@end
