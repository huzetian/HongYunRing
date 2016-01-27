//
//  DeviceList.m
//  HongYunBell
//
//  Created by imac on 15/11/10.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "DeviceListController.h"
#import "AppDelegate.h"
#import "LongPressSettingView.h"
#import "SetDevNicknameView.h"
@interface DeviceListController ()

/**
 *  数据
 */
@property (nonatomic, strong)NSMutableArray *dataArray;         //设备列表数组

/**
 *  各层次试图
 */
@property (nonatomic, strong)DeviceTableView *tableView;        //设备列表
@property (nonatomic, strong)DeviceEmptyView *deviceEmptyView;  //添加为空
@property (nonatomic, strong)DeviceAddingView *addingView;      //添加设备

/**
 *  小视图
 */
@property (nonatomic, strong)UIView *statusBar;                 //网络状态栏
@property (nonatomic, strong)LongPressSettingView *longPressSettingView;    //长按设置视图
@property (nonatomic, strong)SetDevNicknameView *setDevNickNameView;        //设置昵称视图


/**
 *  定时器
 */
@property (nonatomic, strong)NSTimer *refreshTimer;             //刷新定时器

@end

@implementation DeviceListController

#pragma mark - 生命周期、初始化

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVC];
}

/**
 *  在 self.view 出现时，调用 setLoginViewHidden: ，显示登陆条
 */
- (void)viewWillAppear:(BOOL)animated {
    //若未登录出现登陆条
    if (![UserManager shareInstance].isLoggedin) {
        [self setLoginViewHidden:NO];
        NSLog(@"%@", self.appWindow.subviews);
    }
    [self loadData:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    //停止定时器
}

- (void)initVC {
    //标题
    [self setTitle:@"设备列表"];
    //创建添加设备按钮
    [self createRightButtonItem];
    
    //设备空界面
    [self showDeviceEmptyView];
    
    //加载列表
    [self loadData:nil];
    //    [self autoRefreshData];
    
    //监听网络环境改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    //监听登陆成功通知，获取列表
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadData:)
                                                 name:loginNotification
                                               object:nil];
    
}

#pragma mark - reachabilityChanged 网络环境变化，出现提示条
-(void)reachabilityChanged:(NSNotification *)note {
    
    Reachability *reachability = [note object];
    NetworkStatus status = reachability.currentReachabilityStatus;
    
    [self setNetworkStatusBarHidden:(status != NotReachable)];
}

#pragma mark - 登陆、登出改变状态
- (void)reloadViewController:(NSNotification *)noti {
    //登陆
    if ([noti.name isEqualToString:loginNotification]) {
        [self showTabelView];
        [self loadData:nil];
    }
    //退出
    else if ([noti.name isEqualToString:logoutNotification]) {
        [self showDeviceEmptyView];
    }
}

/************************ 数据加载 ************************/
#pragma mark - 加载数据
- (void)autoRefreshData {
    
    NSLog(@"开启定时器");
    if (self.refreshTimer == nil) {
        self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(loadData:) userInfo:nil repeats:YES];
    }
    [self.refreshTimer fire];
}

/**
 *  加载设备列表数据
 */
