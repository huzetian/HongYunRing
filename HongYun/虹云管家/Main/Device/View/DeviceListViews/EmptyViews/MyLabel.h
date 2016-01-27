//
//  MyLabel.h
//  HongYunBell
//
//  Created by ZZ on 16/1/11.
//  Copyright © 2016年 zhangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLabel : UILabel

@property (nonatomic, copy)void(^tapAction)(void);


/**
 *  初始化方法
 *
 *  @param frame           frame大小
 *  @param text            文本
 *  @param textColor       文本颜色
 *  @param range           文本点击范围
 *  @param actionTextColor 链接文本颜色
 *  @param action          点击动作回调
 *
 *  @return wenben  文本label
 */
- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor actionTextRange:(NSRange)range actionTextColor:(UIColor *)actionTextColor tapAction:(void (^)())action;

/**
 *  属性设置
 *
 *  @param text            文本
 *  @param textColor       文本颜色
 *  @param range           文本点击范围
 *  @param actionTextColor 点击动作回调
 */
- (void)setText:(NSString *)text textColor:(UIColor *)textColor actionTextRange:(NSRange)range actionTextColor:(UIColor *)actionTextColor;

@end
