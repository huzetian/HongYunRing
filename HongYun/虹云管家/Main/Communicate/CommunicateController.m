//
//  CommunicateController.m
//  HongYunBell
//
//  Created by ZZ on 15/12/15.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "CommunicateController.h"
#import "DataService.h"
#import <AVFoundation/AVFoundation.h>

@interface CommunicateController ()
#define lightCyanColor ColorMakeRGBA(132, 221, 214, 1.0f)   //淡青色

/**
 *  头像视图
 */
@property (strong, nonatomic)  UIView *naviBar;           //模拟的导航栏
@property (strong, nonatomic)  UIImageView *imageView;    //图片视图
@property (strong, nonatomic)  UIButton *preButton;       //上一张按钮
@property (strong, nonatomic)  UIButton *nextButton;      //下一张按钮

/**
 *  图片数组
 */
@property (nonatomic, strong)NSMutableArray *picsArray;         //图片http地址数组
@property (nonatomic, strong)NSMutableArray *imagesArray;       //图片数组


/**
 *  接受、拒绝界面
 */
@property (strong, nonatomic)UIView *acceptView;        //主视图
@property (strong, nonatomic)UIButton *acceptButton;    //接受按钮
@property (strong, nonatomic)UIButton *rejectButton;    //拒绝按钮


/**
 *  通话按钮界面
 */
@property (strong, nonatomic)UIView *communicateView;   //主视图
@property (strong, nonatomic)UIButton *shootButton;     //再拍一张
@property (strong, nonatomic)UIButton *speakButton;     //讲话按钮
@property (strong, nonatomic)UIButton *endButton;       //结束通话按钮
@property (strong, nonatomic)UILabel *shootLabel;       //再拍一张
@property (strong, nonatomic)UILabel *speakLabel;       //讲话
@property (strong, nonatomic)UILabel *endLabel;         //结束通话

/**
 *  音频
 */
@property (nonatomic, strong)AVAudioRecorder *recorder;         //录音
@property (strong, nonatomic)AVAudioPlayer *audioPlayer;        //播放

@property (nonatomic, assign)BOOL presented;                    //是否出现

@end

@implementation CommunicateController

/**
 *  创建单例页面
 */
+ (instancetype)shareInstance {
    
    static CommunicateController *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[super alloc] init];
        }
    });
    return instance;
}

/**
 *  创建视图
 */
