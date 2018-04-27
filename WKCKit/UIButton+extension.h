//
//  UIButton+extension.h
//  WKCDevelop
//
//  Created by 魏昆超 on 2018/4/25.
//  Copyright © 2018年 WeiKunChao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, WKCImagePosition) {
    WKCImagePositionLeft = 0,              //图片在左，文字在右，默认
    WKCImagePositionRight = 1,             //图片在右，文字在左
    WKCImagePositionTop = 2,               //图片在上，文字在下
    WKCImagePositionBottom = 3,            //图片在下，文字在上
};

@interface UIButton (extension)

@property (nonatomic, assign) CGFloat LargeLength;
/**
 * 自定义图片位置
 * @param spacing 图片和文字的间隔
 */
- (void)setImagePosition:(WKCImagePosition)postion spacing:(CGFloat)spacing;
/**
 * 按钮倒计时
 * @param timeout 总时间
 * @param title 计时结束后显示标题
 * @param waitTittle 计时过程中显示标题
 */
-(void)setTimeout:(NSInteger )timeout title:(NSString *)title waitTittle:(NSString *)waitTittle;
@end
