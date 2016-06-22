//
//  GLTabBarController.h
//  GLNavigationArchitectureSet
//
//  Created by ZK on 16/6/22.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface GLTabBarController : UITabBarController


+ (nullable instancetype)tabBarControllerWithViewControllers:(nonnull NSArray<__kindof UIViewController *> *)viewControllers tabBarItemsAttributes:(nonnull NSArray<NSDictionary *> *)tabBarItemsAttributes;

- (nullable instancetype)initWithViewControllers:(nonnull NSArray<__kindof UIViewController *> *)viewControllers tabBarItemsAttributes:(nonnull NSArray<NSDictionary *> *)tabBarItemsAttributes;


@end
