//
//  WKCUIUtil.h
//  WKCDevelop
//
//  Created by 魏昆超 on 2018/4/25.
//  Copyright © 2018年 WeiKunChao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height


#define Width_Scale_Multiply(width)  ((width)*(SCREEN_WIDTH)/375)
#define Height_Scale_Multiply(height) ((height)*(SCREEN_HEIGHT)/667)

@interface WKCUIUtil : NSObject
+ (BOOL)isPhone4Or5;
+ (BOOL)isPhone6;
+ (BOOL)isPhone6p;
+ (BOOL)isPhoneX;
+ (BOOL)isiPad;
+ (CGFloat)iphoneXTopSpace;
+ (CGFloat)iphoneXBottomSpace;
+ (CGFloat)heightOfNavigationBar;
+ (CGFloat)heightOfStatusBar;
+ (CGFloat)heightOfNavigation;
+ (CGFloat)heightOfTabBar;
@end
