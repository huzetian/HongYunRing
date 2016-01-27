//
//  MySocketRequest.m
//  HongYunRoute
//
//  Created by ZZ on 15/11/23.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "MySocketRequest.h"
@implementation MySocketRequest

- (instancetype)initWithParams:(NSDictionary *)params
                        method:(NSString *)method
                     requestID:(NSInteger)requestID
                    completion:(CompletionBlock)completion;
{
    if (self = [super init]) {
        _cloudVersion = HYVersion;
        _params = params;
        _method = method;
        _requestID = requestID;
        _completion = completion;
    }
    return self;
}

//#pragma mark - 发送数据
///**
// *  发送数据
// *
// *  @param params       数据参数
// *  @param method       请求方法
// *  @param dataID       id
// *  @param businessType 业务类型
// *  @param completion   回调Block
// */
//+ (void)hyRequestWithParams:(NSDictionary *)params
//                     method:(NSString *)method
//                     dataID:(NSInteger)dataID
//               businessType:(HYBusinessType)businessType
//                 completion:(CompletionBlock)completion
//{
//    //格式构造
//    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
//    [dataDic setObject:HYVersion forKey:@"zl_cloud"];
//    [dataDic setObject:method forKey:@"method"];
//    [dataDic setObject:params forKey:@"params"];
//    [dataDic setObject:[NSNumber numberWithInteger:dataID] forKey:@"id"];
//    
//    //添加结束符
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:nil];
//    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    message  = [message stringByAppendingString:@"\r\n"];
//    data = [message dataUsingEncoding:NSUTF8StringEncoding];
//    
//    //发送数据
//    MySocket *mysock = [MySocket shareInstance];
//    
//    [mysock writeDataWithData:data
//                    businessType:businessType
//                             tag:101
//                      completion:completion];
//}
//
//#pragma mark - 网络请求
//#pragma mark - 临时业务
//
///**
// *  请求：设置业务类型
// *
// *  @param type       临时业务类型
// *  @param completion 回调Block
// */
//
//+ (MySocketRequest *)requestBusinessTypeWithType:(NSString *)type
//{
//    NSString *method = @"SET_TEMP_SVC_TYPE";
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:type, @"type", nil];
//    
//    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessTemp completion:completion];
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessTemp];
//}
///**
// *  请求：获取验证码
// *
// *  @param phoneNum   手机号码
// *  @param completion 回调Block
// */
//+ (MySocketRequest *)requestVerificationCodeWithPhoneNum:(NSString *)phoneNum
//{
//    NSString *method = @"GET_VERIFICATION_CODE";
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:phoneNum, @"phone_num", nil];
//    
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessTemp];
//
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessTemp completion:completion];
//}
//
///**
// *  请求：注册用户
// *
// *  @param verificationCode 验证码
// *  @param password         密码
// *  @param completion       回调Block
// */
//+ (MySocketRequest *)requestRegisterWithVerificationCode:(NSString *)verificationCode
//                                   password:(NSString *)password
//{
//    NSString *method = @"REG_USER_TERMINAL";
//    //密码加密
//    password = [[password sha1] uppercaseString];
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            verificationCode, @"verification_code",
//                            password, @"hashed_pwd", nil];
//
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessTemp];
//
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessTemp completion:completion];
//}
//
//
//#pragma mark - 账号登陆
///**
// *  请求：账号登录
// *
// *  @param loginID    账户ID
// *  @param password   密码
// *  @param completion 回调Block
// */
//+ (MySocketRequest *)requestLoginWithID:(NSString *)loginID
//                  password:(NSString *)password
//{
//    NSString *method = @"LOGIN";
//    //密码加密
////    password = [[password sha1] uppercaseString];
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            loginID, @"login_id",
//                            password, @"hashed_pwd", nil];
//
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
//
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//}
//
///**
// *  请求：APP通过验证码登陆
// *
// *  @param phoneNum   手机号码
// *  @param code       验证码
// *  @param completion 回调Block
// */
//+ (MySocketRequest *)requestLoginWithPhoneNum:(NSString *)phoneNum
//                veriticationCode:(NSString *)code
//{
//    NSString *method = @"LOGIN_BY_CODE";
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            phoneNum, @"phone_num",
//                            code, @"veritication_code", nil];
//    
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
//
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//}
//
//
//#pragma mark - 密码、昵称
///**
// *  请求：修改密码
// *
// *  @param oldPwd     旧密码（加密）
// *  @param newPwd     新密码（加密）
// *  @param completion 回调Block
// */
//+ (MySocketRequest *)requestChangePasswordWithOldPwd:(NSString *)oldPwd
//                                 newPwd:(NSString *)newPwd
//{
//    NSString *method = @"CHANGE_PWD";
//    //密码加密
//    oldPwd = [[oldPwd sha1] uppercaseString];
//    newPwd = [[newPwd sha1] uppercaseString];
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            oldPwd, @"old_hashed_pwd",
//                            newPwd, @"new_hashed_pwd", nil];
//    
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
//
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//}
//
///**
// *  请求：重置密码
// *
// *  @param code       手机验证码
// *  @param newPwd     新密码（加密）
// *  @param completion 回调Block
// */
//+ (MySocketRequest *)requestResetPasswordWithVerificationCode:(NSString *)code
//                                          newPwd:(NSString *)newPwd
//{
//    NSString *method = @"RESET_PWD";
//    //密码加密
//    newPwd = [[newPwd sha1] uppercaseString];
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            code, @"verification_code",
//                            newPwd, @"new_hashed_pwd", nil];
//
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//}
//
///**
// *  请求：设置账户昵称
// *
// *  @param nickName   昵称
// *  @param completion 回调Block
// */
//+ (MySocketRequest *)requestSetNickNameWithName:(NSString *)nickName
//{
//    NSString *method = @"SET_NICKNAME";
//    
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:nickName, @"dev_name", nil];
//
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//}
//
//
//#pragma mark - 上传反馈、异常
///**
// *  请求：上传用户反馈
// *
// *  @param reportText 反馈内容
// *  @param picsArray  反馈图片
// *  @param completion 回调Block
// */
//+ (MySocketRequest *)requestUploadUserReportWithText:(NSString *)reportText
//                                   pics:(NSArray *)picsArray
//{
//    NSString *method = @"UPLOAD_USER_REPORT";
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            reportText, @"report_text",
//                            picsArray, @"report_pics", nil];
//
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//}
//
//
///**
// *  请求：上传APP异常处理
// *
// *  @param phoneType    手机类型
// *  @param phoneVersion 手机版本
// *  @param appVersion   APP版本
// *  @param exception    内容
// *  @param completion   回调Block
// */
//+ (MySocketRequest *)requestUploadAppErrorWithPhoneType:(NSString *)phoneType
//                              phoneVersion:(NSString *)phoneVersion
//                                appVersion:(NSString *)appVersion
//                                 exception:(NSString *)exception
//{
//    NSString *method = @"UPLOAD_APP_EXCEPTION_REPORT";
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            phoneType, @"phone_type",
//                            phoneVersion, @"phone_version",
//                            appVersion, @"app_version",
//                            exception, @"exception", nil];
//
//    
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//}
//
//
//#pragma mark - 设备管理
///**
// *  请求：获取设备列表
// *
// *  @param completion 回调Block
// */
//+ (MySocketRequest *)requestGetDeviceList
//{
//    NSString *method = @"GET_DEV_LIST";
//    NSDictionary *params = [NSDictionary dictionary];
//
//    
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//}
//
///**
// *  请求：获取设备拥有者
// *
// *  @param devID      设备ID
// *  @param completion 回调Block
// */
//+ (MySocketRequest *)requestGetDeviceOwnerWithDevID:(NSString *)devID
//{
//    NSString *method = @"GET_DEV_OWNER";
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:devID, @"dev_id", nil];
//
//    
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//}
///**
// *  请求：设置设备昵称
// *
// *  @param devID      设备ID
// *  @param nickname   昵称
// *  @param completion 回调Block
// */
//+ (MySocketRequest *)requestSetDeviceNicknameWithDevID:(NSString *)devID
//                                 nickname:(NSString *)nickname
//{
//    NSString *method = @"SET_DEV_NICKNAME";
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            devID, @"dev_id",
//                            nickname, @"nickname", nil];
//
//    
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//}
//
///**
// *  请求：添加设备
// *
// *  @param devID       设备ID
// *  @param isEncrypted 是否加密
// *  @param completion  回调Block
// */
//+ (MySocketRequest *)requestAddDeviceWithDevID:(NSString *)devID
//                      isEncrypted:(BOOL)isEncrypted
//{
//    NSString *method = @"ADD_DEV_TO_USER";
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            devID, @"dev_id",
//                            isEncrypted, @"is_encrypted", nil];
//
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//
//}
//
///**
// *  请求：删除设备
// *
// *  @param devID      设备ID
// *  @param completion 回调Block
// */
//+ (MySocketRequest *)requestDeleteDevicewithDevID:(NSString *)devID
//{
//    NSString *method = @"DEL_DEV_FROM_USER";
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:devID, @"dev_id", nil];
//    
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//}
//
//
//
///**
// *  请求：分享设备
// *
// *  @param devID      设备ID
// *  @param userID     分享用户ID
// *  @param completion 回调Block
// */
//+ (MySocketRequest *)requestShareWithDeviceID:(NSString *)devID userID:(NSString *)userID
//{
//    NSString *method = @"SHARE_DEV";
//
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            devID, @"shared_dev_id",
//                            userID, @"to_user_id", nil];
//    
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
//
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//}
//
///**
// *  请求：取消分享
// *
// *  @param devID      被取消设备ID
// *  @param userID     被取消用户ID
// *  @param completion 回调Block
// */
//+ (MySocketRequest *)requestCancelShareWithDeviceID:(NSString *)devID
//                                userID:(NSString *)userID
//{
//    NSString *method = @"CANCEL_SHARE_DEV";
//
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            devID, @"shared_dev_id",
//                            userID, @"to_user_id", nil];
//    
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
//
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//}
//
//
//#pragma mark - 透传消息
///**
// *  请求：透传消息
// *
// *  @param msg        透传消息
// *  @param to         到达的用户或终端
// *  @param completion 回调Block
// */
//+ (MySocketRequest *)requestRelayMessageWithMessage:(NSString *)msg
//                                    to:(NSString *)to
//{
//    NSString *method = @"RELAY_MSG";
//    //密码加密
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            msg, @"original_msg",
//                            to, @"to", nil];
//    
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
//
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//}
//
//#pragma mark - 链路心跳
///**
// *  请求：链路心跳
// *
// *  @param completion 回调Block
// */
//+ (MySocketRequest *)requestHeartBeat
//{
//    NSString *method = @"HEARTBEAT";
//    
//    NSDictionary *params = [NSDictionary dictionary];
//    
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
//
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//}
//
//
//
//#pragma mark - 语音呼叫
///**
// *  请求：接受语音呼叫请求
// *
// *  @param devID      门铃设备ID
// *  @param requestID  门铃设备呼叫请求ID
// *  @param completion 回调Block
// */
//+ (MySocketRequest *)requestCallAcceptWithDevID:(NSString *)devID
//                     callRequestID:(NSString *)requestID
//{
//    NSString *method = @"RING_CALL_ACCEPT";
//    
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            devID, @"dev_id",
//                            requestID, @"call_request_id", nil];
//    
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
//
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//}
//
///**
// *  请求：拒绝语音请求
// *
// *  @param devID      门铃设备ID
// *  @param requestID  门铃设备呼叫请求ID
// *  @param reason     拒绝请求原因，取值为<#原因#>
// *  @param completion 回调Block
// */
//+ (MySocketRequest *)requestCallRejectWithDevID:(NSString *)devID
//                     callRequestID:(NSString *)requestID
//                            reason:(NSString *)reason
//{
//    NSString *method = @"RING_CALL_REJECT";
//    
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            devID, @"dev_id",
//                            reason, @"reason",
//                            requestID, @"call_request_id", nil];
//    
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
//
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//}
//
///**
// *  请求：发送语音
// *
// *  @param to         发送设备ID
// *  @param photo      图片服务器的通信协议【目前仅支持@"http"（小写）】,若无字段则默认为@"http"
// *  @param host       图片服务器IP地址
// *  @param path       语音文件存放路径
// *  @param completion 回调Block
// */
//+ (MySocketRequest *)requestSendVoiceToID:(NSString *)to
//                       photo:(NSString *)photo
//                        host:(NSString *)host
//                        path:(NSString *)path
//{
//    NSString *method = @"RING_SEND_VOICE";
//    
//    NSDictionary *voice = [NSDictionary dictionaryWithObjectsAndKeys:
//                           photo, @"proto",
//                           host, @"host",
//                           path, @"path", nil];
//    
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            to, @"to",
//                            voice, @"voice",
//                            path, @"path", nil];
//    
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
//
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//}
//
//#pragma mark - 图片抓拍请求
///**
// *  请求：发出图片抓拍请求
// *
// *  @param devID      门铃设备ID
// *  @param completion 回调Block
// */
//+ (MySocketRequest *)requestSnapshotWithDevID:(NSString *)devID
//{
//    NSString *method = @"RING_SNAPSHOT";
//    
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:devID, @"dev_id", nil];
//    
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
//
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//}
//
//
//#pragma mark - 告警、访客信息
///**
// *  请求：获取告警信息
// *
// *  @param devID      门铃设备ID
// *  @param startTime  起始查询时间（格式：YYYY-MM-DD HH:MM:SS）
// *  @param endTime    终止查询时间（格式：YYYY-MM-DD HH:MM:SS）
// *  @param completion 回调Block
// */
//+ (MySocketRequest *)requestGetWarningInfoWithDevID:(NSString *)devID
//                             startTime:(NSString *)startTime
//                               endTime:(NSString *)endTime
//{
//    NSString *method = @"RING_GET_WARNING_INFO";
//    
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            devID, @"dev_id",
//                            startTime, @"start_time",
//                            endTime, @"end_time", nil];
//    
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
//
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//}
//
///**
// *  请求：获取访客信息
// *
// *  @param devID      门铃设备ID
// *  @param startTime  起始查询时间（格式：YYYY-MM-DD HH:MM:SS）
// *  @param endTime    终止查询时间（格式：YYYY-MM-DD HH:MM:SS）
// *  @param completion 回调Block
// */
//+ (MySocketRequest *)requestGetVisitorInfoWithDevID:(NSString *)devID
//                             startTime:(NSString *)startTime
//                               endTime:(NSString *)endTime
//{
//    NSString *method = @"RING_GET_VISITOR_SESSION_INFO";
//    
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            devID, @"dev_id",
//                            startTime, @"start_time",
//                            endTime, @"end_time", nil];
//    
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
//
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//}
//
//
//#pragma mark - 门铃配置、状态
///**
// *  请求：设置门铃配置
// *
// *  @param devID       门铃设备ID
// *  @param humanCheck  人形检查 0：不开启人形检查，1：开启人形检查
// *  @param lampSwitch  门铃灯  0：关闭门铃灯，1：开启门铃灯
// *  @param warningTime 门铃告警时间（需开启人性检查），取值[1,20](s)
// *  @param captureNum  连拍张数，取值[1,5]
// *  @param tone        门铃铃声索引，取值[1,10]
// *  @param volume      门铃音量等级，取值[1,100]
// *  @param completion  回调Block
// */
//+ (MySocketRequest *)requestSetConfigWithDevID:(NSString *)devID
//                      hunmanCheck:(NSInteger)humanCheck
//                       lampSwitch:(NSInteger)lampSwitch
//                      warningTime:(NSInteger)warningTime
//                       captureNum:(NSInteger)captureNum
//                         toneType:(NSInteger)tone
//                           volume:(NSInteger)volume
//{
//    NSString *method = @"RING_CONFIG";
//    
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            devID, @"dev_id",
//                            humanCheck, @"human_check",
//                            lampSwitch, @"lamp_switch",
//                            warningTime, @"warning_time",
//                            captureNum, @"cont_cap_num",
//                            tone, @"ring_tone",
//                            volume, @"ring_volumn", nil];
//    
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
//
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//}
//
///**
// *  请求：获取门铃配置
// *
// *  @param devID      门铃设备ID
// *  @param completion 回调Block
// */
//+ (MySocketRequest *)requestGetConfigWithDevID:(NSString *)devID
//{
//    NSString *method = @"RING_GET_CONFIG";
//    
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:devID, @"dev_id", nil];
//    
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
//
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//
//}
//
///**
// *  请求：获取门铃状态
// *
// *  @param devID      门铃设备ID
// *  @param completion 回调Block
// */
//+ (MySocketRequest *)requestGetStatusWithDevID:(NSString *)devID
//{
//    NSString *method = @"RING_GET_STATUS";
//    
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:devID, @"dev_id", nil];
//    
//    return [[MySocketRequest alloc] initWithParams:params method:method msgID:10 bussinessType:HYBusinessNormal];
//
////    [self hyRequestWithParams:params method:method dataID:10 businessType:HYBusinessNormal completion:completion];
//}

@end
