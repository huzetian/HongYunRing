//
//  MyLabel.m
//  HongYunBell
//
//  Created by ZZ on 16/1/11.
//  Copyright © 2016年 zhangzheng. All rights reserved.
//

#import "MyLabel.h"
#import <CoreText/CoreText.h>

@interface MyLabel ()

@property(nonatomic,strong)NSMutableAttributedString *attrString;//文本属性字符串
@property (nonatomic, strong)UIColor *linkTextColor;
@property (nonatomic, assign)NSRange linkRange;

@end

@implementation MyLabel

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor actionTextRange:(NSRange)range actionTextColor:(UIColor *)actionTextColor tapAction:(void (^)())action {
    
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        
        self.text = text;
        self.textColor = textColor;
        self.linkTextColor = actionTextColor;
        self.linkRange = range;
        self.tapAction = action;
    }
    return self;
}

- (void)setText:(NSString *)text textColor:(UIColor *)textColor actionTextRange:(NSRange)range actionTextColor:(UIColor *)actionTextColor {
    self.userInteractionEnabled = YES;
    
    self.text = text;
    self.textColor = textColor;
    self.linkTextColor = actionTextColor;
    self.linkRange = range;
}


- (void)drawRect:(CGRect)rect {
    
    if (self.text == nil) {
        return;
    }
    
    //生成属性字符串对象
    self.attrString = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    //设置字体属性
    [_attrString addAttribute:(id)kCTFontAttributeName value:self.font range:NSMakeRange(0, _attrString.length)];
    //设置当前文本的颜色
    [_attrString addAttribute:(id)kCTForegroundColorAttributeName value:self.textColor range:NSMakeRange(0, _attrString.length)];
    
    [_attrString addAttribute:(id)kCTForegroundColorAttributeName value:(id)self.linkTextColor range:_linkRange];
    
    
    
    //生成CTFramesetterRef对象
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_attrString);
    
    
    //然后创建一个CGPath对象，这个Path对象用于表示可绘制区域坐标值、长宽。
    CGRect bouds = CGRectInset(self.bounds, 0.0f, 0.0f);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, bouds);
    
    //使用上面生成的setter和path生成一个CTFrameRef对象，这个对象包含了这两个对象的信息（字体信息、坐标信息）
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (context != NULL) {
        CGContextSetTextMatrix(context , CGAffineTransformIdentity);
        //压栈，压入图形状态栈中.每个图形上下文维护一个图形状态栈，并不是所有的当前绘画环境的图形状态的元素都被保存。图形状态中不考虑当前路径，所以不保存
        //保存现在得上下文图形状态。不管后续对context上绘制什么都不会影响真正得屏幕。
        CGContextSaveGState(context);
        //x，y轴方向移动
        CGContextTranslateCTM(context , 0 ,self.frame.size.height);
        //缩放x，y轴方向缩放，－1.0为反向1.0倍,坐标系转换,沿x轴翻转180度
        CGContextScaleCTM(context, 1.0 ,-1.0);
        //可以使用CTFrameDraw方法绘制了。
        CTFrameDraw(frame,context);
    }
    
    //释放对象
    CGPathRelease(path);
    CFRelease(framesetter);
    CFRelease(frame);
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGFloat range = point.x / self.font.pointSize;
    
    if (range >= self.linkRange.location && range <= self.linkRange.location + self.linkRange.length) {
        if (self.tapAction) {
            self.tapAction();
        }
    }
}


@end
