//
//  VisitorModel.h
//  HongYunBell
//
//  Created by ZZ on 15/11/17.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "BaseModel.h"
#import "ActionModel.h"
/**
 *  会话信息模型（一次）
 */
@interface VisitorModel : BaseModel

@property (nonatomic, copy)NSString *devID;
@property (nonatomic, copy)NSString *endDateTime;
@property (nonatomic, copy)NSString *startDateTime;
@property (nonatomic, strong)NSMutableArray *sessionArray;
@property (nonatomic, strong)NSMutableArray *userIDs;

@property (nonatomic, copy, readonly)NSString *date;
@property (nonatomic, copy, readonly)NSString *time;

@end
