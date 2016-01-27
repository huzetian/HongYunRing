//
//  MessageModel.h
//  HongYunBell
//
//  Created by ZZ on 15/12/15.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "BaseModel.h"
#import "MySocketRequest.h"
/**
 *  透传消息模型
 */
@interface MessageModel : BaseModel

@property (nonatomic, copy)NSString *from;          //信源
@property (nonatomic, copy)NSString *to;            //信宿
@property (nonatomic, strong)MySocketRequest *msg;  //信源发出的原请求

@end