- (void)createSubviews {
    //模拟导航栏
    self.naviBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
    self.naviBar.backgroundColor = lightCyanColor;
    [self.view addSubview:self.naviBar];
    
    //图片视图
    CGFloat height = kScreenHeight * goldenProportionSupplement;
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.naviBar.bottom, kScreenWidth, height)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    
    //按钮黑色背景条
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.imageView.height - 30, kScreenWidth, 30)];
    blackView.backgroundColor = ColorMakeRGBA(0, 0, 0, 0.4);
    [self.imageView addSubview:blackView];
    
    CGFloat buttonWidth = 60;
    //上一张按钮
    self.preButton = [[UIButton alloc] initWithFrame:CGRectMake(blackView.width / 2 - 100 - buttonWidth / 2, (blackView.height - 21) / 2, buttonWidth, 21)];
    [self.preButton setTitle:@"上一张" forState:UIControlStateNormal];
    [self.preButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.preButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [blackView addSubview:self.preButton];
    [self.preButton addTarget:self
                       action:@selector(prePhotoAction:)
             forControlEvents:UIControlEventTouchUpInside];
    //下一张按钮
    self.nextButton = [[UIButton alloc] initWithFrame:CGRectMake(blackView.width / 2 + 100 - buttonWidth / 2, (blackView.height - 21) / 2, buttonWidth, 21)];
    [self.nextButton setTitle:@"下一张" forState:UIControlStateNormal];
    [self.nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.nextButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [blackView addSubview:self.nextButton];
    [self.nextButton addTarget:self
                        action:@selector(nextPhotoAction:)
              forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  设置通话视图
 *
 *  @param hidden 是否隐藏
 */
- (void)setCommunicatingViewsHidden:(BOOL)hidden {
    
    if (self.communicateView == nil) {
        //通话父视图
        self.communicateView = [[UIView alloc] initWithFrame:CGRectMake(0, self.imageView.bottom + 100, kScreenWidth, 120)];
        
        
        //按住讲话按钮
        self.speakButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
        self.speakButton.center = CGPointMake(self.communicateView.width / 2, self.communicateView.height / 2);
        [self.speakButton setImage:[UIImage imageNamed:@"说话"] forState:UIControlStateNormal];
        [self.communicateView addSubview:self.speakButton];
        //讲话按钮添加长按手势
        UILongPressGestureRecognizer *speakingGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(speakAction:)];
        [self.speakButton setAdjustsImageWhenHighlighted:NO];
        [self.speakButton addGestureRecognizer:speakingGesture];
        //讲话Label
        self.speakLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 21)];
        self.speakLabel.center = CGPointMake(self.speakButton.center.x, self.speakButton.bottom + 10 + 11);
        self.speakLabel.text = @"按住讲话";
        self.speakLabel.textColor = [UIColor whiteColor];
        self.speakLabel.textAlignment = NSTextAlignmentCenter;
        [self.communicateView addSubview:self.speakLabel];

        
        //再拍一张按钮
        self.shootButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        self.shootButton.center = CGPointMake(self.speakButton.left - 30 - 25, self.speakButton.center.y);
        [self.shootButton setImage:[UIImage imageNamed:@"拍照"] forState:UIControlStateNormal];
        [self.communicateView addSubview:self.shootButton];
        [self.shootButton addTarget:self
                             action:@selector(shootPhotoAction:)
                   forControlEvents:UIControlEventTouchUpInside];
        //再拍一张Label
        self.shootLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 21)];
        self.shootLabel.center = CGPointMake(self.shootButton.center.x, self.speakLabel.center.y);
        self.shootLabel.text = @"再拍一张";
        self.shootLabel.textColor = [UIColor whiteColor];
        self.shootLabel.textAlignment = NSTextAlignmentCenter;
        [self.communicateView addSubview:self.shootLabel];
        
        
        //挂断按钮
        self.endButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        self.endButton.center = CGPointMake(self.speakButton.right + 30 + 25, self.speakButton.center.y);
        [self.endButton setImage:[UIImage imageNamed:@"挂断"] forState:UIControlStateNormal];
        [self.communicateView addSubview:self.endButton];
        [self.endButton addTarget:self
                           action:@selector(endCommunicationAction:)
                 forControlEvents:UIControlEventTouchUpInside];
        //挂断Label
        self.endLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 21)];
        self.endLabel.center = CGPointMake(self.endButton.center.x, self.speakLabel.center.y);
        self.endLabel.text = @"挂断";
        self.endLabel.textColor = [UIColor whiteColor];
        self.endLabel.textAlignment = NSTextAlignmentCenter;
        [self.communicateView addSubview:self.endLabel];
    }
    
    if (hidden) {
        [self.communicateView removeFromSuperview];
    }
    else {
        [self.view addSubview:self.communicateView];
    }

}

/**
 *  设置接听视图
 *
 *  @param hidden 是否隐藏
 */
