//
//  UIViewController+GLSide.m
//  GLNavigationArchitectureSet
//
//  Created by zhangke on 16/7/3.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "UIViewController+GLSide.h"
#import "GLSideViewController.h"

@implementation UIViewController (GLSide)

- (GLSideViewController *)sideViewController
{
    UIViewController *viewController = self.parentViewController;
    while (viewController) {
        if ([viewController isKindOfClass:[GLSideViewController class]]) {
            return (GLSideViewController *)viewController;
        } else if (viewController.parentViewController && viewController.parentViewController != viewController) {
            viewController = viewController.parentViewController;
        } else {
            viewController = nil;
        }
    }
    return nil;
}

- (void)presentLeftSideViewController:(id)sender
{
    [self.sideViewController presentLeftSideViewController];
}

- (void)presentRightSideViewController:(id)sender
{
    [self.sideViewController presentRightSideViewController];
}

@end
