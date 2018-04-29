//
//  UIImage+extension.h
//  WKCDevelop
//
//  Created by 魏昆超 on 2018/4/25.
//  Copyright © 2018年 WeiKunChao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (extension)
/**图片的宽高*/
@property (nonatomic, assign, readonly) CGFloat wkc_width;
@property (nonatomic, assign, readonly) CGFloat wkc_height;

/**
 * 通过颜色画一张图
 * color - 颜色
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 * 通过颜色和size画一张图
 * color - 颜色,size - 大小
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 * 通过加载本地文件获取GIF图
 * resource - 文件名,不含后缀
 */
+ (UIImage *)imageWithGif:(NSString *)resource;
/**
 * 拉伸图片
 * image - 源图
 *
 */
+ (UIImage *)resizableImageWithSourceImage:(UIImage *)image;
/**
 * 圆角图片
 * corners - 哪几个角, radius - 角度, size - 大小, borderWidth - 边框,borderColor - 边框颜色
 */
- (UIImage *)roundImageWithRoundingCorners:(UIRectCorner)corners
                              cornerRadius:(CGFloat)radius
                            aspectFillSize:(CGSize)size
                               borderWidth:(CGFloat)borderWidth
                               borderColor:(UIColor *)borderColor;

/**无边框渐变色*/
+ (instancetype)imageWithGradientColors:(NSArray<NSNumber *> *)rgbaHexAr
                             startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
                                corners:(UIRectCorner)corners
                           cornerRadius:(CGFloat)radius
                                   size:(CGSize)size;
/**有边框渐变色*/
+ (instancetype)imageWithGradientColors:(NSArray<NSNumber *> *)rgbaHexAr
                             startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
                                corners:(UIRectCorner)corners
                           cornerRadius:(CGFloat)radius
                            borderWidth:(CGFloat)borderWidth
                            borderColor:(UIColor *)borderColor
                                   size:(CGSize)size;
/**画一张阴影图*/
- (UIImage *)imageWithShadowColor:(UIColor *)color offset:(CGSize)offset blur:(CGFloat)blur;
@end
