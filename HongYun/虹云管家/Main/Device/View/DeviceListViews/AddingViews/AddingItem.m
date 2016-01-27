//
//  AddEquView.m
//  门铃
//
//  Created by TIAN on 16/1/21.
//  Copyright © 2016年 Tian. All rights reserved.
//

#import "AddingItem.h"

@implementation AddingItem

/**
 *  初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.layer.masksToBounds = YES;
        [self createSubviews];
    }
    return self;
}

/**
 *  创建子视图
 */
- (void)createSubviews {
    //背景
    self.itemButton = [[UIButton alloc] initWithFrame:self.bounds];
    [self.itemButton setImage:[UIImage imageNamed:@"门锁初始配置_19"] forState:UIControlStateNormal];
    [self addSubview:self.itemButton];
    
    //设备图标
    self.itemPattern = [[UIImageView alloc]initWithFrame:CGRectMake(self.width * 29 / 100, self.height / 5, self.width / 50 * 21, self.width / 50 * 21)];
    self.itemPattern.image = [UIImage imageNamed:@"门锁初始配置_25"];
    [self addSubview:self.itemPattern];
    
    //加号图形
    self.addView = [[UIImageView alloc]initWithFrame:CGRectMake(self.width * 7 / 30, self.height / 150 * 119, self.width / 15 * 2, self.width / 15 * 2)];
    self.addView.image = [UIImage imageNamed:@"门锁初始配置_22"];
    [self addSubview:self.addView];
    
    //标题
    self.itemTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.addView.right + self.width / 150 * 4, self.itemPattern.bottom + self.width / 5, 60, 13)];
    self.itemTitle.font = [UIFont systemFontOfSize:12];
    self.itemTitle.text = @"添加门铃";
    [self addSubview:self.itemTitle];

}

/**
 *  设置item属性
 *
 *  @param image 设备图标
 *  @param title 标题
 */
- (void)setItemWithPattern:(UIImage *)image title:(NSString *)title {
    
    self.itemPattern.image = image;
    self.itemTitle.text = title;
}

@end
