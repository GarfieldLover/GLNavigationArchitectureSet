//
//  UIViewController+GLSide.h
//  GLNavigationArchitectureSet
//
//  Created by zhangke on 16/7/3.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GLSideViewController;

@interface UIViewController (GLSide)

@property (nonatomic , readonly, strong) GLSideViewController* sideViewController;


- (void)presentLeftSideViewController:(id)sender;
- (void)presentRightSideViewController:(id)sender;

@end
