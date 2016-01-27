//
//  RequestMethod.h
//  HongYunBell
//
//  Created by ZZ on 15/12/10.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MySocketRequest.h"

@interface RequestMethod : NSObject


#pragma mark - 网络请求
#pragma mark - 临时业务

/**
 *  请求：设置业务类型
 *
 *  @param type       临时业务类型
 *  @param completion 回调Block
 */
+ (void)requestBusinessTypeWithType:(NSString *)type
                            success:(CompletionBlock)completeBlock
                            failure:(FailureBlock)failure;

/**
 *  请求：获取验证码
 *
 *  @param phoneNum   手机号码
 *  @param completion 回调Block
 */
+ (void)requestVerificationCodeWithPhoneNum:(NSString *)phoneNum
                                    success:(CompletionBlock)completeBlock
                                    failure:(FailureBlock)failure;


/**
 *  请求：注册用户
 *
 *  @param verificationCode 验证码
 *  @param password         密码
 *  @param completion       回调Block
 */
+ (void)requestRegisterWithVerificationCode:(NSString *)verificationCode
                                   password:(NSString *)password
                                    success:(CompletionBlock)completeBlock
                                    failure:(FailureBlock)failure;


#pragma mark - 账号登陆
/**
 *  请求：账号登录
 *
 *  @param loginID    账户ID
 *  @param password   密码
 *  @param completion 回调Block
 */
+ (void)requestLoginWithID:(NSString *)loginID
                  password:(NSString *)password
                   success:(CompletionBlock)completeBlock
                   failure:(FailureBlock)failure;


/**
 *  请求：APP通过验证码登陆
 *
 *  @param phoneNum   手机号码
 *  @param code       验证码
 *  @param completion 回调Block
 */
+ (void)requestLoginWithPhoneNum:(NSString *)phoneNum
                veriticationCode:(NSString *)code
                         success:(CompletionBlock)completeBlock
                         failure:(FailureBlock)failure;


#pragma mark - 密码、昵称
/**
 *  请求：获取账号信息（昵称）
 *
 *  @param completeBlock 回调Block
 */
+ (void)requestGetUserInfoSuccess:(CompletionBlock)completeBlock
                            failure:(FailureBlock)failure;

/**
 *  请求：修改密码
 *
 *  @param oldPwd     旧密码（加密）
 *  @param newPwd     新密码（加密）
 *  @param completion 回调Block
 */
+ (void)requestChangePasswordWithOldPwd:(NSString *)oldPwd
                                 newPwd:(NSString *)newPwd
                                success:(CompletionBlock)completeBlock
                                failure:(FailureBlock)failure;


/**
 *  请求：重置密码
 *
 *  @param code       手机验证码
 *  @param newPwd     新密码（加密）
 *  @param completion 回调Block
 */
+ (void)requestResetPasswordWithVerificationCode:(NSString *)code
                                          newPwd:(NSString *)newPwd
                                         success:(CompletionBlock)completeBlock
                                         failure:(FailureBlock)failure;


/**
 *  请求：设置账户昵称
 *
 *  @param nickName   昵称
 *  @param completion 回调Block
 */
+ (void)requestSetNickNameWithName:(NSString *)nickName
                           success:(CompletionBlock)completeBlock
                           failure:(FailureBlock)failure;


#pragma mark - 上传反馈、异常
/**
 *  请求：上传用户反馈
 *
 *  @param reportText 反馈内容
 *  @param picsArray  反馈图片
 *  @param completion 回调Block
 */
+ (void)requestUploadUserReportWithText:(NSString *)reportText
                                   pics:(NSArray *)picsArray
                                success:(CompletionBlock)completeBlock
                                failure:(FailureBlock)failure;

/**
 *  请求：上传APP异常处理
 *
 *  @param phoneType    手机类型
 *  @param phoneVersion 手机版本
 *  @param appVersion   APP版本
 *  @param exception    内容
 *  @param completion   回调Block
 */
