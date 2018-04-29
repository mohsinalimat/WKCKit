//
//  WKCUIUtil.h
//  WKCDevelop
//
//  Created by 魏昆超 on 2018/4/25.
//  Copyright © 2018年 WeiKunChao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
#endif
#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height
#endif
#ifndef Width_Scale_Multiply
#define Width_Scale_Multiply(width)  ((width)*(SCREEN_WIDTH)/375)
#endif
#ifndef Height_Scale_Multiply
#define Height_Scale_Multiply(height) ((height)*(SCREEN_HEIGHT)/667)
#endif

@interface WKCUIUtil : NSObject
@property (nonatomic, strong, readonly) WKCUIUtil * sharedInstance;
@property (nonatomic, assign, readonly) BOOL isPhone4Or5;
@property (nonatomic, assign, readonly) BOOL isPhone6;
@property (nonatomic, assign, readonly) BOOL isPhone6p;
@property (nonatomic, assign, readonly) BOOL isPhoneX;
@property (nonatomic, assign, readonly) BOOL isiPad;
@property (nonatomic, assign, readonly) CGFloat iphoneXTopSpace;
@property (nonatomic, assign, readonly) CGFloat iphoneXBottomSpace;
@property (nonatomic, assign, readonly) CGFloat heightOfNavigationBar;
@property (nonatomic, assign, readonly) CGFloat heightOfStatusBar;
@property (nonatomic, assign, readonly) CGFloat heightOfNavigation;
@property (nonatomic, assign, readonly) CGFloat heightOfTabBar;

+ (instancetype)sharedInstance;
@end
