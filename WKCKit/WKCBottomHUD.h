//
//  WKCBottomHUD.h
//  WKCDevelop
//
//  Created by 魏昆超 on 2018/4/28.
//  Copyright © 2018年 WeiKunChao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKCBottomHUD : UIView
+ (instancetype)sharedInstance;
- (void)showWithText:(NSString *)text duration:(NSTimeInterval)duration;
@end
