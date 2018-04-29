//
//  UIView+extension.h
//  WKCDevelop
//
//  Created by 魏昆超 on 2018/4/25.
//  Copyright © 2018年 WeiKunChao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (extension)

/**原点*/
@property (nonatomic, assign) CGPoint wkc_origin;
/**size*/
@property (nonatomic, assign) CGSize wkc_size;
/**中心x*/
@property (nonatomic, assign) CGFloat wkc_centerX;
/**中心y*/
@property (nonatomic, assign) CGFloat wkc_centerY;
/**原点x*/
@property (nonatomic, assign) CGFloat wkc_originX;
/**原点Y*/
@property (nonatomic, assign) CGFloat wkc_originY;
/**最大X*/
@property (nonatomic, assign, readonly) CGFloat wkc_maxX;
/**最大Y*/
@property (nonatomic, assign, readonly) CGFloat wkc_maxY;
/**宽*/
@property (nonatomic, assign) CGFloat wkc_width;
/**高*/
@property (nonatomic, assign) CGFloat wkc_height;
/**视图是否显示在屏幕*/
@property (nonatomic, assign, readonly) BOOL isDispalyedInScreen;
/**设置frame*/
- (void)setWkc_frame:(NSArray <NSNumber *>*)frame;
/**设置bounds*/
- (void)setWkc_bounds:(NSArray <NSNumber *>*)bounds;
/**键盘时间*/
@property (nonatomic, copy) void(^keyboredDismissBlock)(CGFloat keyBoardDismissTime);
/**添加键盘观察*/
- (void)addKeyBoardObsverWithCompeletionHnadle:(void (^)(CGFloat keyboredDismissTime))handle;

/**标识*/
+ (NSString *)cellReuseIdentifier;
/**当前view所属控制器*/
- (UIViewController *)viewController;
/**找到特定子视图*/
- (id)subViewWithClass:(Class)clazz;
/**找到特定父视图*/
- (id)superViewWithClass:(Class)clazz;
/**找到第一响应者*/
- (UIView *)getFirstResponder;
/**渐变从父视图移除*/
- (void)wkc_removeFromSuperViewWithDuraton:(NSTimeInterval)duration completionHandle:(void(^)(void))handle;
/**添加阴影*/
- (void)shadowWithCornerRadius:(CGFloat)radius shadowColor:(UIColor *)color shadowOffSet:(CGSize)offset shadowOpacity:(CGFloat)opacity shadowBlur:(CGFloat)blur;
/**拖动*/
- (void)addPanAnimation;
/**截屏*/
- (UIImage *)screenshot;
/**截屏 @param maxWidth 限制缩放的最大宽度 保持默认传0*/
- (UIImage *)screenshot:(CGFloat)maxWidth;
/**渐变色*/
- (void)gradientWithColors:(NSArray <UIColor *>*)colors startPoint:(CGPoint)start endPoint:(CGPoint)end changeLocation:(CGFloat)location;
@end
