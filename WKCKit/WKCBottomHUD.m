//
//  WKCBottomHUD.m
//  WKCDevelop
//
//  Created by 魏昆超 on 2018/4/28.
//  Copyright © 2018年 WeiKunChao. All rights reserved.
//

#import "WKCBottomHUD.h"
#define View_Height 44
@interface WKCBottomHUD()
@property (nonatomic, strong) UILabel * messageLabel;

@end
static WKCBottomHUD *_instance = nil;
@implementation WKCBottomHUD

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_instance) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

+ (instancetype)sharedInstance {
    return [[self alloc] init];
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:15];
        _messageLabel.textColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1];
    }
    return _messageLabel;
}

- (void)showWithText:(NSString *)text duration:(NSTimeInterval)duration {
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    CGFloat screen_height = [UIScreen mainScreen].bounds.size.height;
    CGFloat iphoneBottomSpace = 0;
    if (screen_height == 812) {
        iphoneBottomSpace = 85;
    }else {
       iphoneBottomSpace = 49;
    }
   CGSize labelSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    self.frame = CGRectMake((CGFloat)(screen_width - labelSize.width - View_Height)/2, screen_height - iphoneBottomSpace - View_Height - 50 , labelSize.width + View_Height, View_Height);
    self.alpha = 1;
    if (!self.messageLabel.superview) {
        self.messageLabel.frame = CGRectMake((CGFloat)(self.bounds.size.width - labelSize.width)/2, (CGFloat)(View_Height - 20) / 2, labelSize.width, 20);
        [self addSubview:self.messageLabel];
    }
    
    self.messageLabel.text = text;
    
    if (!self.superview) {
        self.layer.cornerRadius = View_Height/2;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithRed:51/255 green:51/255 blue:51/255 alpha:1];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    if (duration < 1) {
        [self removeWithDuration:duration];
    }else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((duration - 1) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeWithDuration:1];
        });
    }
}

- (void)removeWithDuration:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished && self.superview && self.messageLabel.superview) {
            [self.messageLabel removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}
@end