- (void)loadData:(NSTimer *)timer {
    
    [RequestMethod requestGetDeviceListSuccess:^(NSDictionary *result) {
        //数据数组
        self.dataArray = [NSMutableArray array];
        
        NSDictionary *devResult = [result objectForKey:@"result"];
        NSArray *ownedDev = [devResult objectForKey:@"owned_devs"];
        
        //遍历，保存
        for (NSDictionary *devDic in ownedDev) {
            
            DeviceModel *model = [[DeviceModel alloc] initWithDataDic:devDic];
            
            [self.dataArray addObject:model];
        }
        
        //设备数量大于0显示tableView
        if (self.dataArray.count > 0) {
            
            [self showTabelView];
        }
        //设备数量为0，显示添加设备视图
        else {
            
            [self showDeviceEmptyView];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark 取消遮罩视图
- (void)maskTapAction:(UIButton *)button {
    [super maskTapAction:button];
    
    //隐藏长按设置视图
    if (self.longPressSettingView) {
        [self setLongPressSettingViewHidden:YES device:nil];
    }
    //隐藏设置昵称视图
    if (self.setDevNickNameView) {
        [self setSetDevNicknameViewHidden:YES device:nil];
    }
}

#pragma mark - 视图
/************************ 辅视图：网络状态栏 ************************/
#pragma mark - * 辅视图：网络状态栏
/**
 *  创建并设置网络状态栏
 *
 *  @param hidden 是否隐藏
 */
- (void)setNetworkStatusBarHidden:(BOOL)hidden {
    
    if (self.statusBar == nil) {
        //状态栏view
        self.statusBar = [[UIView alloc] initWithFrame:CGRectMake(0, -25, kScreenWidth, 25)];
        self.statusBar.backgroundColor = ColorMakeRGB(239, 239, 239);
        
        //图片imageView
        CGFloat imageWidth = 15;
        CGFloat leftSpacing = 20;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageWidth, imageWidth)];
        imageView.frame = CGRectMake(leftSpacing, (self.statusBar.height - imageWidth) / 2, imageView.width, imageView.width);
        imageView.image = [UIImage imageNamed:@"感叹"];
        [self.statusBar addSubview:imageView];
        
        //文字lable
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 5, 0, 200, self.statusBar.height)];
        label.text = @"网络连接不可用";
        label.font = [UIFont systemFontOfSize:12.0f];
        [self.statusBar addSubview:label];
    }
    
    //网络切换时的动画
    //有网隐藏提示条
    if (hidden) {
        [UIView animateWithDuration:0.6 animations:^{
            self.statusBar.transform = CGAffineTransformIdentity;
            if (self.tableView) {
                self.tableView.top = self.statusBar.bottom;
            }
        } completion:^(BOOL finished) {
            [self.statusBar removeFromSuperview];
        }];
    }
    //无网出现提示条
    else {
        [self.view addSubview:self.statusBar];
        [UIView animateWithDuration:0.6 animations:^{
            self.statusBar.transform = CGAffineTransformMakeTranslation(0, 25);
            if (self.tableView) {
                self.tableView.top = self.statusBar.bottom;
            }
        }];
    }
}

/************************ 辅视图：长按设置栏 ************************/
#pragma mark - * 辅视图：长按设置栏
/**
 *  创建长按设置栏
 *
 *  @param hidden 是否隐藏
 *  @param device 需设置的设备
 */
- (void)setLongPressSettingViewHidden:(BOOL)hidden device:(DeviceModel *)device {
    
    [self setMaskviewHidden:hidden];
    if (self.longPressSettingView == nil) {
        //长按主视图
        self.longPressSettingView = [[LongPressSettingView alloc] initWithFrame:CGRectMake(40, self.view.center.y / 2, kScreenWidth - 80, 150) tapAction:^(UIButton *button, NSInteger row) {
            
            NSLog(@"%@ : %li", button, row);
            //隐藏长按视图
            [self.longPressSettingView removeFromSuperview];
            switch (row) {
                case 0:
                    //出现设置昵称视图
                    [self setSetDevNicknameViewHidden:NO device:device];
                    break;
                case 1:
                    NSLog(@"设备分享");
                    break;
                case 2:
                    NSLog(@"解除绑定");
                    break;
                    
                default:
                    break;
            }
        }];
        self.longPressSettingView.alpha = 0.0;
    }
    
    //移除视图
    if (hidden) {
        self.longPressSettingView.alpha = 0.0;
        [self.longPressSettingView removeFromSuperview];
    }
    //出现视图
    else {
        [self.view.window addSubview:self.longPressSettingView];
        [UIView animateWithDuration:0.4 animations:^{
            self.longPressSettingView.alpha = 1.0;
        }];
    }
}

/************************ 辅视图：修改昵称视图 ************************/
#pragma mark - * 辅视图：修改昵称视图
/**
 *  创建修改昵称视图
 *
 *  @param hidden 是否隐藏
 */
- (void)setSetDevNicknameViewHidden:(BOOL)hidden device:(DeviceModel *)device{
    //创建遮罩视图
    [self setMaskviewHidden:hidden];
    
    if (self.setDevNickNameView == nil) {
        self.setDevNickNameView = [[SetDevNicknameView alloc] initWithFrame:CGRectMake(10, self.view.center.y/2, kScreenWidth - 20, 150)];
        //取消按钮操作
        __block DeviceListController *weakSelf = self;
        self.setDevNickNameView.cancelBlock = ^() {
            //等于触发遮罩视图操作
            [weakSelf maskTapAction:nil];
        };
        //确定按钮操作
        self.setDevNickNameView.confirmBlock = ^(NSString *nickname) {
            //发送修改昵称请求
            NSString *devID = device.devID;
            [RequestMethod requestSetDeviceNicknameWithDevID:devID nickname:nickname success:^(NSDictionary *result) {
                NSLog(@"%@", result);
            } failure:^(NSError *error) {
                
            }];
        };
    }
    
    //相应键盘
    if (hidden) {
        [self.setDevNickNameView.textField resignFirstResponder];
        [self.setDevNickNameView removeFromSuperview];
    }
    else {
        [[self appWindow] addSubview:self.setDevNickNameView];
        [self.setDevNickNameView.textField becomeFirstResponder];
    }
}
/************************ 视图层次展示 ************************/
#pragma mark * 设置视图层次
//展示表示图
- (void)showTabelView {
    [self setTableViewHidden:NO];
    [self setDeviceEmptyViewHidden:YES];
    self.tableView.deviceArray = self.dataArray;
    [self.tableView reloadData];
}
//展示空列表视图
- (void)showDeviceEmptyView {
    [self setTableViewHidden:YES];
    [self setDeviceEmptyViewHidden:NO];
}

