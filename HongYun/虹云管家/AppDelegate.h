//
//  AppDelegate.h
//  虹云管家
//
//  Created by ZZ on 16/1/22.
//  Copyright © 2016年 HongYun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UserManager *userManager;

@end

