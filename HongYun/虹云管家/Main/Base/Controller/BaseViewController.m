//
//  BaseViewController.m
//  HongYunBell
//
//  Created by imac on 15/11/10.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "BaseViewController.h"
#import "TableViewDataSource.h"
#import "Reachability.h"
#import "CommunicateController.h"
#import "AppDelegate.h"

#define kAnimationDuration 0.3

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏为不透明
    self.navigationController.navigationBar.translucent = NO;
    
    //创建返回按钮（根页不放置）
    [self createBackButtonItem];
    
    
    //监听登陆、登出的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadViewController:) name:loginNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadViewController:) name:logoutNotification object:nil];
    
}

- (void)dealloc {
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:loginNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:logoutNotification object:nil];
}

#pragma mark - 方法封装
/**
 *  登陆、登出时重新加载
 *
 *  @param noti 通知
 */
- (void)reloadViewController:(NSNotification *)noti {
    NSLog(@"%@ reload", [self class]);
    /**
     *  子类覆写方法
     */
}

/**
 *  自定义标题
 *
 *  @param title 标题
 */
- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    
    UILabel *_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont fontWithName:@"FZLTHJW" size:30.0f];
    _titleLabel.text = title;
    _titleLabel.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    //将这个label 设置到navigationItem去
    self.navigationItem.titleView = _titleLabel;
}

/**
 *  创建返回按钮
 */
- (void)createBackButtonItem {
    
    //判断是否是根控制器
    if (self.navigationController.viewControllers.count == 1) {
        return;
    }
    
    UIImage *backImage = [UIImage imageNamed:@"返回"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 7, 13)];
    [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(backAction:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backButtonItem];
    
}

///**
// *  创建导航栏右侧添加按钮
// */
//- (void)createRightButtonItem {
//    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    [rightButton setBackgroundImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
//    [rightButton addTarget:self action:@selector(deviceAddAction:) forControlEvents:UIControlEventTouchUpInside];
//
//    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//
//    self.navigationItem.rightBarButtonItem = rightButtonItem;
//}

/**
 *  弹出登陆视图
 */
- (void)presentLoginVC {
    //登陆视图控制器
    UINavigationController *loginNaviVC = [[UIStoryboard storyboardWithName:@"LoginViewController" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    
    //模态视图弹出登陆界面
    [self presentViewController:loginNaviVC animated:YES completion:nil];
}

/************************ 登陆视图 ************************/
#pragma mark - * 登陆条
/**
 *  创建登陆条视图，方法中需要将试图添加到 window 上，所以该方法只能在 self.view 出现（willappear）之后调用，使试图覆盖 self.view 上，否则发生层次的错乱。
 *
 *  @param hidden 是否隐藏
 */
- (void)setLoginViewHidden:(BOOL)hidden {
    
    //创建遮罩视图
    [self setMaskviewHidden:hidden];
    //创建登陆条
    if (self.loginView == nil) {
        
        self.loginView = [[UIImageView alloc] initWithFrame:CGRectMake(10, kScreenHeight, kScreenWidth - 20, 0)];
        self.loginView.height = self.loginView.width / 366 * 88;
        self.loginView.image = [UIImage imageNamed:@"请先登录_03_1"];
        self.loginView.userInteractionEnabled = YES;
        
        //获取window。（self.view.window取不到）？
        [[self appWindow] addSubview:self.loginView];
        
        //取消按钮
        UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, _loginView.height / 2, _loginView.width / 2, self.loginView.height / 2)];
        [cancel addTarget:self action:@selector(loginCancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [_loginView addSubview:cancel];
        
        //登陆按钮
        UIButton *login = [[UIButton alloc] initWithFrame:CGRectMake(self.loginView.width / 2, self.loginView.height / 2, self.loginView.width / 2, self.loginView.height / 2)];
        [login addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.loginView addSubview:login];
    }
    //出现登陆条
    if (!hidden) {
        [self.appWindow addSubview:self.loginView];
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.loginView.top = kScreenHeight - 150;
        }];
    }
    //隐藏登陆条
    else {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.loginView.top = kScreenHeight;
        } completion:^(BOOL finished) {
            [self.loginView removeFromSuperview];
        }];
    }
}

/************************ 遮罩视图 ************************/
#pragma mark - * 遮罩视图
/**
 *  添加遮罩视图
 *
 *  @param hidden 是否隐藏
 *
 *  添加单击动作，子类复写 maskTapAction: 方法实现。
 *  在需要遮罩视图的创建方法里调用该方法。
 */
- (void)setMaskviewHidden:(BOOL)hidden {
    
    if (self.maskView == nil && hidden) {
        return;
    }
    
    if (self.maskView == nil) {
        self.maskView = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.maskView.backgroundColor = ColorMakeRGBA(0, 0, 0, 0.6);
        self.maskView.alpha = 0.0;
        [self.maskView addTarget:self action:@selector(maskTapAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    //移除遮罩视图
    if (hidden) {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.maskView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [self.maskView removeFromSuperview];
        }];
    }
    //添加遮罩视图
    else {
        [[self appWindow] addSubview:self.maskView];
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.maskView.alpha = 1.0f;
        }];
    }
}
/************************ 按钮操作 ************************/
#pragma mark - 按钮操作
/**
 *  遮罩视图点击动作
 *
 *  @param button 遮罩视图
 */
- (void)maskTapAction:(UIButton *)maskView {
    if (self.loginView) {
        [self setLoginViewHidden:YES];
    }
}

/**
 *  弹出登陆页面
 *
 *  @param button 登陆按钮
 */
- (void)loginAction:(UIButton *)button {
    
    //隐藏登陆条
    [self setLoginViewHidden:YES];
    
    //弹出登陆视图
    [self presentLoginVC];
}
- (void)loginCancelAction:(UIButton *)button {
    //隐藏登陆条
    [self setLoginViewHidden:YES];
}
/**
 *  返回操作
 *
 *  @param button 触发按钮
 */
- (void)backAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}
///**
// *  设备添加动作
// *
// *  @param button 触发按钮
// */
//- (void)deviceAddAction:(UIButton *)button {
//    //子类覆写
//    NSLog(@"添加设备");
//}

/************************ 获取window ************************/
#pragma mark - 获取window
/**
 *  获取当前应用的Window
 */
- (UIWindow *)appWindow {
    //获取window。（self.view.window取不到）？
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = appdele.window;
    return window;
}

@end
