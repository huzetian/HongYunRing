//
//  RequestMethod.m
//  HongYunBell
//
//  Created by ZZ on 15/12/10.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "RequestMethod.h"
#import "UserManager.h"

@implementation RequestMethod


#pragma mark - 发送数据
/**
 *  发送数据
 *
 *  @param params       数据参数
 *  @param method       请求方法
 *  @param dataID       id
 *  @param businessType 业务类型
 *  @param completion   回调Block
 */
+ (void)hyRequestWithParams:(NSDictionary *)params
                     method:(NSString *)method
                    success:(CompletionBlock)success
                    failure:(FailureBlock)failure
{
    MySocketRequest *request = [[MySocketRequest alloc] initWithParams:params
                                                                method:method
                                                             requestID:0
                                                            completion:success];
    
    [[UserManager shareInstance].mySocket writeDataWithRequest:request];
}
#pragma mark - 网络请求
#pragma mark - 临时业务

/**
 *  请求：设置业务类型
 *
 *  @param type       临时业务类型
 *  @param completion 回调Block
 */
+ (void)requestBusinessTypeWithType:(NSString *)type
                            success:(CompletionBlock)success
                            failure:(FailureBlock)failure;
{
    NSString *method = @"SET_TEMP_SVC_TYPE";
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:type, @"type", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}
/**
 *  请求：获取验证码
 *
 *  @param phoneNum   手机号码
 *  @param completion 回调Block
 */
+ (void)requestVerificationCodeWithPhoneNum:(NSString *)phoneNum
                                    success:(CompletionBlock)success
                                    failure:(FailureBlock)failure;
{
    NSString *method = @"GET_VERIFICATION_CODE";
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:phoneNum, @"phone_num", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}

/**
 *  请求：注册用户
 *
 *  @param verificationCode 验证码
 *  @param password         密码
 *  @param completion       回调Block
 */
+ (void)requestRegisterWithVerificationCode:(NSString *)verificationCode
                                   password:(NSString *)password
                                    success:(CompletionBlock)success
                                    failure:(FailureBlock)failure;
{
    NSString *method = @"REG_USER_TERMINAL";
    //密码加密
    password = [[password sha1] uppercaseString];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            verificationCode, @"verification_code",
                            password, @"hashed_pwd", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}


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
                   success:(CompletionBlock)success
                   failure:(FailureBlock)failure;
{
    NSString *method = @"LOGIN";
    //密码加密
    //    password = [[password sha1] uppercaseString];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            loginID, @"login_id",
                            password, @"hashed_pwd", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}

/**
 *  请求：APP通过验证码登陆
 *
 *  @param phoneNum   手机号码
 *  @param code       验证码
 *  @param completion 回调Block
 */
+ (void)requestLoginWithPhoneNum:(NSString *)phoneNum
                veriticationCode:(NSString *)code
                         success:(CompletionBlock)success
                         failure:(FailureBlock)failure;
{
    NSString *method = @"LOGIN_BY_CODE";
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            phoneNum, @"phone_num",
                            code, @"veritication_code", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}


#pragma mark - 密码、昵称
/**
 *  请求：获取账号信息（昵称）
 *
 *  @param success 回调Block
 */
+ (void)requestGetUserInfoSuccess:(CompletionBlock)success
                          failure:(FailureBlock)failure;
{
    NSString *method = @"GET_ACCOUNT_INFO";
    
    [self hyRequestWithParams:nil
                       method:method
                      success:success
                      failure:failure];
}

/**
 *  请求：修改密码
 *
 *  @param oldPwd     旧密码（加密）
 *  @param newPwd     新密码（加密）
 *  @param completion 回调Block
 */
+ (void)requestChangePasswordWithOldPwd:(NSString *)oldPwd
                                 newPwd:(NSString *)newPwd
                                success:(CompletionBlock)success
                                failure:(FailureBlock)failure;
{
    NSString *method = @"CHANGE_PWD";
    //密码加密
    oldPwd = [[oldPwd sha1] uppercaseString];
    newPwd = [[newPwd sha1] uppercaseString];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            oldPwd, @"old_hashed_pwd",
                            newPwd, @"new_hashed_pwd", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}

/**
 *  请求：重置密码
 *
 *  @param code       手机验证码
 *  @param newPwd     新密码（加密）
 *  @param completion 回调Block
 */
