//
//  AddEquView.h
//  门铃
//
//  Created by TIAN on 16/1/21.
//  Copyright © 2016年 Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  添加设备的Item视图
 */
@interface AddingItem : UIView

@property (nonatomic,strong)UIButton *itemButton;       //背景图
@property (nonatomic,strong)UIImageView *itemPattern;   //设备图标
@property (nonatomic,strong)UIImageView *addView;       //加号图形
@property (nonatomic,strong)UILabel *itemTitle;         //标题

/**
 *  初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame;

/**
 *  设置item属性
 *
 *  @param image 设备图标
 *  @param title 标题
 */
- (void)setItemWithPattern:(UIImage *)image title:(NSString *)title;

@end
