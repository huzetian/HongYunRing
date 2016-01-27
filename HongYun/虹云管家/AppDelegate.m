//
//  AppDelegate.m
//  虹云管家
//
//  Created by ZZ on 16/1/22.
//  Copyright © 2016年 HongYun. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchPage.h"
#import "CommunicateController.h"

@interface AppDelegate () <UserManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //设置window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    //设置UserManager，建立连接
    self.userManager = [UserManager shareInstance];
    self.userManager.delegate = self;
    [self.userManager buildConnectionCompletion:nil];
    [self.userManager loginByUserDefaultCompletion:nil];
    
    //登陆界面
    LaunchPage *launch = [[LaunchPage alloc] init];
    [self.window setRootViewController:launch];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/************************ UserManagerDelegate ************************/

#pragma mark - UserManagerDelegate
/**
 *  登陆成功
 *
 *  @param user UserManager
 */
- (void)userDidLogIn:(UserManager *)user {
    NSLog(@"登陆成功");
    [[NSNotificationCenter defaultCenter] postNotificationName:loginNotification object:nil];
}
/**
 *  退出登录
 *
 *  @param user UserManager
 */
- (void)userDidLogOut:(UserManager *)user {
    NSLog(@"退出登录");
    [[NSNotificationCenter defaultCenter] postNotificationName:logoutNotification object:nil];
}

/**
 *  获取门铃呼叫
 *
 *  @param user   UserManager
 *  @param result 获取呼叫数据
 */
- (void)userGetCallRequest:(UserManager *)user result:(NSDictionary *)result {
    
    NSLog(@"获取呼叫");
    CommunicateController *commuicateVC = [CommunicateController shareInstance];
    commuicateVC.dataDic = result;
    UIViewController *rootVC = self.window.rootViewController;
    
    //判断页面是否已经出现
    if (!commuicateVC.isPresented) {
        //未出现则弹出视图
        [rootVC presentViewController:commuicateVC animated:YES completion:nil];
    }
    
}

@end
