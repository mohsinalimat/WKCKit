//
//  UINavigationController+Transition.h
//  WKCDevelop
//
//  Created by 魏昆超 on 2018/4/26.
//  Copyright © 2018年 WeiKunChao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Transition)

/**自定义push动画 None无效果,CurlUp向上翻页,CurlDown向下翻页,FlipFromLeft相离翻页,FlipFromRight向外翻页*/
- (void)wkc_pushViewController:(UIViewController *)controller withTransition:(UIViewAnimationTransition)transition;
/**自定义pop动画 None无效果,CurlUp向上翻页,CurlDown向下翻页,FlipFromLeft相离翻页,FlipFromRight向外翻页*/
- (UIViewController *)wkc_popViewControllerWithTransition:(UIViewAnimationTransition)transition;

/**pop回指定控制器*/
- (void)popToDesignationController:(Class)controller animated:(BOOL)animated compeletionHandle:(void(^)(UIViewController *DesignatedViewController))handle;
@end
