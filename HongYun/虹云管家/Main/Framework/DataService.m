//
//  DataService.m
//  微博-01
//
//  Created by imac on 15/9/26.
//  Copyright (c) 2015年 zhangzheng. All rights reserved.
//

#import "DataService.h"

static NSString *baseUrl = @"http://182.92.108.214:29000/restserver/api/v1/accounts";

@implementation DataService

/************************ POST ************************/

#pragma mark - POST

/**
 *  POST请求：上传图片
 *
 *  @param image 图片
 *  @param userName  用户名称
 *  @param pwd       用户密码
 */
+ (void)uploadImage:(UIImage *)image
               user:(NSString *)userName
                pwd:(NSString *)pwd
            success:(void (^)(NSURLSessionDataTask *task, NSString *responseURL))success
            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    //URL
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/image", baseUrl, userName];
    
    //设置请求头
    NSDictionary *header = [NSDictionary dictionaryWithObjectsAndKeys:
                            userName, @"userName",
                            pwd, @"hashedPassword", nil];
    
    [self postWithURL:urlString requestHeader:header construction:^(id<AFMultipartFormData> formData) {
        //构建Body，请求体
        NSData *data = UIImageJPEGRepresentation(image, 0.1);
        //拼接请求体
        [formData appendPartWithFileData:data
                                    name:@"resource"
                                fileName:@"2015_12_14_23_35_55.jpeg"
                                mimeType:@"image/jpeg"];

    } success:success failure:failure];
    
}



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
            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    //URL
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/voice", baseUrl, userName];
    
    //设置请求头
    NSDictionary *header = [NSDictionary dictionaryWithObjectsAndKeys:
                            userName, @"userName",
                            pwd, @"hashedPassword", nil];
    
    [self postWithURL:urlString requestHeader:header construction:^(id<AFMultipartFormData> formData) {
        //构建Body，请求体
        [formData appendPartWithFileData:voiceData
                                    name:@"resource"
                                fileName:@"voice01.wav"
                                mimeType:@"audio/pcm"];
        
    } success:success failure:failure];
    
}

/**
 *  POST请求
 *
 *  @param URLString 请求URL
 *  @param header    请求头
 *  @param success   成功回调
 *  @param failure   失败回调
 */
+ (void)postWithURL:(NSString *)URLString
      requestHeader:(NSDictionary *)header
       construction:(void (^)(id <AFMultipartFormData> formData))block
            success:(void (^)(NSURLSessionDataTask *task, NSString *responseURL))success
            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    //设置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //manager
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //请求头构建
    for (NSString *headerField in header) {
        //value
        NSString *value = [header objectForKey:headerField];
        [manager.requestSerializer setValue:value forHTTPHeaderField:headerField];
    }
    //响应
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    
    //发送
    [manager POST:URLString parameters:nil constructingBodyWithBlock:block progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSString *responseURL = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        success (task, responseURL);
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        failure(task, error);
        
    }];
    
}

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
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    //URL
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/images/%@", baseUrl, userName, imageName];
    
    //设置请求头
    NSDictionary *header = [NSDictionary dictionaryWithObjectsAndKeys:
                            userName, @"userName",
                            pwd, @"hashedPassword", nil];
    
    [self getWithURL:urlString header:header success:success failure:failure];
}

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
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    //URL
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/voices/%@", baseUrl, userName, voiceName];
    
    //设置请求头
    NSDictionary *header = [NSDictionary dictionaryWithObjectsAndKeys:userName, @"userName", pwd, @"hashedPassword", nil];
    
    [self getWithURL:urlString header:header success:success failure:failure];
}

/**
 *  GET请求：通过URL
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
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    //设置请求头
    NSDictionary *header = [NSDictionary dictionaryWithObjectsAndKeys:
                            userName, @"userName",
                            pwd, @"hashedPassword", nil];
    
    [self getWithURL:urlString header:header success:success failure:failure];
}

/**
 *  GET请求
 *
 *  @param URLString 请求URL
 *  @param header    请求头
 *  @param success   成功回调
 *  @param failure   失败回调
 */
+ (void)getWithURL:(NSString *)URLString
            header:(NSDictionary *)header
           success:(void (^)(NSURLSessionDataTask *task, NSData *responseData))success
           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    //设置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //manager
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    //请求头构建
    for (NSString *headerField in header) {
        //value
        NSString *value = [header objectForKey:headerField];
        [manager.requestSerializer setValue:value forHTTPHeaderField:headerField];
    }
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"image/jpg", @"audio/pcm", nil];
    //响应
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];

    //发送请求
    [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *responseData = (NSData *)responseObject;
        success(task, responseData);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(task, error);

    }];
}

@end
