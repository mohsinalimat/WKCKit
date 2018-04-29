//
//  WKCUIUtil.m
//  WKCDevelop
//
//  Created by 魏昆超 on 2018/4/25.
//  Copyright © 2018年 WeiKunChao. All rights reserved.
//

#import "WKCUIUtil.h"

static WKCUIUtil *_instance = nil;
@implementation WKCUIUtil

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_instance) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

- (WKCUIUtil *)sharedInstance {
    return [WKCUIUtil sharedInstance];
}

+ (instancetype)sharedInstance {
    return [[self alloc] init];
}

- (BOOL)isPhone4Or5 {
      return [UIScreen mainScreen].bounds.size.height == 480 ||  [UIScreen mainScreen].bounds.size.height == 568;
}

- (BOOL)isPhone6 {
   return [UIScreen mainScreen].bounds.size.height == 667;
}

- (BOOL)isPhone6p {
   return [UIScreen mainScreen].bounds.size.height == 736;
}

- (BOOL)isPhoneX {
    return [UIScreen mainScreen].bounds.size.height == 812;
}

- (BOOL)isiPad {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return NO;
    }
}

- (CGFloat)iphoneXTopSpace {
    if (self.isPhoneX) {
        return 44;
    }
    return 0;
}

- (CGFloat)iphoneXBottomSpace {
    if (self.isPhoneX) {
        return 34;
    }else {
        return 0;
    }
}

- (CGFloat)heightOfNavigationBar {
    return 44.0f;
}

- (CGFloat)heightOfStatusBar {
    if (self.isPhoneX) {
        return 44.0f;
    }else {
        return 20.f;
    }
}

- (CGFloat)heightOfNavigation {
    return self.heightOfStatusBar + self.heightOfNavigationBar;
}

- (CGFloat)heightOfTabBar {
    return 49.0f + self.iphoneXBottomSpace;
}

@end
