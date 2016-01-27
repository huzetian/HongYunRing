//
//  SetDevNicknameView.h
//  HongYunBell
//
//  Created by ZZ on 16/1/24.
//  Copyright © 2016年 zhangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  设置昵称视图
 */
@interface SetDevNicknameView : UIImageView

@property (nonatomic, strong)UITextField *textField;        //输入框

@property (nonatomic, copy)void (^cancelBlock)(void);       //取消操作
@property (nonatomic, copy)void (^confirmBlock)(NSString *nickname);    //确定操作

/**
 *  初始化方法
 *
 *  @param frame frame大小
 *
 *  @return 视图
 */
- (instancetype)initWithFrame:(CGRect)frame;

@end