+ (void)requestResetPasswordWithVerificationCode:(NSString *)code
                                          newPwd:(NSString *)newPwd
                                         success:(CompletionBlock)success
                                         failure:(FailureBlock)failure;
{
    NSString *method = @"RESET_PWD";
    //密码加密
    newPwd = [[newPwd sha1] uppercaseString];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            code, @"verification_code",
                            newPwd, @"new_hashed_pwd", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}

/**
 *  请求：设置账户昵称
 *
 *  @param nickName   昵称
 *  @param completion 回调Block
 */
+ (void)requestSetNickNameWithName:(NSString *)nickName
                           success:(CompletionBlock)success
                           failure:(FailureBlock)failure;
{
    NSString *method = @"SET_NICKNAME";
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:nickName, @"dev_name", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}


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
                                success:(CompletionBlock)success
                                failure:(FailureBlock)failure;
{
    NSString *method = @"UPLOAD_USER_REPORT";
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            reportText, @"report_text",
                            picsArray, @"report_pics", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}


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
                                   success:(CompletionBlock)success
                                   failure:(FailureBlock)failure;
{
    NSString *method = @"UPLOAD_APP_EXCEPTION_REPORT";
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            phoneType, @"phone_type",
                            phoneVersion, @"phone_version",
                            appVersion, @"app_version",
                            exception, @"exception", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}


#pragma mark - 设备管理
/**
 *  请求：获取设备列表
 *
 *  @param completion 回调Block
 */
+ (void)requestGetDeviceListSuccess:(CompletionBlock)success
                            failure:(FailureBlock)failure;
{
    NSString *method = @"GET_DEV_LIST";
    NSDictionary *params = [NSDictionary dictionary];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}

/**
 *  请求：获取设备拥有者
 *
 *  @param devID      设备ID
 *  @param completion 回调Block
 */
+ (void)requestGetDeviceOwnerWithDevID:(NSString *)devID
                               success:(CompletionBlock)success
                               failure:(FailureBlock)failure;
{
    NSString *method = @"GET_DEV_OWNER";
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:devID, @"dev_id", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}
/**
 *  请求：设置设备昵称
 *
 *  @param devID      设备ID
 *  @param nickname   昵称
 *  @param completion 回调Block
 */
+ (void)requestSetDeviceNicknameWithDevID:(NSString *)devID
                                 nickname:(NSString *)nickname
                                  success:(CompletionBlock)success
                                  failure:(FailureBlock)failure;
{
    NSString *method = @"SET_DEV_NICKNAME";
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            devID, @"dev_id",
                            nickname, @"nickname", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}

/**
 *  请求：添加设备
 *
 *  @param devID       设备ID
 *  @param isEncrypted 是否加密
 *  @param completion  回调Block
 */
+ (void)requestAddDeviceWithDevID:(NSString *)devID
                      isEncrypted:(BOOL)isEncrypted
                          success:(CompletionBlock)success
                          failure:(FailureBlock)failure;
{
    NSString *method = @"ADD_DEV_TO_USER";
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            devID, @"dev_id",
                            isEncrypted, @"is_encrypted", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
    
}

/**
 *  请求：删除设备
 *
 *  @param devID      设备ID
 *  @param completion 回调Block
 */
+ (void)requestDeleteDevicewithDevID:(NSString *)devID
                             success:(CompletionBlock)success
                             failure:(FailureBlock)failure;
{
    NSString *method = @"DEL_DEV_FROM_USER";
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:devID, @"dev_id", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}


/**
 *  请求：分享设备
 *
 *  @param devID      设备ID
 *  @param userID     分享用户ID
 *  @param completion 回调Block
 */
+ (void)requestShareWithDeviceID:(NSString *)devID
                          userID:(NSString *)userID
                         success:(CompletionBlock)success
                         failure:(FailureBlock)failure;
{
    NSString *method = @"SHARE_DEV";
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            devID, @"shared_dev_id",
                            userID, @"to_user_id", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}

/**
 *  请求：取消分享
 *
 *  @param devID      被取消设备ID
 *  @param userID     被取消用户ID
 *  @param completion 回调Block
 */
+ (void)requestCancelShareWithDeviceID:(NSString *)devID
                                userID:(NSString *)userID
                               success:(CompletionBlock)success
                               failure:(FailureBlock)failure;
{
    NSString *method = @"CANCEL_SHARE_DEV";
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            devID, @"shared_dev_id",
                            userID, @"to_user_id", nil];

    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}


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
                               success:(CompletionBlock)success
                               failure:(FailureBlock)failure;
{
    NSString *method = @"RELAY_MSG";
    //密码加密
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            msg, @"original_msg",
                            to, @"to", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}

