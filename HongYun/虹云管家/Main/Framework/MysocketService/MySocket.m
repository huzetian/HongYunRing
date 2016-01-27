//
//  MySochet.m
//  HongYunRoute
//
//  Created by ZZ on 15/11/20.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "MySocket.h"


@interface MySocket () {
    
    BOOL _isConnecting;
    
    NSArray *_reachabilityStatusArray;

}


@property (atomic, assign)NSInteger writtenTag;

@end

@implementation MySocket

#pragma mark -

- (instancetype)initWithDelegate:(id)delegate {
    if (self = [super init]) {
        self.delegate = delegate;
        [self initInstance];
    }
    return self;
}
- (void)initInstance {
    
    _writtenTag = 100;
    self.writtenRequests = [NSMutableDictionary dictionary];
    
    //网络环境
    _reachabilityStatusArray = @[@"无网络连接", @"WWAN连接", @"WiFi连接"];
    
    //监听网络环境改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    //开启网络环境监控
    _reachability = [Reachability reachabilityWithHostName:kCloudHost];
    [_reachability startNotifier];

}
- (void)dealloc {
    [self disconnectSocket];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark -reachabilityChanged 网络环境变化
-(void)reachabilityChanged:(NSNotification *)note {
    
    Reachability *reachability = [note object];
    
    NetworkStatus status = reachability.currentReachabilityStatus;
    
    NSLog(@"%@", _reachabilityStatusArray[status]);
    
    //断线重连
    if (!self.socket.isConnected && _isConnecting && _reachability.currentReachabilityStatus != NotReachable) {
        [self.socket connectToHost:kCloudHost onPort:kBellPort withTimeout:kTimeout error:nil];
        NSLog(@"重连");
    }
}


#pragma mark - 链路
/**
 *  建立网络连接链路
 */
- (void)buildConnection {
    
    if (_isConnecting) {
        return;
    }
    _isConnecting = YES;

    if (self.socket == nil) {
        self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self.delegate delegateQueue:dispatch_get_main_queue()];
    }
    
    NSError *error = nil;
    
    if (![self.socket connectToHost:kCloudHost onPort:kBellPort withTimeout:kTimeout error:&error]) {
        
        NSLog(@"Error : %@", error);
        return;
    }
}
/**
 *  断开链路连接
 */
- (void)disconnectSocket {
    _isConnecting = NO;
    if (self.socket) {
        [self.socket disconnect];
    }
}
#pragma mark - 发送数据

/*  发送request、NSString、NSData三种类型数据的接口。前者转化为后者（最终为NSData）进行传递发送，在最后一层进行链路判断重连操作。
 */

/**
 *  发送socket数据
 *
 *  @param message      请求
 *  @param businessType 业务类型
 *  @param tag          标记值
 *  @param completion   回调Block
 */
- (void)writeDataWithRequest:(MySocketRequest *)request
{
    request.requestID = _writtenTag;
    //格式构造
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setObject:request.cloudVersion forKey:@"zl_cloud"];
    [dataDic setObject:request.method forKey:@"method"];
    [dataDic setObject:[NSNumber numberWithInteger:_writtenTag] forKey:@"id"];
    if (request.params) {
        [dataDic setObject:request.params forKey:@"params"];
    }
    
    //添加结束符
    NSData *data = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    message  = [message stringByAppendingString:@"\r\n"];
    
    NSInteger tag = 1234;
    [self writeDataWithMessage:message tag:tag completion:request.completion];
    //保存发送的请求
    [self.writtenRequests setObject:request forKey:[NSNumber numberWithInteger:_writtenTag]];
    
    //改变tag值
    _writtenTag++;
    if (_writtenTag >= 100000) {
        _writtenTag = 100;
    }
}

/**
 *  发送socket数据
 *
 *  @param message      字符串信息
 *  @param businessType 业务类型
 *  @param tag          标记值
 *  @param completion   回调Block
 */
- (void)writeDataWithMessage:(NSString *)message
                         tag:(long)tag
                  completion:(CompletionBlock)completion
{
    if (message == nil) {
        return;
    }
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    
//    NSLog(@"message : \n%@, tag : %li\n\n", message, tag);
    
    [self writeDataWithData:data tag:tag completion:completion];
}
/**
 *  发送socket数据
 *
 *  @param data       二进制信息
 *  @param type       业务类型
 *  @param tag        标记值
 *  @param completion 回调Block
 */
- (void)writeDataWithData:(NSData *)data
                      tag:(long)tag
               completion:(CompletionBlock)completion
{
    if (!data.length) {
        return;
    }
//    //链路重连
//    if ([self.socket isDisconnected] && _reachability.currentReachabilityStatus != NotReachable) {
//        [self buildConnectionCompletion:^{
//            //发送数据
//            [self writeData:data tag:tag completion:completion];
//        }];
//        NSLog(@"重连");
//    }
    //发送数据
    [self writeData:data tag:tag completion:completion];
}

/**
 *  封装：发送操作
 *
 *  @param data       二进制信息
 *  @param tag        标记值
 *  @param completion 回调Block
 */
- (void)writeData:(NSData *)data tag:(long)tag completion:(CompletionBlock)completion
{
    //发送（write）数据
    [self.socket writeData:data withTimeout:kTimeout tag:tag];
    
}

@end