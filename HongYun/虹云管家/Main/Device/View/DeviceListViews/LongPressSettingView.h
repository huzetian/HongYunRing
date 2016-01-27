//
//  LongView.h
//  门铃
//
//  Created by TIAN on 15/12/29.
//  Copyright © 2015年 Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LongPressSettingView : UIView
/**
 *  长按设置视图
 */

/**
 *  点击按钮时的回调
 */
@property (nonatomic, copy)void (^tapAction)(UIButton *button, NSInteger row);

/**
 *  视图创建方法
 *
 *  @param frame    frame大小
 *  @param tapBlock 点击回调
 *
 *  @return 创建的对象
 */
- (instancetype)initWithFrame:(CGRect)frame tapAction:(void (^)(UIButton *button, NSInteger row))action;

@end
