//
//  LoginViewController.m
//  HongYunBell
//
//  Created by imac on 15/11/13.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController () {
    
    NSInteger _t;
    
}
@property (nonatomic, strong)NSTimer *timer;

@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *identifyingField;
@property (weak, nonatomic) IBOutlet UIButton *identifyingButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)awakeFromNib {

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"账号登陆"];
    
    //自定义返回按钮
    UIImage *backImage = [UIImage imageNamed:@"图层-34.png"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:backImage forState:UIControlStateNormal];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:buttonItem];
    
    //设置标题栏黑色字体
    UILabel *titleLabel = (UILabel *)self.navigationItem.titleView;
    titleLabel.textColor = [UIColor blackColor];
    
    //去除navigationBar底部的阴影
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
}

/**
 *  设置状态栏颜色：黑色
 *
 *  @return 状态栏颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


/**
 *  获取验证码
 *
 *  @param button 获取按钮
 */
- (IBAction)getIdentifyingCode:(UIButton *)button {
    
    NSLog(@"获取验证码");
    //检查输入手机号格式
    if (![self checkTel:self.identifyingField.text]) {
        return;
    }
    
    button.userInteractionEnabled = NO;
    _t = 5;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                              target:self
                                            selector:@selector(timerBeginCount:)
                                            userInfo:nil
                                             repeats:YES];
    [_timer fire];
}

- (void)timerBeginCount:(NSTimer *)timer {
    _t--;
    NSLog(@"%li", (long)_t);
    if (_t > 0) {
        [_identifyingButton setTitle:[NSString stringWithFormat:@"%li(s)", (long)_t] forState:UIControlStateNormal];
    }
    else {
        [timer invalidate];
        _identifyingButton.userInteractionEnabled = YES;
        [_identifyingButton setTitle:@"重新获取" forState:UIControlStateNormal];
    }
}

/**
 *  登陆操作
 *
 *  @param sender 登陆按钮
 */
- (IBAction)login:(id)sender {
    NSLog(@"登录操作");
    
    NSString *userID = _accountField.text;
    NSString *pwd = _identifyingField.text;
    
    [[UserManager shareInstance] logInWithID:userID loginPwd:pwd completion:^(NSDictionary *result) {
        
        if ([result objectForKey:@"error"]) {
            NSLog(@"error : %@ (%@)", [result objectForKey:@"error"], [self class]);
            return;
        }
        //移除视图
        [self dismiss];
    }];
}

/**
 *  返回视图
 */
- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)checkTel:(NSString *)str {
    
    if ([str length] == 0) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"手机号不能为空", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return NO;
    }
    
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    NSString *regex = @"^1((3//d|5[0-35-9]|8[025-9])//d|70[059])\\d{7}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return NO;
    }
    
    return YES;
}



@end
