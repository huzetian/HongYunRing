//
//  ActionModel.h
//  HongYunBell
//
//  Created by ZZ on 15/12/25.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "BaseModel.h"

/**
 *  会话操作模型
 */
@interface ActionModel : BaseModel

@property (nonatomic, copy)NSString *action;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *dateTime;
@property (nonatomic, copy)NSString *sender;

@end
