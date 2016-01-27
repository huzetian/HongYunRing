//
//  MySocketRequest.h
//  HongYunRoute
//
//  Created by ZZ on 15/11/23.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Encrypto.h"

typedef void(^CompletionBlock)(NSDictionary *result);
typedef void(^FailureBlock)(NSError *error);

@interface MySocketRequest : NSObject

@property (nonatomic, strong)NSString *cloudVersion;    //版本
@property (nonatomic, strong)NSString *method;          //请求方法名
@property (nonatomic, strong)NSDictionary *params;      //请求参数
@property (nonatomic, assign)NSInteger requestID;       //id

@property (nonatomic, copy)CompletionBlock completion;

- (instancetype)initWithParams:(NSDictionary *)params
                        method:(NSString *)method
                     requestID:(NSInteger)requestID
                    completion:(CompletionBlock)completion;


@end
