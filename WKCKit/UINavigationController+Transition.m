//
//  UINavigationController+Transition.m
//  WKCDevelop
//
//  Created by 魏昆超 on 2018/4/26.
//  Copyright © 2018年 WeiKunChao. All rights reserved.
//

#import "UINavigationController+Transition.h"

@implementation UINavigationController (Transition)

- (void)wkc_pushViewController:(UIViewController *)controller withTransition:(UIViewAnimationTransition)transition {
    [UIView beginAnimations:nil context:NULL];
    [self pushViewController:controller animated:NO];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationTransition:transition forView:self.view cache:YES];
    [UIView commitAnimations];
}

- (UIViewController *)wkc_popViewControllerWithTransition:(UIViewAnimationTransition)transition {
    [UIView beginAnimations:nil context:NULL];
    UIViewController *controller = [self popViewControllerAnimated:NO];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationTransition:transition forView:self.view cache:YES];
    [UIView commitAnimations];
    return controller;
}

- (void)popToDesignationController:(Class)controller animated:(BOOL)animated compeletionHandle:(void(^)(UIViewController *DesignatedViewController))handle {
    for (UIViewController *viewController in self.viewControllers) {
        if ([viewController isKindOfClass:controller]) {
            if (handle) {
                handle(viewController);
            }
            [self popToViewController:viewController animated:animated];
        }
    }
}

@end
