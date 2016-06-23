//
//  AppDelegate+GLTabBarController.m
//  GLNavigationArchitectureSet
//
//  Created by ZK on 16/6/22.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "AppDelegate+GLTabBarController.h"

@implementation AppDelegate (GLTabBarController)

- (GLTabBarController*)tabBarController{
    GLTabBarController* ta=[GLTabBarController tabBarControllerWithViewControllers:[self setupViewControllers] tabBarItemsAttributes:[self customizeTabBarForControll]];
    return ta;
}

- (NSArray*)setupViewControllers {
    UIViewController *firstViewController = [[UIViewController alloc] init];
    UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    UIViewController *secondViewController = [[UIViewController alloc] init];
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    UIViewController *thirdViewController = [[UIViewController alloc] init];
    UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    UIViewController *fourthViewController = [[UIViewController alloc] init];
    UIViewController *fourthNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:fourthViewController];
    
    NSArray* array=@[firstNavigationController,secondNavigationController,thirdNavigationController, fourthNavigationController];
    return array;
    
}

- (NSArray*)customizeTabBarForControll {
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor brownColor];
    
    NSDictionary *dict1 = @{
                            GLTabBarItemTitle : @"首页",
                            GLTabBarItemImage : @"tabbar_home_os7",
                            GLTabBarItemSelectedImage : @"tabbar_home_selected_os7",
                            GLTabBarItemTitleTextAttributes : normalAttrs,
                            GLTabBarItemSelectedTitleTextAttributes : selectedAttrs
                            };
    NSDictionary *dict2 = @{
                            GLTabBarItemTitle : @"消息",
                            GLTabBarItemImage : @"tabbar_message_center_os7",
                            GLTabBarItemSelectedImage : @"tabbar_message_center_selected_os7",
                            GLTabBarItemTitleTextAttributes : normalAttrs,
                            GLTabBarItemSelectedTitleTextAttributes : selectedAttrs
                            };
    NSDictionary *dict3 = @{
                            GLTabBarItemTitle : @"发现",
                            GLTabBarItemImage : @"tabbar_discover_os7",
                            GLTabBarItemSelectedImage : @"tabbar_discover_selected_os7",
                            };
    NSDictionary *dict4 = @{
                            GLTabBarItemTitle : @"我的",
                            GLTabBarItemImage : @"tabbar_profile_os7",
                            GLTabBarItemSelectedImage : @"tabbar_profile_selected_os7"
                            };
    NSArray *tabBarItemsAttributes = @[ dict1, dict2, dict3, dict4 ];
    return tabBarItemsAttributes;
}

@end
