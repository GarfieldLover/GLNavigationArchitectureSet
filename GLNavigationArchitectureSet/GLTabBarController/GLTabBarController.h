//
//  GLTabBarController.h
//  GLNavigationArchitectureSet
//
//  Created by ZK on 16/6/22.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * _Nonnull const GLTabBarItemTitle;
extern NSString * _Nonnull const GLTabBarItemImage;
extern NSString * _Nonnull const GLTabBarItemSelectedImage;
extern NSString * _Nonnull const GLTabBarItemTitleTextAttributes;
extern NSString * _Nonnull const GLTabBarItemSelectedTitleTextAttributes;


@interface GLTabBarController : UITabBarController


+ (nullable instancetype)tabBarControllerWithViewControllers:(nonnull NSArray<__kindof UIViewController *> *)viewControllers tabBarItemsAttributes:(nonnull NSArray<NSDictionary *> *)tabBarItemsAttributes;

- (nullable instancetype)initWithViewControllers:(nonnull NSArray<__kindof UIViewController *> *)viewControllers tabBarItemsAttributes:(nonnull NSArray<NSDictionary *> *)tabBarItemsAttributes;


@end