/************************ 主视图：表视图 ************************/
#pragma mark * 主视图：表视图
/**
 *  创建表视图
 *
 *  @param hidden 是否隐藏
 */
- (void)setTableViewHidden:(BOOL)hidden {
    if (self.tableView == nil) {
        self.tableView = [[DeviceTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        //长按弹出设置视图，返回设备数据
        __block DeviceListController *weakSelf = self;
        self.tableView.longPressAction = ^(DeviceModel *device) {
            [weakSelf setLongPressSettingViewHidden:NO device:device];
        };
        [self.view addSubview:self.tableView];
    }
    self.tableView.hidden = hidden;
}

/************************ 主视图：设备为空 ************************/
#pragma mark * 主视图：设备为空
/**
 *  创建设备为空视图
 *
 *  @param hidden 是否隐藏
 */
- (void)setDeviceEmptyViewHidden:(BOOL)hidden {
    if (self.deviceEmptyView == nil) {
        self.deviceEmptyView = [[[NSBundle mainBundle] loadNibNamed:@"DeviceEmptyView" owner:nil options:nil] lastObject];
        self.deviceEmptyView.frame = CGRectMake(0, 0, kScreenWidth, self.view.height);
        [self.view addSubview:self.deviceEmptyView];
        //点击文本，添加动作
        self.deviceEmptyView.detailLabel.tapAction = ^() {
            [self deviceAddAction:nil];
        };
    }
    self.deviceEmptyView.hidden = hidden;
}

/************************ 导航按钮：添加设备 ************************/
#pragma mark * 导航按钮：添加设备
/**
 *  创建导航栏右侧添加按钮
 */
- (void)createRightButtonItem {
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(deviceAddAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

/**
 *  创建添加设备视图
 *
 *  @param hidden 是否隐藏
 */
- (void)setDeviceAddingViewHidden:(BOOL)hidden {
    
    CGFloat height = self.view.height;
    if (self.addingView == nil) {
        self.addingView = [[DeviceAddingView alloc] initWithFrame:CGRectMake(0, -height, kScreenWidth, height)];
    }
    //出现视图
    if (!hidden) {
        [self.view addSubview:_addingView];
        [UIView animateWithDuration:0.3 animations:^{
            self.addingView.transform = CGAffineTransformTranslate(self.addingView.transform, 0, height);;
        }];
    }
    //移除视图
    else {
        [UIView animateWithDuration:0.3 animations:^{
            self.addingView.transform = CGAffineTransformTranslate(self.addingView.transform, 0, -height);;
        } completion:^(BOOL finished) {
            [self.addingView removeFromSuperview];
        }];
    }
}

/**
 *  添加设备动画，出现添加视图
 *
 *  @param button 添加按钮
 */
- (void)deviceAddAction:(UIButton *)button {
    
    //已登录，添加设备
    if ([UserManager shareInstance].isLoggedin) {
        NSLog(@"添加设备");
        //出现下拉菜单
        if (!button.selected) {
            [UIView animateWithDuration:0.3 animations:^{
                button.transform = CGAffineTransformMakeRotation(- M_PI_2);
            }];
            [self setDeviceAddingViewHidden:NO];
        }
        //隐藏下拉菜单
        else {
            [UIView animateWithDuration:0.3 animations:^{
                button.transform = CGAffineTransformIdentity;
            }];
            [self setDeviceAddingViewHidden:YES];
        }
    }
    //未登录，登陆账号
    else {
        NSLog(@"登陆账号");
        [self setLoginViewHidden:NO];
    }
    if (button) {
        button.selected = !button.selected;
    }
}

@end
