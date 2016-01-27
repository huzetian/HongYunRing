//
//  ConfigurationModel.h
//  HongYunBell
//
//  Created by ZZ on 16/1/12.
//  Copyright © 2016年 zhangzheng. All rights reserved.
//

#import "BaseModel.h"

/**
 *  门铃设置项模型
 */
@interface ConfigurationModel : BaseModel

@property (nonatomic, assign)BOOL hunmanCheck;          //是否开始智能人体侦测
@property (nonatomic, assign)BOOL lampSwitch;           //是否开启门铃灯

@property (nonatomic, assign)NSInteger warningTime;     //警告时间
@property (nonatomic, assign)NSInteger captureNum;      //连拍张数
//@property (nonatomic, assign)NSInteger warningType;     //告警模式
//@property (nonatomic, assign)NSInteger monitorRange;    //监控范围

@property (nonatomic, assign)NSInteger toneType;        //铃声类型
@property (nonatomic, assign)NSInteger volume;          //铃声音量

@end
