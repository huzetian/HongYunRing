//
//  CommunicateController.h
//  HongYunBell
//
//  Created by ZZ on 15/12/15.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "BaseViewController.h"
#import "MessageModel.h"
@interface CommunicateController : BaseViewController

@property (nonatomic, strong)NSDictionary *dataDic;         //获取的数据
@property (nonatomic, strong)MessageModel *messageModel;    //获取的透传数据模型(没验证是否每次改变，若是的话最好重新管理模型)

@property (nonatomic, assign, readonly)BOOL isPresented;    //控制器是否出现（防被重复present）
/**
 *  创建单例页面
 */
+ (instancetype)shareInstance;

@end
