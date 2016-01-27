//
//  SearchViewController.h
//  门铃
//
//  Created by Tian on 12/11/15.
//  Copyright © 2015年 Tian. All rights reserved.
//

#import "BaseViewController.h"

/**
 *  搜索设备界面
 */
@interface SearchViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *roundView;        //
@property (weak, nonatomic) IBOutlet UIView *whiteView;             //

@property (weak, nonatomic) IBOutlet UIImageView *circleWave1;      //圆形波纹1
@property (weak, nonatomic) IBOutlet UIImageView *circleWave2;      //圆形波纹2
@property (weak, nonatomic) IBOutlet UIImageView *circleWave3;      //圆形波纹3

@property (weak, nonatomic) IBOutlet UIImageView *deviceA;          //发现设备A
@property (weak, nonatomic) IBOutlet UIImageView *deviceB;          //发现设备B
@property (weak, nonatomic) IBOutlet UIImageView *deviceC;          //发现设备C

@end
