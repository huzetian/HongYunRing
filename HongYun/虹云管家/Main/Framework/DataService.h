//
//  DataService.h
//  微博-01
//
//  Created by imac on 15/9/26.
//  Copyright (c) 2015年 zhangzheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface DataService : NSObject

/************************ POST ************************/

#pragma mark - POST

/**
 *  POST请求：上传图片
 *
 *  @param image     图片
 *  @param userName  用户名称
 *  @param pwd       用户密码
 */
+ (void)uploadImage:(UIImage *)image
               user:(NSString *)userName
                pwd:(NSString *)pwd
            success:(void (^)(NSURLSessionDataTask *task, NSString *responseURL))success
            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  POST请求：上传语音
 *
 *  @param voiceName 语音名
 *  @param userName  用户名称
 *  @param pwd       用户密码
 */
+ (void)uploadVoice:(NSData *)voiceData
               user:(NSString *)userName
                pwd:(NSString *)pwd
            success:(void (^)(NSURLSessionDataTask *task, NSString *responseURL))success
            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/************************ GET ************************/

#pragma mark - GET

/**
 *  GET请求：获取图片
 *
 *  @param imageName 图片名
 *  @param userName  用户名称
 *  @param pwd       用户密码
 *  @param success   成功回调
 *  @param failure   失败回调
 */
+ (void)downloadImage:(NSString *)imageName
                 user:(NSString *)userName
                  pwd:(NSString *)pwd
              success:(void (^)(NSURLSessionDataTask *task, NSData *responseData))success
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  GET请求：获取语音
 *
 *  @param voiceName 语音名
 *  @param userName  用户名称
 *  @param pwd       用户密码
 *  @param success   成功回调
 *  @param failure   失败回调
 */
+ (void)downloadVoice:(NSString *)voiceName
                 user:(NSString *)userName
                  pwd:(NSString *)pwd
              success:(void (^)(NSURLSessionDataTask *task, NSData *responseData))success
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  GET请求：通过完整的URL
 *
 *  @param urlString URL
 *  @param userName  用户名称
 *  @param pwd       用户密码
 *  @param success   成功回调
 *  @param failure   失败回调
 */
+ (void)downloadWithURL:(NSString *)urlString
                   user:(NSString *)userName
                    pwd:(NSString *)pwd
                success:(void (^)(NSURLSessionDataTask *task, NSData *responseData))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