+ (void)requestUploadAppErrorWithPhoneType:(NSString *)phoneType
                              phoneVersion:(NSString *)phoneVersion
                                appVersion:(NSString *)appVersion
                                 exception:(NSString *)exception
                                   success:(CompletionBlock)completeBlock
                                   failure:(FailureBlock)failure;


#pragma mark - 设备管理
/**
 *  请求：获取设备列表
 *
 *  @param completion 回调Block
 */
+ (void)requestGetDeviceListSuccess:(CompletionBlock)completeBlock
                            failure:(FailureBlock)failure;


/**
 *  请求：获取设备拥有者
 *
 *  @param devID      设备ID
 *  @param completion 回调Block
 */
+ (void)requestGetDeviceOwnerWithDevID:(NSString *)devID
                               success:(CompletionBlock)completeBlock
                               failure:(FailureBlock)failure;


/**
 *  请求：设置设备昵称
 *
 *  @param devID      设备ID
 *  @param nickname   昵称
 *  @param completion 回调Block
 */
+ (void)requestSetDeviceNicknameWithDevID:(NSString *)devID
                                 nickname:(NSString *)nickname
                                  success:(CompletionBlock)completeBlock
                                  failure:(FailureBlock)failure;


/**
 *  请求：添加设备
 *
 *  @param devID       设备ID
 *  @param isEncrypted 是否加密
 *  @param completion  回调Block
 */
+ (void)requestAddDeviceWithDevID:(NSString *)devID
                      isEncrypted:(BOOL)isEncrypted
                          success:(CompletionBlock)completeBlock
                          failure:(FailureBlock)failure;


/**
 *  请求：删除设备
 *
 *  @param devID      设备ID
 *  @param completion 回调Block
 */
+ (void)requestDeleteDevicewithDevID:(NSString *)devID
                             success:(CompletionBlock)completeBlock
                             failure:(FailureBlock)failure;


/**
 *  请求：分享设备
 *
 *  @param devID      设备ID
 *  @param userID     分享用户ID
 *  @param completion 回调Block
 */
+ (void)requestShareWithDeviceID:(NSString *)devID
                          userID:(NSString *)userID
                         success:(CompletionBlock)completeBlock
                         failure:(FailureBlock)failure;


/**
 *  请求：取消分享
 *
 *  @param devID      被取消设备ID
 *  @param userID     被取消用户ID
 *  @param completion 回调Block
 */
+ (void)requestCancelShareWithDeviceID:(NSString *)devID
                                userID:(NSString *)userID
                               success:(CompletionBlock)completeBlock
                               failure:(FailureBlock)failure;


#pragma mark - 透传消息
/**
 *  请求：透传消息
 *
 *  @param msg        透传消息
 *  @param to         到达的用户或终端
 *  @param completion 回调Block
 */
+ (void)requestRelayMessageWithMessage:(NSString *)msg
                                    to:(NSString *)to
                               success:(CompletionBlock)completeBlock
                               failure:(FailureBlock)failure;


#pragma mark - 链路心跳
/**
 *  请求：链路心跳
 *
 *  @param completion 回调Block
 */
+ (void)requestHeartBeat;

#pragma mark - 语音呼叫
/**
 *  请求：接受语音呼叫请求
 *
 *  @param devID      门铃设备ID
 *  @param requestID  门铃设备呼叫请求ID
 *  @param completion 回调Block
 */
+ (void)requestCallAcceptWithDevID:(NSString *)devID
                     callRequestID:(NSInteger)requestID
                           success:(CompletionBlock)completeBlock
                           failure:(FailureBlock)failure;


/**
 *  请求：拒绝语音请求
 *
 *  @param devID      门铃设备ID
 *  @param requestID  门铃设备呼叫请求ID
 *  @param reason     拒绝请求原因，取值为
 *  @param completion 回调Block
 */
+ (void)requestCallRejectWithDevID:(NSString *)devID
                     callRequestID:(NSInteger)requestID
                            reason:(NSString *)reason
                           success:(CompletionBlock)completeBlock
                           failure:(FailureBlock)failure;


