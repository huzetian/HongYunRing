//
//  BaseViewController.h
//  HongYunBell
//
//  Created by imac on 15/11/10.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewDataSource.h"
#import "RequestMethod.h"
#import "UserManager.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong)UIButton *maskView;                //遮罩视图

@property (nonatomic, strong)UIImageView *loginView;            //登陆条

/**
 *  自定义标题
 *
 *  @param title 标题
 */
- (void)setTitle:(NSString *)title;

/**
 *  创建导航栏右侧添加按钮
 */
//- (void)createRightButtonItem;

/**
 *  登陆、登出时调用，重新加载视图
 *
 *  @param noti 通知
 */
- (void)reloadViewController:(NSNotification *)noti;


/************************ 登陆视图 ************************/
#pragma mark - * 登陆

/**
 *  弹出登陆视图
 */
- (void)presentLoginVC;


/**
 *  创建登陆条视图
 *
 *  方法中需要将试图添加到 window 上，所以该方法只能在 self.view 出现（willappear）之后调用，使试图覆盖 self.view 上，否则发生层次的错乱。
 *
 *  @param hidden 是否隐藏
 */
- (void)setLoginViewHidden:(BOOL)hidden;


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
- (void)setMaskviewHidden:(BOOL)hidden;

/**
 *  遮罩视图点击动作
 *
 *  @param button 遮罩视图
 */
- (void)maskTapAction:(UIButton *)maskView;

/************************ 获取window ************************/
#pragma mark - 获取window
/**
 *  获取当前应用的Window
 */
- (UIWindow *)appWindow;

@end