#pragma mark - 链路心跳
/**
 *  请求：链路心跳
 *
 *  @param completion 回调Block
 */
+ (void)requestHeartBeat
{
    NSString *method = @"HEARTBEAT";
    
    NSDictionary *params = [NSDictionary dictionary];
    
    [self hyRequestWithParams:params
                       method:method
                      success:nil
                      failure:nil];
}


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
                           success:(CompletionBlock)success
                           failure:(FailureBlock)failure;
{
    NSString *method = @"RING_CALL_ACCEPT";
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            devID, @"dev_id",
                            [NSNumber numberWithInteger:requestID], @"call_request_id", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}

/**
 *  请求：拒绝语音请求
 *
 *  @param devID      门铃设备ID
 *  @param requestID  门铃设备呼叫请求ID
 *  @param reason     拒绝请求原因，取值为<#原因#>
 *  @param completion 回调Block
 */
+ (void)requestCallRejectWithDevID:(NSString *)devID
                     callRequestID:(NSInteger)requestID
                            reason:(NSString *)reason
                           success:(CompletionBlock)success
                           failure:(FailureBlock)failure;
{
    NSString *method = @"RING_CALL_REJECT";
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            devID, @"dev_id",
                            reason, @"reason",
                            [NSNumber numberWithInteger:requestID], @"call_request_id", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}

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
{
    NSString *method = @"RING_SEND_VOICE";
    
    NSMutableDictionary *voice = [NSMutableDictionary dictionary];
    if (protocol) {
        [voice setObject:protocol forKey:@"protocol"];
    }
    if (host) {
        [voice setObject:host forKey:@"host"];
    }
    if (path) {
        [voice setObject:path forKey:@"path"];
    }
                           
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            to, @"to",
                            voice, @"voice", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}

/**
 *  挂断通话
 *
 *  @param devID         设备ID
 *  @param callID        呼叫请求ID
 *  @param success 回调Block
 */
+ (void)requestCallHangUpWithDevID:(NSString *)devID
                     callRequestID:(NSInteger)callID
                           success:(CompletionBlock)success
                           failure:(FailureBlock)failure;
{
    NSString *method = @"RING_CALL_HANG_UP";
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            devID, @"dev_id",
                            [NSNumber numberWithInteger:callID], @"call_request_id", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}


#pragma mark - 图片抓拍请求
/**
 *  请求：发出图片抓拍请求
 *
 *  @param devID      门铃设备ID
 *  @param completion 回调Block
 */
+ (void)requestSnapshotWithDevID:(NSString *)devID
                         success:(CompletionBlock)success
                         failure:(FailureBlock)failure;
{
    NSString *method = @"RING_SNAPSHOT";
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:devID, @"dev_id", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}


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
                               success:(CompletionBlock)success
                               failure:(FailureBlock)failure;
{
    NSString *method = @"RING_GET_WARNING_INFO";
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            devID, @"dev_id",
                            startTime, @"start_time",
                            endTime, @"end_time", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}

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
                               success:(CompletionBlock)success
                               failure:(FailureBlock)failure;
{
    NSString *method = @"RING_GET_VISITOR_SESSION_INFO";
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            devID, @"dev_id",
                            startTime, @"start_time",
                            endTime, @"end_time", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}


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
                          success:(CompletionBlock)success
                          failure:(FailureBlock)failure;
{
    NSString *method = @"RING_CONFIG";
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            devID, @"dev_id",
                            humanCheck, @"human_check",
                            lampSwitch, @"lamp_switch",
                            warningTime, @"warning_time",
                            captureNum, @"cont_cap_num",
                            tone, @"ring_tone",
                            volume, @"ring_volumn", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}

/**
 *  请求：获取门铃配置
 *
 *  @param devID      门铃设备ID
 *  @param completion 回调Block
 */
+ (void)requestGetConfigWithDevID:(NSString *)devID
                          success:(CompletionBlock)success
                          failure:(FailureBlock)failure
{
    NSString *method = @"RING_GET_CONFIG";
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:devID, @"dev_id", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}

/**
 *  请求：获取门铃状态
 *
 *  @param devID      门铃设备ID
 *  @param completion 回调Block
 */
+ (void)requestGetStatusWithDevID:(NSString *)devID
                          success:(CompletionBlock)success
                          failure:(FailureBlock)failure;
{
    NSString *method = @"RING_GET_STATUS";
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:devID, @"dev_id", nil];
    
    [self hyRequestWithParams:params
                       method:method
                      success:success
                      failure:failure];
}

@end
