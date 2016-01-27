//
//  TabBarButton.m
//  HongYunBell
//
//  Created by imac on 15/11/11.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "TabBarButton.h"

@implementation TabBarButton

- (void)setTitle:(NSString *)title image:(UIImage *)image {
    [self setTitle:title];
    [self setImage:image];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    //起始高度
    CGFloat height = 5;
    //图标的边长
    CGFloat imageWidth = 25;
    //图片
    [_image drawInRect:CGRectMake((self.width - imageWidth) / 2 , height, imageWidth, imageWidth)];
    //文字
    CGRect titleRect = CGRectMake(0, height + imageWidth + 2, self.width, self.height / 2);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentCenter;

    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [UIFont systemFontOfSize:12.0f], NSFontAttributeName,
                         ColorMakeRGBA(0, 0, 0, 1), NSForegroundColorAttributeName,
                         paragraphStyle, NSParagraphStyleAttributeName, nil];

    [_title drawInRect:titleRect withAttributes:dic];
    
}

@end
