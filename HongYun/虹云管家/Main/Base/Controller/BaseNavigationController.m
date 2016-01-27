//
//  BaseNavigationController.m
//  HongYunBell
//
//  Created by imac on 15/11/10.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "BaseNavigationController.h"
#import "Reachability.h"
#import "UserManager.h"
@interface BaseNavigationController ()

@property (nonatomic, strong)UIView *statusBar;
@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBarBackground];
    
    //监听网络环境改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];

}

//网络状态设置statusBar
- (void)viewWillAppear:(BOOL)animated {
    
    NetworkStatus status = [UserManager shareInstance].currentReachabilityStatus;
    
    [self setNetworkStatusBarHidden:(status != NotReachable)];
}
/**
 *  创建并设置网络状态栏
 *
 *  @param hidden 是否隐藏
 */
- (void)setNetworkStatusBarHidden:(BOOL)hidden {
    
    if (self.statusBar) {
        self.statusBar.hidden = hidden;
        return;
    }
    //状态栏view
    self.statusBar = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 25)];
    self.statusBar.backgroundColor = ColorMakeRGB(239, 239, 239);
    [self.view addSubview:self.statusBar];
   
    //图片imageView
    CGFloat imageWidth = 15;
    CGFloat leftSpacing = 20;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageWidth, imageWidth)];
    imageView.frame = CGRectMake(leftSpacing, (self.statusBar.height - imageWidth) / 2, imageView.width, imageView.width);
    imageView.image = [UIImage imageNamed:@"感叹"];
    [self.statusBar addSubview:imageView];
   
    //文字lable
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 5, 0, 200, self.statusBar.height)];
    label.text = @"网络连接不可用";
    label.font = [UIFont systemFontOfSize:12.0f];
    [self.statusBar addSubview:label];
    
    self.statusBar.hidden = hidden;
}

#pragma mark -reachabilityChanged 网络环境变化
-(void)reachabilityChanged:(NSNotification *)note {
    
    Reachability *reachability = [note object];
    NetworkStatus status = reachability.currentReachabilityStatus;

    [self setNetworkStatusBarHidden:(status != NotReachable)];
}


/**
 *  设置navigationBar背景
 */
- (void)setTabBarBackground {
    
    //圆角矩形-1@2x : 345 x 47
    UIImage *barBackgroundImage = [UIImage imageNamed:@"圆角矩形-1"];
    CGFloat x = 10;
    CGImageRef imageRef = CGImageCreateWithImageInRect([barBackgroundImage CGImage], CGRectMake(x, 0, 345 - x * 2, 64));
    barBackgroundImage = [UIImage imageWithCGImage:imageRef];
    [self.navigationBar setBackgroundImage:barBackgroundImage forBarMetrics:UIBarMetricsDefault];
    //去除navigationBar底部的阴影
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    
}
@end