- (void)setAcceptViewHidden:(BOOL)hidden {
    
    if (self.acceptView == nil) {
        self.acceptView = [[UIView alloc] initWithFrame:CGRectMake(0, self.imageView.bottom + 100, kScreenWidth, 120)];
        
        CGFloat buttonWidth = 60;
        CGFloat buttonHeight = 60;
        CGFloat spacing = 45;
        //接受呼叫按钮
        self.acceptButton = [[UIButton alloc] initWithFrame:CGRectMake(spacing, (self.acceptView.height - buttonHeight) / 2, buttonWidth, buttonHeight)];
        [self.acceptButton setImage:[UIImage imageNamed:@"接听"] forState:UIControlStateNormal];
        [self.acceptView addSubview:self.acceptButton];
        [self.acceptButton addTarget:self
                              action:@selector(acceptCallAction:)
                    forControlEvents:UIControlEventTouchUpInside];
        //拒绝接听按钮
        self.rejectButton = [[UIButton alloc] initWithFrame:CGRectMake(self.acceptView.width - spacing - buttonWidth, (self.acceptView.height - buttonHeight) / 2, buttonWidth, buttonHeight)];
        [self.rejectButton setImage:[UIImage imageNamed:@"拒绝"] forState:UIControlStateNormal];
        [self.acceptView addSubview:self.rejectButton];
        [self.rejectButton addTarget:self
                              action:@selector(rejectCallAction:)
                    forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (hidden) {
        [self.acceptView removeFromSuperview];
    }
    else {
        [self.view addSubview:self.acceptView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = lightCyanColor;
    
    [self createSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.presented = YES;
    //隐藏通话按钮
    [self setCommunicatingViewsHidden:YES];
    [self setAcceptViewHidden:NO];
    
    self.imageView.image = nil;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.presented = NO;
}

/**
 *  控制器是否出现（防被重复present）
 */
- (BOOL)isPresented {
    return self.presented;
}
/**
 *  录音操作
 *
 *  @param gesture 录音手势
 */
- (void)speakAction:(UIGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"开始讲话");
        [self buildRecorder];
    }
    else if (gesture.state == UIGestureRecognizerStateEnded) {
        NSLog(@"结束讲话");
        [self.recorder stop];
        self.recorder = nil;
        
        NSString *filePath = [self filePath];
        NSData *voiceData = [[NSData alloc] initWithContentsOfFile:filePath];
        NSString *userID = [UserManager shareInstance].user.userID;
        NSString *userPwd = [UserManager shareInstance].user.userPwd;
        
        //上传语音
        [DataService uploadVoice:voiceData user:userID pwd:userPwd success:^(NSURLSessionDataTask *task, NSString *responseURL) {

            NSLog(@"上传成功: %@", responseURL);
            [self sendVoiceWithURL:responseURL];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"上传失败, error : %@", error);
        }];
        
//        NSError *playerError;
//        //播放
//        AVAudioPlayer *player = nil;
//        player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:[self filePath]] error:&playerError];
//        
//        if (player == nil)
//        {
//            NSLog(@"ERror creating player: %@", [playerError description]);
//        }else{
//            NSLog(@"play");
//            [player prepareToPlay];
//            [player play];
//        }
        
    }
}
/**
 *  发送语音
 *
 *  @param urlString 语音的URL地址
 */
- (void)sendVoiceWithURL:(NSString *)urlString {
    NSString *devID = self.messageModel.from;
    NSString *protocol = nil;
    NSString *host = nil;
    NSString *path = urlString;
    
    //发送语音
    [RequestMethod requestSendVoiceToID:devID protocol:protocol host:host path:path success:^(NSDictionary *result) {
        NSLog(@"发送成功%@", result);
    } failure:^(NSError *error) {
        NSLog(@"发送失败, error : %@", error);
    }];
}

- (void)buildRecorder{
    
    if ([self willRecord]) {
        
        //创建Recorder
        if (self.recorder == nil) {
            
            //保存路径名
            NSString *playName = [self filePath];
            //录音设置
            NSDictionary *recorderSettingsDict =[[NSDictionary alloc] initWithObjectsAndKeys:
                                                 [NSNumber numberWithInt:kAudioFormatMPEG4AAC],AVFormatIDKey,
                                                 [NSNumber numberWithInt:1000.0],AVSampleRateKey,
                                                 [NSNumber numberWithInt:2],AVNumberOfChannelsKey,
                                                 [NSNumber numberWithInt:8],AVLinearPCMBitDepthKey,
                                                 [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
                                                 [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
                                                 nil];
            
            NSError *error = nil;
            self.recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:playName] settings:recorderSettingsDict error:&error];
            
        }
        //开始录音
        if (self.recorder) {
            self.recorder.meteringEnabled = YES;
            [self.recorder prepareToRecord];
            [self.recorder record];
        }
    }
    else {
        
    }
}

/**
 *  语音存放地址
 *
 *  @return 地址
 */
- (NSString *)filePath {
    //保存路径名
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *playName = [NSString stringWithFormat:@"%@/play.aac",docDir];
    NSLog(@"%@", playName);
    return playName;
}

/************************ 通过数据填充模型、视图（线性流程） ************************/
/**
 *  设置数据时，填充Model和图片数组
 *
 *  @param dataDic 呼叫时云端发送的请求字典
 */
- (void)setData:(NSDictionary *)dataDic {
    if (_dataDic != dataDic) {
        _dataDic = dataDic;
        NSDictionary *msgContent = [dataDic objectForKey:@"msg_content"];
        //设置Model
        self.messageModel = [[MessageModel alloc] initWithDataDic:msgContent];
        
        NSLog(@"%@ - %@", [self class], dataDic);
        //呼叫请求
        if ([self.messageModel.msg.method isEqualToString:@"RING_CALL_REQUEST"]) {
            //设置图片数组
            [self setPicsArrayWithModel:self.messageModel];
            
        }
        //发送语音请求
        else if ([self.messageModel.msg.method isEqualToString:@"RING_SEND_VOICE"]) {
            //下载并播放声音
            [self getVoiceWithModel:self.messageModel];
        }
    }
}
/**
 *  处理声音数据模型，下载语音
 *
 *  @param model 设备呼叫的请求模型（包含图片地址数组）
 */
- (void)getVoiceWithModel:(MessageModel *)model {
    
    NSDictionary *voiceDic = [model.msg.params objectForKey:@"voice"];
    if (voiceDic == nil) {
        return;
    }
    NSString *path = [voiceDic objectForKey:@"path"];
    NSString *userName = [UserManager shareInstance].user.userID;
    NSString *pwd = [UserManager shareInstance].user.userPwd;
    
    [DataService downloadVoice:path user:userName pwd:pwd success:^(NSURLSessionDataTask *task, NSData *responseData) {
        
        NSLog(@"success : ");
        NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@.wav", docDirPath, path];
        NSLog(@"%@", filePath);
        [responseData writeToFile:filePath atomically:YES];
        
        NSError *error = nil;
        NSURL *url = [NSURL fileURLWithPath:filePath];
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        [self.audioPlayer play];
        NSLog(@"playing %i: %@", self.audioPlayer.isPlaying, error);

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error : %@", error);
    }];
}

/************************ 数据处理 ************************/
#pragma mark - 数据处理、模型化
/**
 *  处理图片数据模型
 *
 *  @param model 设备呼叫的请求模型（包含图片地址数组）
 */
- (void)setPicsArrayWithModel:(MessageModel *)model {
    
    MySocketRequest *request = model.msg;
    NSDictionary *params = request.params;
    NSArray *images = [params objectForKey:@"images"];
    self.picsArray = [NSMutableArray arrayWithArray:images];
    
}
/**
 *  设置图片数组（数量为1）并下载图片
 *
 *  @param picsArray 图片地址数组
 */
- (void)setPicsArray:(NSMutableArray *)picsArray {
    if (_picsArray != picsArray) {
        _picsArray = picsArray;
        
        NSString *imageName = [_picsArray[0] objectForKey:@"path"];
        NSString *userName = [UserManager shareInstance].user.userID;
        NSString *pwd = [UserManager shareInstance].user.userPwd;
        
        //根据推送URL下载图片
        [DataService downloadImage:imageName user:userName pwd:pwd success:^(NSURLSessionDataTask *task, NSData *responseData) {
            
            NSLog(@"success");
            UIImage *image = [[UIImage alloc] initWithData:responseData];
            self.imageView.image = image;
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error : %@", error);
        }];
    }
    
}

/************************ 按钮操作 ************************/
#pragma mark - 按钮操作
/**
 *  上一张图片
 */
- (void)prePhotoAction:(UIButton *)sender {
    NSLog(@"上一张图片");
}
/**
 *  下一张图片
 */
- (void)nextPhotoAction:(UIButton *)sender {
    NSLog(@"下一张图片");
}


/**
 *  接受呼叫
 */
- (void)acceptCallAction:(UIButton *)sender {
    NSLog(@"接受呼叫");
    NSString *devID = self.messageModel.from;
    NSInteger callRequestID = self.messageModel.msg.requestID;
    
    [RequestMethod requestCallAcceptWithDevID:devID callRequestID:callRequestID success:^(NSDictionary *result) {
        
        NSLog(@"%@", result);
        [self setAcceptViewHidden:YES];
        [self setCommunicatingViewsHidden:NO];

    } failure:^(NSError *error) {
        
    }];
}
/**
 *  拒绝呼叫
 */
- (void)rejectCallAction:(id)sender {
    NSLog(@"拒绝呼叫");
    NSString *devID = self.messageModel.from;
    NSInteger callRequestID = self.messageModel.msg.requestID;

    [RequestMethod requestCallRejectWithDevID:devID callRequestID:callRequestID reason:@"hehe" success:^(NSDictionary *result) {
       
        NSLog(@"%@", result);
        
    } failure:^(NSError *error) {
        
    }];
    //弹出视图
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  再拍一张
 */
- (void)shootPhotoAction:(UIButton *)sender {
    
    NSString *devID = self.messageModel.from;

    [RequestMethod requestSnapshotWithDevID:devID success:^(NSDictionary *result) {
        
        NSLog(@"再拍一张");
        
    } failure:^(NSError *error) {
        
    }];
    
}

/**
 *  挂断通话
 */
- (void)endCommunicationAction:(UIButton *)sender {
    
    NSString *devID = self.messageModel.from;
    NSInteger callRequestID = self.messageModel.msg.requestID;
    
    [RequestMethod requestCallHangUpWithDevID:devID callRequestID:callRequestID success:^(NSDictionary *result) {
        
        NSLog(@"挂断通话");
        NSLog(@"%@", result);
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSError *error) {
        
    }];
    
}

/************************ 判断是否允许使用麦克风 ************************/
#pragma mark - 7.0新增的方法requestRecordPermission
-(BOOL)willRecord
{
    __block BOOL willRecord = YES;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    willRecord = YES;
                }
                else {
                    willRecord = NO;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[[UIAlertView alloc] initWithTitle:nil
                                                    message:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风"
                                                   delegate:nil
                                          cancelButtonTitle:@"关闭"
                                          otherButtonTitles:nil] show];
                    });
                }
            }];
        }
    }
    
    return willRecord;
}

@end
