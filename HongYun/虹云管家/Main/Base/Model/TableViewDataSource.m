//
//  TableViewDataSource.m
//  HongYunBell
//
//  Created by ZZ on 15/12/10.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "TableViewDataSource.h"

@implementation TableViewDataSource

- (instancetype)initWithData:(NSArray *)dataArray
                  identifier:(NSString *)cellIdentifier
                       style:(UITableViewStyle)style
               configuration:(ConfigureCell)configuration
{
    if (self = [super init]) {
        _dataArray = dataArray;
        _cellIdentifier = cellIdentifier;
        _style = style;
        _configuration = configuration;
    }
    return self;
}

- (NSArray *)itemsAtSection:(NSInteger)section {
    if (_style == UITableViewStyleGrouped) {

        if ([self.dataArray[section] isKindOfClass:[NSArray class]]) {
            return self.dataArray[section];
        }
    }
    else if (_style == UITableViewStylePlain) {
        return self.dataArray;
    }
    return nil;
}
/************************ UITableDataSource ************************/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self itemsAtSection:section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    
    id model = [[self itemsAtSection:indexPath.section] objectAtIndex:indexPath.row];
    
    if (self.configuration) {
        self.configuration(cell, model);
    }
    
    return cell;
}

@end
