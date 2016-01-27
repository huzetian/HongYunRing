//
//  UserManager.m
//  HongYunBell
//
//  Created by ZZ on 15/11/30.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "UserManager.h"


@interface UserManager ()

@property (nonatomic, strong)NSTimer *heartBeatTimer;
@property (nonatomic, copy)ConnectCompletion connectCompletion;
@property (nonatomic, copy)ConnectCompletion disConnectCompletion;

@property (nonatomic, strong)NSMutableData *bufferData;
@property (nonatomic, assign)BOOL bufferAppending;

@property (nonatomic, assign)BOOL communicating;
@end

@implementation UserManager

/**
 *  创建单例类型
 */
+ (instancetype)shareInstance
{
    static UserManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[super alloc] init];
            instance.user = [[UserModel alloc] init];
            instance.mySocket = [[MySocket alloc] initWithDelegate:instance];
        }
    });
    return instance;
}

#pragma mark - property
/**
 *  是否已经登陆
 */
- (BOOL)isLoggedin {
    return self.user.userID;
}

/**
 *  是否已连接
 */
- (BOOL)isConnected {
    return self.mySocket.socket.isConnected;
}


/**
 *  当前网络环境
 */
- (NetworkStatus)currentReachabilityStatus {
    return self.mySocket.reachability.currentReachabilityStatus;
}


#pragma mark - 链路

/**
 *  建立网络连接链路
 */
- (void)buildConnectionCompletion:(ConnectCompletion)completion {
    self.connectCompletion = completion;
    [self.mySocket buildConnection];
}
/**
 *  断开链路连接
 */
- (void)disconnectSocketCompletion:(ConnectCompletion)completion {
    self.disConnectCompletion = completion;
    [self.mySocket disconnectSocket];
}

#pragma mark - 心跳
/**
 *  开始发送心跳包
 */
- (void)heartBeatBegin
{
    if (self.heartBeatTimer) {
        return;
    }
    self.heartBeatTimer = [NSTimer scheduledTimerWithTimeInterval:10
                                                           target:self
                                                         selector:@selector(heartBeat:)
                                                         userInfo:nil
                                                          repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.heartBeatTimer forMode:NSRunLoopCommonModes];
}
/**
 *  发送心跳请求
 */
- (void)heartBeat:(NSTimer *)timer
{
    [RequestMethod requestHeartBeat];
}

#pragma mark - 登陆
/**
 *  通过缓存进行登录
 *
 *  @param completion 回调Block
 *
 *  @return 是否通过缓存进行了登陆
 */
- (BOOL)loginByUserDefaultCompletion:(CompletionBlock)completion
{
    //从UserDefault取出缓存信息进行登录
    NSDictionary *loginInfo = [[NSUserDefaults standardUserDefaults] objectForKey:UserLoginInfo];

    if (loginInfo) {
        NSString *loginID = [loginInfo objectForKey:UserLoginID];
        NSString *loginPwd = [loginInfo objectForKey:UserLoginPwd];
        
        [self logInWithID:loginID loginPwd:loginPwd completion:completion];
        return YES;
    }
    else {
        return NO;
    }

}

/**
 *  用户名密码登陆
 *
 *  @param loginID  账户名
 *  @param loginPwd 账户密码
 */
- (void)logInWithID:(NSString *)loginID
           loginPwd:(NSString *)loginPwd
         completion:(CompletionBlock)completion
{
    NSLog(@"登录操作");
    
    //链路断开，重练链路
    if (!self.isConnected) {
        //链路重连后登陆
        [self buildConnectionCompletion:^{
            
            [self loginActionID:loginID loginPwd:loginPwd completion:completion];
        }];
        return;
    }
    //直接登录
    [self loginActionID:loginID loginPwd:loginPwd completion:completion];
}

//登陆操作
- (void)loginActionID:(NSString *)loginID
             loginPwd:(NSString *)loginPwd
           completion:(CompletionBlock)completion
{
    [RequestMethod requestLoginWithID:loginID password:loginPwd success:^(NSDictionary *result) {
        
        if ([result objectForKey:@"error"]) {
            self.user.userID = nil;
            self.user.userPwd = nil;
            return;
        }
        
        self.user.userID = [loginID copy];
        self.user.userPwd = [loginPwd copy];
        
        //将账户信息存入UserDefault
        NSDictionary *loginDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                  loginID , UserLoginID,
                                  loginPwd, UserLoginPwd, nil];
        
        [[NSUserDefaults standardUserDefaults] setObject:loginDic forKey:UserLoginInfo];
        
        //回调Block，传出数据
        if (completion) {
            completion(result);
        }
#warning 发送心跳包
        //发送心跳包
        [self heartBeatBegin];
        
        //获取账号昵称
        [self requestNickName:nil];
        
        //回调代理方法
        if ([self.delegate respondsToSelector:@selector(userDidLogIn:)]) {
            [self.delegate userDidLogIn:self];
        }
        
    } failure:^(NSError *error) {
        
    }];

}

