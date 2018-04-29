//
//  UIImage+extension.m
//  WKCDevelop
//
//  Created by 魏昆超 on 2018/4/25.
//  Copyright © 2018年 WeiKunChao. All rights reserved.
//

#import "UIImage+extension.h"

@implementation UIImage (extension)

- (CGFloat)wkc_width {
    return CGImageGetWidth(self.CGImage);
}

- (CGFloat)wkc_height {
    return CGImageGetHeight(self.CGImage);
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1,1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ (UIImage *)imageWithGif:(NSString *)resource {
    NSString *path =[[NSBundle mainBundle] pathForResource:resource ofType:@"gif"];
    NSData *data =[NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage animatedGIFWithData:data];
    return image;
}

+ (UIImage *)animatedGIFWithData:(NSData *)data {
    if (!data) {
        return nil;
    }
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(source);
    UIImage *staticImage;
    if (count <= 1) {
        staticImage = [[UIImage alloc] initWithData:data];
    } else {
        NSMutableArray *images =[NSMutableArray array];
        NSTimeInterval duration = 0.0f;
        for (size_t i =0; i <count; i ++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            if (!image) {
                continue;
            }
            duration +=[UIImage frameDurationAtIndex:i Source:source];
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            CGImageRelease(image);
        }
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        staticImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    CFRelease(source);
    return staticImage;
}

+ (CGFloat)frameDurationAtIndex:(NSInteger)index Source:(CGImageSourceRef)source {
    CGFloat frameDuration = 0.1f;
    CFDictionaryRef frame = CGImageSourceCopyPropertiesAtIndex(source, index, NULL);
    NSDictionary *frameProperties =(__bridge NSDictionary *)(frame);
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }else {
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    CFRelease(frame);
    return frameDuration;
}

+ (void)animationWithBasicPath:(NSString *)path ImagesCount:(NSInteger)imagesCount PresentImageView:(UIImageView * )imageView {
    NSMutableArray *imagesArray = [NSMutableArray array];
    for (NSInteger i =0; i <imagesCount; i ++) {
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_%02ld.jpg",path,(long)i] ofType:nil];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        [imagesArray addObject:image];
    }
    imageView.animationImages = imagesArray;
    imageView.animationDuration = imagesArray.count *0.074;
    imageView.animationRepeatCount = 1;
    [imageView startAnimating];
    [imageView performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:imageView.animationDuration];
}

+ (UIImage *)resizableImageWithSourceImage:(UIImage *)image {
    UIImage *newImage=[image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height*0.5, image.size.width*0.5, image.size.height*0.5-1, image.size.width*0.5-1) resizingMode:UIImageResizingModeTile];
    return newImage;
}

- (UIImage *)roundImageWithRoundingCorners:(UIRectCorner)corners
                                     cornerRadius:(CGFloat)radius
                                   aspectFillSize:(CGSize)size
                                      borderWidth:(CGFloat)borderWidth
                                      borderColor:(UIColor *)borderColor
{
    CGRect drawrect;
    
    CGSize usize = size;
    if (CGSizeEqualToSize(usize, CGSizeZero)) {
        usize = self.size;
    }
    CGFloat imageaspect = self.size.height/self.size.width;
    CGFloat sizeaspect = usize.height/usize.width;
    CGSize drawsize = CGSizeZero;
    if (sizeaspect > imageaspect) {
        drawsize.height = usize.height;
        drawsize.width = drawsize.height/imageaspect;
    } else {
        drawsize.width = usize.width;
        drawsize.height = drawsize.width * imageaspect;
    }
    
    CGPoint draworigin = CGPointMake((usize.width - drawsize.width)/2.f, (usize.height - drawsize.height)/2.f);
    drawrect = CGRectMake(draworigin.x, draworigin.y, drawsize.width, drawsize.height);
    
    UIGraphicsBeginImageContextWithOptions(usize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect urect = CGRectMake(0, 0, usize.width, usize.height);
    if (borderWidth > 0) {
        urect = CGRectInset(urect, borderWidth/2.f, borderWidth/2.f);
    }
    UIBezierPath *cornerspath = [UIBezierPath bezierPathWithRoundedRect:urect
                                                      byRoundingCorners:corners
                                                            cornerRadii:CGSizeMake(radius, radius)];
    CGPathRef path = [cornerspath CGPath];
    CGContextAddPath(context, path);
    CGContextClip(context);
    [self drawInRect:drawrect];
    
    if (borderWidth > 0 && borderColor) {
        CGContextResetClip(context);
        CGContextAddPath(context, path);
        CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
        CGContextSetLineWidth(context, borderWidth);
        CGContextStrokePath(context);
    }
    
    UIImage* const image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)roundImageWithRoundingCorners:(UIRectCorner)corners
                                     cornerRadius:(CGFloat)radius
                                        fillColor:(UIColor *)color
{
    CGFloat pxpt = 1.f/[UIScreen mainScreen].scale;
    CGFloat pwidth = MAX(pxpt, radius * 2);
    const CGRect boundingRect = CGRectMake(0, 0, pwidth, pwidth);
    
    UIGraphicsBeginImageContextWithOptions(boundingRect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *cornerspath = [UIBezierPath bezierPathWithRoundedRect:boundingRect
                                                      byRoundingCorners:corners
                                                            cornerRadii:CGSizeMake(radius, radius)];
    
    CGPathRef path = [cornerspath CGPath];
    CGContextAddPath(context, path);
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextDrawPath(context, kCGPathFill);
    
    UIImage* const image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(radius, radius, radius, radius) resizingMode:UIImageResizingModeStretch];
}

+ (instancetype)roundMaskImageWithRoundingCorners:(UIRectCorner)corners
                                         cornerRadius:(CGFloat)radius
                                          cornerColor:(UIColor *)color
                                          borderWidth:(CGFloat)borderWidth
                                          borderColor:(UIColor *)borderColor
{
    CGFloat pxpt = 1.f/[UIScreen mainScreen].scale;
    CGFloat pwidth = MAX(pxpt, radius * 2 + borderWidth * 2);
    const CGRect boundingRect = CGRectMake(0, 0, pwidth, pwidth);
    const CGRect innerRect = UIEdgeInsetsInsetRect(boundingRect, UIEdgeInsetsMake(borderWidth / 2, borderWidth / 2, borderWidth / 2, borderWidth / 2));
    
    UIGraphicsBeginImageContextWithOptions(boundingRect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *cornerspath = [UIBezierPath bezierPathWithRoundedRect:innerRect
                                                      byRoundingCorners:corners
                                                            cornerRadii:CGSizeMake(radius, radius)];
    
    CGContextAddRect(context, boundingRect);
    CGPathRef path = [cornerspath CGPath];
    CGContextAddPath(context, path);
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextDrawPath(context, kCGPathEOFill);
    
    if (borderWidth > 0 && borderColor) {
        CGContextAddPath(context, path);
        CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
        CGContextSetLineWidth(context, borderWidth);
        CGContextStrokePath(context);
    }
    
    UIImage* const image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(radius, radius, radius, radius) resizingMode:UIImageResizingModeStretch];
}

+ (instancetype)imageWithGradientColors:(NSArray<NSNumber *> *)rgbaHexAr
                                 startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
                                    corners:(UIRectCorner)corners
                               cornerRadius:(CGFloat)radius
                                       size:(CGSize)size
{
    return [self imageWithGradientColors:rgbaHexAr
                                  startPoint:startPoint endPoint:endPoint
                                     corners:corners cornerRadius:radius
                                 borderWidth:0 borderColor:nil
                                        size:size];
}

+ (instancetype)imageWithGradientColors:(NSArray<NSNumber *> *)rgbaHexAr
                                 startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
                                    corners:(UIRectCorner)corners
                               cornerRadius:(CGFloat)radius
                                borderWidth:(CGFloat)borderWidth
                                borderColor:(UIColor *)borderColor
                                       size:(CGSize)size
{
    CGRect boundingRect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(boundingRect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (borderWidth > 0) {
        CGFloat bof = borderWidth/2.f;
        boundingRect = CGRectInset(boundingRect, bof, bof);
    }
    
    UIBezierPath *cornerspath = [UIBezierPath bezierPathWithRoundedRect:boundingRect
                                                      byRoundingCorners:corners
                                                            cornerRadii:CGSizeMake(radius, radius)];
    CGPathRef path = [cornerspath CGPath];
    CGContextAddPath(context, path);
    CGContextClip(context);
    
    if (rgbaHexAr.count == 1) {
        rgbaHexAr = [rgbaHexAr arrayByAddingObject:rgbaHexAr[0]];
    }
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[rgbaHexAr.count * 4];
    for (NSInteger idx = 0; idx < rgbaHexAr.count; idx++) {
        NSNumber *rgbaNumber = rgbaHexAr[idx];
        NSUInteger rgba = [rgbaNumber unsignedIntegerValue];
        for (int i = 0; i < 4; i++) {
            CGFloat value = (rgba >> (24 - 8*i)) & 0xFF;
            colors[idx * 4 + i] = value / 255.f;
        }
    }
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    CGColorSpaceRelease(rgb);
    
    CGPoint sp = CGPointMake(boundingRect.size.width * startPoint.x, boundingRect.size.height * startPoint.y);
    CGPoint ep = CGPointMake(boundingRect.size.width * endPoint.x, boundingRect.size.height * endPoint.y);
    
    CGContextDrawLinearGradient(context, gradient, sp, ep, kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
    
    if (borderWidth > 0 && borderColor) {
        CGContextResetClip(context);
        CGContextAddPath(context, path);
        CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
        CGContextSetLineWidth(context, borderWidth);
        CGContextStrokePath(context);
    }
    
    UIImage* const image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(radius, radius, radius, radius) resizingMode:UIImageResizingModeStretch];
}

- (UIImage *)imageWithShadowColor:(UIColor *)color offset:(CGSize)offset blur:(CGFloat)blur
{
    //get size
    //CGSize border = CGSizeMake(fabsf(offset.width) + blur, fabsf(offset.height) + blur);
    CGSize border = CGSizeMake(fabs(offset.width) + blur, fabs(offset.height) + blur);
    
    CGSize size = CGSizeMake(self.size.width + border.width * 2.0f, self.size.height + border.height * 2.0f);
    
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //set up shadow
    CGContextSetShadowWithColor(context, offset, blur, color.CGColor);
    
    //draw with shadow
    [self drawAtPoint:CGPointMake(border.width, border.height)];
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return image
    return image;
}
@end