/**
 *  请求：发送语音
 *
 *  @param to         发送设备ID
 *  @param photo      图片服务器的通信协议【目前仅支持@"http"（小写）】,若无字段则默认为@"http"
 *  @param host       图片服务器IP地址
 *  @param path       语音文件存放路径
 *  @param completion 回调Block
 */
+ (void)requestSendVoiceToID:(NSString *)to
                    protocol:(NSString *)protocol
                        host:(NSString *)host
                        path:(NSString *)path
                     success:(CompletionBlock)success
                     failure:(FailureBlock)failure;


/**
 *  挂断通话
 *
 *  @param devID         设备ID
 *  @param callID        呼叫请求ID
 *  @param completeBlock 回调Block
 */
+ (void)requestCallHangUpWithDevID:(NSString *)devID
                     callRequestID:(NSInteger)callID
                           success:(CompletionBlock)completeBlock
                           failure:(FailureBlock)failure;


#pragma mark - 图片抓拍请求
/**
 *  请求：发出图片抓拍请求
 *
 *  @param devID      门铃设备ID
 *  @param completion 回调Block
 */
+ (void)requestSnapshotWithDevID:(NSString *)devID
                         success:(CompletionBlock)completeBlock
                         failure:(FailureBlock)failure;


#pragma mark - 告警、访客信息
/**
 *  请求：获取告警信息
 *
 *  @param devID      门铃设备ID
 *  @param startTime  起始查询时间（格式：YYYY-MM-DD HH:MM:SS）
 *  @param endTime    终止查询时间（格式：YYYY-MM-DD HH:MM:SS）
 *  @param completion 回调Block
 */
+ (void)requestGetWarningInfoWithDevID:(NSString *)devID
                             startTime:(NSString *)startTime
                               endTime:(NSString *)endTime
                               success:(CompletionBlock)completeBlock
                               failure:(FailureBlock)failure;


/**
 *  请求：获取访客信息
 *
 *  @param devID      门铃设备ID
 *  @param startTime  起始查询时间（格式：YYYY-MM-DD HH:MM:SS）
 *  @param endTime    终止查询时间（格式：YYYY-MM-DD HH:MM:SS）
 *  @param completion 回调Block
 */
+ (void)requestGetVisitorInfoWithDevID:(NSString *)devID
                             startTime:(NSString *)startTime
                               endTime:(NSString *)endTime
                               success:(CompletionBlock)completeBlock
                               failure:(FailureBlock)failure;


#pragma mark - 门铃配置、状态
/**
 *  请求：设置门铃配置
 *
 *  @param devID       门铃设备ID
 *  @param humanCheck  人形检查 0：不开启人形检查，1：开启人形检查
 *  @param lampSwitch  门铃灯  0：关闭门铃灯，1：开启门铃灯
 *  @param warningTime 门铃告警时间（需开启人性检查），取值[1,20](s)
 *  @param captureNum  连拍张数，取值[1,5]
 *  @param tone        门铃铃声索引，取值[1,10]
 *  @param volume      门铃音量等级，取值[1,100]
 *  @param completion  回调Block
 */
+ (void)requestSetConfigWithDevID:(NSString *)devID
                      hunmanCheck:(NSInteger)humanCheck
                       lampSwitch:(NSInteger)lampSwitch
                      warningTime:(NSInteger)warningTime
                       captureNum:(NSInteger)captureNum
                         toneType:(NSInteger)tone
                           volume:(NSInteger)volume
                          success:(CompletionBlock)completeBlock
                          failure:(FailureBlock)failure;

/**
 *  请求：获取门铃配置
 *
 *  @param devID      门铃设备ID
 *  @param completion 回调Block
 */
+ (void)requestGetConfigWithDevID:(NSString *)devID
                          success:(CompletionBlock)completeBlock
                          failure:(FailureBlock)failure;


/**
 *  请求：获取门铃状态
 *
 *  @param devID      门铃设备ID
 *  @param completion 回调Block
 */
+ (void)requestGetStatusWithDevID:(NSString *)devID
                          success:(CompletionBlock)completeBlock
                          failure:(FailureBlock)failure;


@end
