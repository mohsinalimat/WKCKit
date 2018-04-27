//
//  UIView+extension.m
//  WKCDevelop
//
//  Created by 魏昆超 on 2018/4/25.
//  Copyright © 2018年 WeiKunChao. All rights reserved.
//

#import "UIView+extension.h"
#import <objc/runtime.h>
static const void *SWPKeyboardDismissTimeKey = "SWPKeyboardDismissTimeKey";

@implementation UIView (extension)

- (void)setKeyboredDismissBlock:(void (^)(CGFloat))keyboredDismissBlock {
    objc_setAssociatedObject(self, SWPKeyboardDismissTimeKey, keyboredDismissBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(CGFloat))keyboredDismissBlock {
    return objc_getAssociatedObject(self, SWPKeyboardDismissTimeKey);
}

- (void)addKeyBoardObsverWithCompeletionHnadle:(void (^)(CGFloat keyboredDismissTime))handle {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.keyboredDismissBlock = handle;
}

- (void)keyboardFrameChanged:(NSNotification *)sender {
    NSValue *value = [sender.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keboardRect = [value CGRectValue];
    CGFloat height = keboardRect.size.height;
    NSNumber *durationValue = [sender.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    CGFloat duration = [durationValue floatValue];
    if (keboardRect.origin.y < [UIScreen mainScreen].bounds.size.height) {
        [UIView animateWithDuration:duration animations:^{
            self.transform = CGAffineTransformMakeTranslation(0, -height);
        }];
    }else {
        [UIView animateWithDuration:duration animations:^{
            self.transform = CGAffineTransformIdentity;
        }];
        if (self.keyboredDismissBlock) {
            self.keyboredDismissBlock(duration);
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setWkc_frame:(NSArray <NSNumber *>*)frame {
    if (frame && frame.count == 4) {
        CGRect newFrame = self.frame;
        newFrame  = CGRectMake([frame[0] floatValue], [frame[1] floatValue], [frame[2] floatValue], [frame[3] floatValue]);
        self.frame = newFrame;
    }
}

- (void)setWkc_bounds:(NSArray <NSNumber *>*)bounds {
    if (bounds && bounds.count == 4) {
        CGRect newbounds = self.bounds;
        newbounds  = CGRectMake([bounds[0] floatValue], [bounds[1] floatValue], [bounds[2] floatValue], [bounds[3] floatValue]);
        self.bounds = newbounds;
    }
}

- (void)setWkc_origin:(CGPoint)wkc_origin {
    CGRect frame = self.frame;
    frame.origin = wkc_origin;
    self.frame = frame;
}

- (CGPoint)wkc_origin {
    return self.frame.origin;
}

- (void)setWkc_size:(CGSize)wkc_size {
    CGRect frame = self.frame;
    frame.size = wkc_size;
    self.frame = frame;
}

- (CGSize)wkc_size {
    return self.frame.size;
}

- (void)setWkc_centerX:(CGFloat)wkc_centerX {
     self.center = CGPointMake(wkc_centerX, self.center.y);
}

- (CGFloat)wkc_centerX {
    return self.center.x;
}

- (void)setWkc_centerY:(CGFloat)wkc_centerY {
    self.center = CGPointMake(self.center.x, wkc_centerY);
}

- (CGFloat)wkc_centerY {
    return self.center.y;
}

- (void)setWkc_originX:(CGFloat)wkc_originX {
    CGRect frame = self.frame;
    frame.origin.x = wkc_originX;
    self.frame = frame;
}

- (CGFloat)wkc_originX {
    return self.frame.origin.x;
}

- (void)setWkc_originY:(CGFloat)wkc_originY {
    CGRect frame = self.frame;
    frame.origin.y = wkc_originY;
    self.frame = frame;
}

- (CGFloat)wkc_originY {
    return self.frame.origin.y;
}

- (CGFloat)wkc_maxX {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)wkc_maxY {
    return CGRectGetMaxY(self.frame);
}

- (void)setWkc_width:(CGFloat)wkc_width {
    CGRect frame = self.frame;
    frame.size.width = wkc_width;
    self.frame = frame;
}

- (CGFloat)wkc_width {
    return self.frame.size.width;
}

- (void)setWkc_height:(CGFloat)wkc_height {
    CGRect frame = self.frame;
    frame.size.height = wkc_height;
    self.frame = frame;
}

- (CGFloat)wkc_height {
    return self.frame.size.height;
}

+ (NSString *)cellReuseIdentifier {
    return NSStringFromClass([self class]);
}

- (UIViewController *)viewController {
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

- (void)shadowWithCornerRadius:(CGFloat)radius shadowColor:(UIColor *)color shadowOffSet:(CGSize)offset shadowOpacity:(CGFloat)opacity shadowBlur:(CGFloat)blur {
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = radius;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = blur;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)gradientWithColors:(NSArray <UIColor *>*)colors startPoint:(CGPoint)start endPoint:(CGPoint)end changeLocation:(CGFloat)location {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    NSMutableArray *array = [NSMutableArray array];
    if (colors && colors.count != 0) {
        for (UIColor *color in colors) {
            [array addObject:(id)color.CGColor];
        }
        gradient.colors = array;
    }
    gradient.startPoint = start;
    gradient.endPoint = end;
    gradient.locations = @[[NSNumber numberWithFloat:location]];
    [self.layer addSublayer:gradient];
}

- (void)addPanAnimation {
    self.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(clickedOnPan:)];
    [self addGestureRecognizer:pan];
}

- (void)clickedOnPan:(UIPanGestureRecognizer *)sender {
    CGPoint point = [sender translationInView:sender.view.superview];
    CGPoint newCenter = CGPointMake(sender.view.center.x+ point.x,
                                    sender.view.center.y + point.y);
    newCenter.y = MAX(sender.view.frame.size.height/2, newCenter.y);
    newCenter.y = MIN(sender.view.superview.frame.size.height - sender.view.frame.size.height/2,  newCenter.y);
    newCenter.x = MAX(sender.view.frame.size.width/2, newCenter.x);
    newCenter.x = MIN(sender.view.superview.frame.size.width - sender.view.frame.size.width/2,newCenter.x);
    sender.view.center = newCenter;
    [sender setTranslation:CGPointZero inView:sender.view.superview];
}

- (UIImage *)screenshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    if( [self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    }
    else
    {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

- (UIImage *)screenshot:(CGFloat)maxWidth {
    CGAffineTransform oldTransform = self.transform;
    CGAffineTransform scaleTransform = CGAffineTransformIdentity;
    if (!isnan(maxWidth) && maxWidth>0) {
        CGFloat maxScale = maxWidth/CGRectGetWidth(self.frame);
        CGAffineTransform transformScale = CGAffineTransformMakeScale(maxScale, maxScale);
        scaleTransform = CGAffineTransformConcat(oldTransform, transformScale);
        
    }
    if(!CGAffineTransformEqualToTransform(scaleTransform, CGAffineTransformIdentity)){
        self.transform = scaleTransform;
    }
    
    CGRect actureFrame = self.frame; //已经变换过后的frame
    CGRect actureBounds= self.bounds;//CGRectApplyAffineTransform();
    
    //begin
    UIGraphicsBeginImageContextWithOptions(actureFrame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //    CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1, -1);
    CGContextTranslateCTM(context,actureFrame.size.width/2, actureFrame.size.height/2);
    CGContextConcatCTM(context, self.transform);
    CGPoint anchorPoint = self.layer.anchorPoint;
    CGContextTranslateCTM(context,
                          -actureBounds.size.width * anchorPoint.x,
                          -actureBounds.size.height * anchorPoint.y);
    if([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    }
    else
    {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //end
    self.transform = oldTransform;
    
    return screenshot;
}

- (id)subViewWithClass:(Class)clazz {
    for (id subView in self.subviews) {
        if ([subView isKindOfClass:clazz]) {
            return subView;
        }
    }
    return nil;
}

- (id)superViewWithClass:(Class)clazz {
    if (self == nil) {
        return nil;
    } else if (self.superview == nil) {
        return nil;
    } else if ([self.superview isKindOfClass:clazz]) {
        return self.superview;
    } else {
        return [self.superview superViewWithClass:clazz];
    }
}

- (UIView *)getFirstResponder {
    if (([self isKindOfClass:[UITextField class]] || [self isKindOfClass:[UITextView class]])
        && (self.isFirstResponder)) {
        return self;
    }
    
    for (UIView *v in self.subviews) {
        UIView *fv = [v getFirstResponder];
        if (fv) {
            return fv;
        }
    }
    
    return nil;
}

- (void)wkc_removeFromSuperViewWithDuraton:(NSTimeInterval)duration completionHandle:(void(^)(void))handle {
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
            handle();
        }
    }];
}
@end
