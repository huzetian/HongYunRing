//
//  MySochet.h
//  HongYunRoute
//
//  Created by ZZ on 15/11/20.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
#import "MySocketRequest.h"
#import "Reachability.h"

//云平台
#define kCloudHost @"182.92.108.214"

#define kBellPort      19090

#define kTimeout -1

@interface MySocket : NSObject <GCDAsyncSocketDelegate>

@property (nonatomic, strong)GCDAsyncSocket *socket;    //业务链路
@property (nonatomic, strong)Reachability *reachability;//连接状态

@property (nonatomic, strong)NSMutableDictionary *writtenRequests;

@property (nonatomic, weak)id delegate;     //代理

/**
 *  初始化方法
 *
 *  @param delegate 代理
 */
- (instancetype)initWithDelegate:(id)delegate;

#pragma mark - 建立连接
/**
 *  建立网络连接链路
 */
- (void)buildConnection;

/**
 *  断开链路网络连接
 */
- (void)disconnectSocket;


#pragma mark - 发送数据
/**
 *  发送socket数据
 *
 *  @param message      请求
 *  @param businessType 业务类型
 *  @param tag          标记值
 *  @param completion   回调Block
 */
- (void)writeDataWithRequest:(MySocketRequest *)request;


@end
