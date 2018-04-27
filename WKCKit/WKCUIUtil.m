//
//  WKCUIUtil.m
//  WKCDevelop
//
//  Created by 魏昆超 on 2018/4/25.
//  Copyright © 2018年 WeiKunChao. All rights reserved.
//

#import "WKCUIUtil.h"

@implementation WKCUIUtil
+ (BOOL)isPhone4Or5 {
    return [UIScreen mainScreen].bounds.size.height == 480 ||  [UIScreen mainScreen].bounds.size.height == 568;
}

+ (BOOL)isPhone6 {
    return [UIScreen mainScreen].bounds.size.height == 667;
}

+ (BOOL)isPhone6p {
    return [UIScreen mainScreen].bounds.size.height == 736;
}

+ (BOOL)isPhoneX {
    return [UIScreen mainScreen].bounds.size.height == 812;
}

+ (BOOL)isiPad {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return NO;
    }
}

+ (CGFloat)iphoneXTopSpace
{
    if ([WKCUIUtil isPhoneX]) {
        return 44;
    }
    return 0;
}

+ (CGFloat)iphoneXBottomSpace
{
    if ([WKCUIUtil isPhoneX]) {
        return 34;
    }
    return 0;
}

+ (CGFloat)heightOfNavigationBar
{
    return 44.0f;
}

+ (CGFloat)heightOfStatusBar
{
    if ([WKCUIUtil isPhoneX]) {
        return 44.0f;
    } else {
        return 20.0f;
    }
}

+ (CGFloat)heightOfNavigation
{
    return [self heightOfStatusBar] + [self heightOfNavigationBar];
}

+ (CGFloat)heightOfTabBar
{
    return 49.0f + [self iphoneXBottomSpace];
}
@end
