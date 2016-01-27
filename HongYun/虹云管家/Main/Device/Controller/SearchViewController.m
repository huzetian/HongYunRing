//
//  SearchViewController.m
//  门铃
//
//  Created by Tian on 12/11/15.
//  Copyright © 2015年 Tian. All rights reserved.
//

#import "SearchViewController.h"
//#import "NetViewController.h"

@interface SearchViewController () {
    //时间
    CGFloat _t;
}

@property (nonatomic, strong)NSTimer *timer;        //定时器
@property (nonatomic, strong)UIView *alertView;     //提示视图
@property (nonatomic, strong)UIView *maskViewA;     //遮罩视图

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.whiteView.layer.cornerRadius = 50;
    self.view.backgroundColor = [UIColor colorWithRed:0.235 green:0.725 blue:0.898 alpha:1];
    
    [self setTitle:@"搜索设备"];
    [self setDeviceItems];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    _t = 0.1;
}
- (void)viewWillAppear:(BOOL)animated {
    //视图出现，开始动画
    if (self.timer) {
        [self.timer fire];
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    //停止定时器
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    //移除提示视图
    if (self.alertView) {
        [self.alertView removeFromSuperview];
        self.alertView = nil;
    }
}
/************************ 搜索动画 ************************/
#pragma mark - 搜索动画
/**
 *  开始动画
 *
 *  @return 是否开始了动画
 */
- (BOOL)startAnimation {
    if (self.timer) {
        [self.timer fire];
        return YES;
    }
    return NO;
}

/**
 *  停止动画
 */
- (void)stopAnimation {
    if (self.timer) {
        [self.timer invalidate];
    }
}

/**
 *  执行动画
 */
- (void)timerFired {
    _t += 0.1;
    CGFloat scale = 1.1;
    [UIView animateWithDuration:0.1 animations:^{
        
        _roundView.transform = CGAffineTransformMakeRotation(_t * 2);
        self.circleWave1.transform = CGAffineTransformScale(self.circleWave1.transform, scale, scale);
        if (_t > 0.6) {
            self.circleWave2.transform = CGAffineTransformScale(self.circleWave2.transform, scale, scale);
        }
        if (_t > 1.2) {
            self.circleWave3.transform = CGAffineTransformScale(self.circleWave3.transform, scale, scale);
            
        }
        if (_t > 1) {
            self.deviceA.hidden = NO;
        }
        if (_t > 2) {
            self.deviceB.hidden = NO;
        }
        if (_t > 3) {
            self.deviceC.hidden = NO;
        }
        if (_t > 4) {
            [self setAlertViewHidden:NO];
            //            [_timer invalidate];
            [_timer setFireDate:[NSDate distantFuture]];
            _t = 0.1;
        }
    } completion:^(BOOL finished) {
    }];
    
    if (self.circleWave1.width > 1111) {
        self.circleWave1.transform = CGAffineTransformIdentity;
    }
    if (self.circleWave2.width > 1111) {
        self.circleWave2.transform = CGAffineTransformIdentity;
    }
    if (self.circleWave3.width > 1111) {
        self.circleWave3.transform = CGAffineTransformIdentity;
    }
    
    self.circleWave1.hidden = self.circleWave1.width > 200 ? NO:YES;
    self.circleWave2.hidden = self.circleWave2.width > 200 ? NO:YES;
    self.circleWave3.hidden = self.circleWave3.width > 200 ? NO:YES;
    
}

/************************ 图形属性设置 ************************/
#pragma mark - 图形属性设置
/**
 *  设置发现设备的图标
 */
- (void)setDeviceItems {
    //圆角大小
    self.deviceA.layer.cornerRadius = self.deviceA.width / 2;
    self.deviceB.layer.cornerRadius = self.deviceA.width / 2;
    self.deviceC.layer.cornerRadius = self.deviceA.width / 2;
    //边界颜色
    self.deviceA.layer.borderColor = [UIColor whiteColor].CGColor;
    self.deviceB.layer.borderColor = [UIColor whiteColor].CGColor;
    self.deviceC.layer.borderColor = [UIColor whiteColor].CGColor;
    //边界宽度
    self.deviceA.layer.borderWidth = 1.0f;
    self.deviceB.layer.borderWidth = 1.0f;
    self.deviceC.layer.borderWidth = 1.0f;
    //设备图片
    self.deviceA.image = [UIImage imageNamed:@"路由器"];
    self.deviceB.image = [UIImage imageNamed:@"门铃图标"];
    self.deviceC.image = [UIImage imageNamed:@"路由器"];
    //设置隐藏
    self.deviceA.hidden = YES;
    self.deviceB.hidden = YES;
    self.deviceC.hidden = YES;
}

/**
 *  使图形复位
 */
- (void)resetItems {
    //隐藏设备图标
    self.deviceA.hidden = YES;
    self.deviceB.hidden = YES;
    self.deviceC.hidden = YES;
    //波形复位
    self.circleWave1.transform = CGAffineTransformIdentity;
    self.circleWave2.transform = CGAffineTransformIdentity;
    self.circleWave3.transform = CGAffineTransformIdentity;
    //波形隐藏
    self.circleWave1.hidden = YES;
    self.circleWave2.hidden = YES;
    self.circleWave3.hidden = YES;
}

#pragma mark - /************************ * 视图：提示视图 ************************/
/**
 *  创建提示视图
 */
- (void)setAlertViewHidden:(BOOL)hidden {
    
    //添加遮罩视图
    [self setMaskviewHidden:hidden];
    
    //创建提示视图
    if (self.alertView == nil) {
        
        self.alertView = [[UIView alloc] initWithFrame:CGRectMake(20, kScreenHeight / 2 - 100, kScreenWidth - 40, 200)];
        self.alertView.backgroundColor = [UIColor colorWithRed:0.827 green:0.882 blue:0.901 alpha:1];
        self.alertView.layer.cornerRadius = 10;
        self.alertView.layer.masksToBounds = YES;
        self.alertView.userInteractionEnabled = YES;
        [self.view.window addSubview:self.alertView];
        
        //标题视图
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.alertView.width, self.alertView.height / 3)];
        titleLabel.text = @"搜索完成";
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.alertView addSubview:titleLabel];
        
        //提示内容的白色背景视图
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, self.alertView.height / 3, self.alertView.width, _alertView.height / 3)];
        whiteView.backgroundColor = [UIColor colorWithRed:0.843 green:0.902 blue:0.929 alpha:0.8];
        [_alertView addSubview:whiteView];
        
        //提示内容
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.alertView.width, self.alertView.height / 3)];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.text = @"发现一个可添加设备";
        textLabel.textColor = [UIColor blackColor];
        [whiteView addSubview:textLabel];
        
        //重新搜索按钮
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.alertView.height / 3 * 2, self.alertView.width / 2, _alertView.height / 3)];
        [leftButton setTitle:@"重新搜索" forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(research:) forControlEvents:UIControlEventTouchUpInside];
        [_alertView addSubview:leftButton];
        
        //设置添加按钮
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(_alertView.width/2, _alertView.height/3*2, _alertView.width/2, _alertView.height/3)];
        [rightButton setTitle:@"设置添加" forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(set) forControlEvents:UIControlEventTouchUpInside];
        [_alertView addSubview:rightButton];
    }

    //移除视图
    if (hidden) {
        [self.alertView removeFromSuperview];
    }
    //添加视图
    else {
        [self.view.window addSubview:self.alertView];
    }

}

/**
 *  重新搜索
 */
- (void)research:(UIButton *)button {
    
    [self setAlertViewHidden:YES];
    
    [self resetItems];
    //开启定时器
    [self.timer setFireDate:[NSDate distantPast]];
}
/**
 *  添加搜索到的设备，关闭动画
 */
- (void)addDevice:(UIButton *)button {
    
    
}



#pragma mark - 遮罩视图点击
/**
 *  遮罩视图点击，使其无操作
 */
- (void)maskTapAction:(UIButton *)maskView {
    /**
     *  Do nothing. Must handle alert view first!
     */
}


@end
