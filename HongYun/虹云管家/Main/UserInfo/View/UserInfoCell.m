//
//  UserInfoCell.m
//  HongYunBell
//
//  Created by imac on 15/11/13.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "UserInfoCell.h"

@interface UserInfoCell ()
@property (nonatomic, strong)UIImageView *tagImageView;

@end
@implementation UserInfoCell

- (void)awakeFromNib {
    [self setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    self.cellTextLabel.font = [UIFont fontWithName:fontName size:17.0];
//    self.cellImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self createTagView];
}
- (void)setIsNEW:(BOOL)isNEW {
    if (_isNEW != isNEW) {
        _isNEW = isNEW;
        _tagImageView.hidden = !isNEW;
    }
}
- (void)createTagView {
    CGFloat tagWidth = 35;
    CGFloat tagHeight = 30;
    _tagImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 10, (self.height - tagHeight)/ 2, tagWidth, tagHeight)];
    _tagImageView.contentMode = UIViewContentModeScaleAspectFit;
    _tagImageView.image = [UIImage imageNamed:@"NEW22X.png"];
    [self.contentView addSubview:_tagImageView];
    _tagImageView.hidden = YES;
    
    UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, tagWidth, tagHeight - 3)];
    tagLabel.text = @"NEW";
    tagLabel.textColor = [UIColor whiteColor];
    tagLabel.font = [UIFont boldSystemFontOfSize:11.0f];
    [_tagImageView addSubview:tagLabel];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
