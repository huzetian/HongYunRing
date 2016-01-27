//
//  MessageModel.m
//  HongYunBell
//
//  Created by ZZ on 15/12/15.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

- (void)setAttributes:(NSDictionary *)dataDic {
    [super setAttributes:dataDic];
    
    NSDictionary *dic = [dataDic objectForKey:@"msg"];
    if (dic == nil) {
        return;
    }
    NSDictionary *params = [dic objectForKey:@"params"];
    NSString *method = [dic objectForKey:@"method"];
    NSInteger requestID = [[dic objectForKey:@"id"] integerValue];
    
    self.msg = [[MySocketRequest alloc] initWithParams:params method:method requestID:requestID completion:nil];
}

@end
