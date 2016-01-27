//
//  TabBarButton.h
//  HongYunBell
//
//  Created by imac on 15/11/11.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarButton : UIButton

@property (nonatomic, strong)UIImage *image;
@property (nonatomic, copy)NSString *title;

- (void)setTitle:(NSString *)title image:(UIImage *)image;

@end