/**
 *  获取账户昵称
 *
 *  @param completion 回调Block
 */
- (void)requestNickName:(void(^)(NSString *nickName))completion {
    //获取账号昵称
    [RequestMethod requestGetUserInfoSuccess:^(NSDictionary *result) {
        if ([result objectForKey:@"error"]) {
            NSLog(@"error:%@",result);
            return;
        }
        NSString *nickName = [[result objectForKey:@"result"] objectForKey:@"nickname"];
        
        self.user.nickName = nickName;
        
        if (completion) {
            completion(nickName);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"获取昵称失败：%@", error);
    }];
}
/**
 *  登出
 */
- (void)logOut {
    
    [self removeAuthData];
    [self.mySocket disconnectSocket];

    //停止心跳包
    if (self.heartBeatTimer) {
        [self.heartBeatTimer invalidate];
        self.heartBeatTimer = nil;
    }
}

/**
 * @description 清空认证信息
 */
- (void)removeAuthData{
    //删除ID、密码
    self.user.userID = nil;
    self.user.userPwd = nil;
    self.user.nickName = nil;
    //删除缓存信息
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserLoginInfo];
}


#pragma mark - GCDAsyncSocketDelegate 代理
/**
 *  连接成功
 */
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    if (sock.connectedPort == kBellPort)
    {
        NSLog(@"normal connect success!");
    }
    if (self.connectCompletion)
    {
        self.connectCompletion();
    }
    [sock readDataWithTimeout:-1 tag:10];
}

/**
 *  连接断开
 */
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    if (sock.isDisconnected) {
        NSLog(@"normal disconnect! \nError : %@", err);
    }
    if (self.disConnectCompletion) {
        self.disConnectCompletion();
    }
    //回调登出代理方法
    if (!self.isLoggedin) {
        if ([self.delegate respondsToSelector:@selector(userDidLogOut:)]) {
            [self.delegate userDidLogOut:self];
        }
    }
}

/**
 *  发送完数据
 */
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    self.bufferAppending = NO;
    self.bufferData = nil;
}

/**
 *  接收到数据
 */
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSError *error = nil;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    /**
     *  Json转换错误，拼接data
     */
    if (error) {
        [self appendBufferData:data sock:sock];
        error = nil;
        result = [NSJSONSerialization JSONObjectWithData:self.bufferData options:NSJSONReadingMutableLeaves error:&error];
        if (error) {
            //循环读取数据
            [sock readDataWithTimeout:kTimeout tag:tag];
            return;
        }
    }
    
    /**
     *  数据解析正确
     */
    self.bufferAppending = NO;
    self.bufferData = nil;

    //获取PUSH信息
    if ([[result objectForKey:@"id"] integerValue] == 0 && result) {
        NSLog(@"获取到PUSH信息");
        [self getPushMessage:result];
    }
    
    //普通响应
    else {
#warning 线程安全，writtenRequests资源竞争
        //通过tag取出对应的请求，执行其回调代码。
        NSNumber *resultTag = [result objectForKey:@"id"];
        MySocketRequest *request = [self.mySocket.writtenRequests objectForKey:resultTag];
        if (request.completion) {
            request.completion(result);
        }
        [self.mySocket.writtenRequests removeObjectForKey:[NSNumber numberWithInteger:tag]];
    }
    
    //循环读取数据
    [sock readDataWithTimeout:kTimeout tag:tag];
}


/************************ PUSH消息处理 ************************/
/**
 *  拼接断包的数据
 *
 *  @param data 断包数据
 *  @param sock 链路
 */
- (void)appendBufferData:(NSData *)data sock:(GCDAsyncSocket *)sock {
    //第一次error保存tag
    if (self.bufferAppending == NO) {
        self.bufferAppending = YES;
        self.bufferData = [NSMutableData dataWithData:data];
    }
    //error之后的error
    else {
        [self.bufferData appendData:data];
    }
}

/**
 *  获取到推送消息
 *
 *  @param result 推送数据
 */
- (void)getPushMessage:(NSDictionary *)result {
    
    NSString *msgType = [result objectForKey:@"msg_type"];
    
    //门铃呼叫
    if ([msgType isEqualToString:@"RELAY_MSG"]) {
        
        self.communicating = YES;
        if ([self.delegate respondsToSelector:@selector(userGetCallRequest:result:)]) {
            [self.delegate userGetCallRequest:self result:result];
        }
    }
    //账户被顶
    else if ([msgType isEqualToString:@"USER_CONFLICT_NOTIFY"]) {
        [self logOut];
        
    }

}

@end
