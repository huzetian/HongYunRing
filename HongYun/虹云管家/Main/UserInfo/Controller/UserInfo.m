//
//  UserInfo.m
//  HongYunBell
//
//  Created by imac on 15/11/11.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "UserInfo.h"
#import "UserInfoHeader.h"
#import "UserInfoCell.h"
#define kUserCellIdentity @"identifier"

@interface UserInfo () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UserInfoHeader *header;    //头试图

@property (nonatomic, strong)UITableView *table;        //表示图

@property (nonatomic, strong)NSArray *titleArray;       //单元格文字
@property (nonatomic, strong)NSArray *imageArray;       //单元格视图

@end

@implementation UserInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"个人中心"];
    
    [self createTable];
    
    //KVO监听昵称属性的变化
    [[UserManager shareInstance].user addObserver:self forKeyPath:@"nickName" options:NSKeyValueObservingOptionNew context:nil];
}
/**
 *  监听昵称属性的变化，变化时改变UI
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"nickName"]) {
        NSString *nickName = [[UserManager shareInstance].user valueForKey:@"nickName"];
        if (nickName == nil) {
            nickName = @"请登录";
        }
        [self.header.userName setTitle:nickName forState:UIControlStateNormal];
    }
}

- (void)dealloc {
    //移除通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UserManager shareInstance].user removeObserver:self forKeyPath:@"nickName" context:nil];
}

#pragma mark - createTable
- (void)createTable {
    //设置数组
    _titleArray = @[@"设备分享", @"消息中心", @"更多虹云产品", @"推荐给更多朋友", @"帮助与反馈", @"检查新版本", @"退出登录"];
    _imageArray = @[@"设备分享图标", @"3_03.png", @"更多产品图标", @"推荐", @"帮助与反馈图标@2x", @"检查更新", @"推荐"];
    
    //创建头视图
    self.header = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoHeader" owner:nil options:nil] lastObject];
    self.header.frame = CGRectMake(0, 0, self.view.width, kScreenHeight * goldenProportionSupplement - 64);
    [self.view addSubview:self.header];

    //表视图
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, self.header.bottom, self.view.width, 0) style:UITableViewStylePlain];
    self.table.height = self.view.height - self.header.height - 64 - 49;
    self.table.dataSource = self;
    self.table.delegate = self;
    //关闭滑动
    [self.view addSubview:_table];
    
    //隐藏多余分割线
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    [self.table setTableFooterView:view];
    
    //注册单元格
    [self.table registerNib:[UINib nibWithNibName:@"UserInfoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kUserCellIdentity];
    
}


/************************ UITableViewDataSource ************************/
#pragma mark - UITableViewDataSource
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}
//单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = kUserCellIdentity;
    UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    //cell内容填充
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellTextLabel.text = _titleArray[indexPath.row];
    cell.cellImageView.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    return  cell;
}

/************************ UITableViewDelegate ************************/
#pragma mark - UITableViewDelegate
//选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //更多产品
    if (indexPath.row == 2) {
        MoreProductController *moreProduct = [[MoreProductController alloc] init];
        [self.navigationController pushViewController:moreProduct animated:YES];
    }
    
    if (indexPath.row == 6) {
        NSLog(@"退出登录");
        [[UserManager shareInstance] logOut];
        [self setLoginViewHidden:NO];
    }
    
}

@end
	