//
//  TableViewDataSource.h
//  HongYunBell
//
//  Created by ZZ on 15/12/10.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

typedef void(^ConfigureCell)(UITableViewCell *cell, id model);

@interface TableViewDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithData:(NSArray *)dataArray
                  identifier:(NSString *)cellIdentifier
                       style:(UITableViewStyle)style
               configuration:(ConfigureCell)configuration;

@property (nonatomic, strong)NSArray *dataArray;
@property (nonatomic, copy)NSString *cellIdentifier;

@property (nonatomic, copy)ConfigureCell configuration;

@property (nonatomic, readonly)UITableViewStyle style;

@end
