//
//  UIView+Controller.m
//  微博-01
//
//  Created by imac on 15/9/20.
//  Copyright (c) 2015年 zhangzheng. All rights reserved.
//

#import "UIView+Controller.h"

@implementation UIView (Controller)

- (UIViewController *)controller
{    
    UIResponder *responder = self.nextResponder;
    
    while (responder) {
        
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    }
    
    return nil;
}

@end
