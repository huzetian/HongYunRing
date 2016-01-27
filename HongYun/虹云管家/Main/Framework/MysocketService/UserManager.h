//
//  UserManager.h
//  HongYunBell
//
//  Created by ZZ on 15/11/30.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MySocket.h"
#import "MySocketRequest.h"
#import "RequestMethod.h"
#import "UserModel.h"

//协议声明
@protocol UserManagerDelegate;
typedef void(^ConnectCompletion)();

@interface UserManager : NSObject <GCDAsyncSocketDelegate>

@property (nonatomic, strong)UserModel *user;

@property (nonatomic, strong)MySocket *mySocket;
@property (nonatomic, assign)id<UserManagerDelegate>delegate;

@property (nonatomic, assign)NetworkStatus currentReachabilityStatus;   //当前网络环境

@property (nonatomic, assign, readonly)BOOL isLoggedin;
@property (nonatomic, assign, readonly)BOOL isConnected;

/**
 *  创建单例类型
 */
+ (instancetype)shareInstance;


/**
 *  建立网络连接链路
 */
- (void)buildConnectionCompletion:(ConnectCompletion)completion;
/**
 *  断开链路网络连接
 */
- (void)disconnectSocketCompletion:(ConnectCompletion)completion;


/**
 *  登陆
 *
 *  @param loginID  账户名
 *  @param loginPwd 账户密码
 */
- (void)logInWithID:(NSString *)loginID
           loginPwd:(NSString *)loginPwd
         completion:(CompletionBlock)completion;

/**
 *  登出
 */
- (void)logOut;

/**
 *  缓存数据登陆
 *
 *  @param completion 回调Block
 *
 *  @return 是否利用了缓存进行登陆
 */
- (BOOL)loginByUserDefaultCompletion:(CompletionBlock)completion;

@end


/**
 *  代理方法，用于登录过程中回调
 */
@protocol UserManagerDelegate <NSObject>

@optional

- (void)userDidLogIn:(UserManager *)user;
- (void)userDidLogOut:(UserManager *)user;
- (void)userGetCallRequest:(UserManager *)user result:(NSDictionary *)result;

@end
