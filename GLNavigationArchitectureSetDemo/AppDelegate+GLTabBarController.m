//
//  AppDelegate+GLTabBarController.m
//  GLNavigationArchitectureSet
//
//  Created by ZK on 16/6/22.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "AppDelegate+GLTabBarController.h"
#import "GLSpecialButtonSubclass.h"
#import "GLHomeViewController.h"
#import "GLMessageViewController.h"
#import "GLDiscoveryViewController.h"
#import "GLPersonViewController.h"
//#import "UINavigationController+FDFullscreenPopGesture.h"
#import "MLNavigationController.h"
#import "ZTViewController.h"
#import "ZTTableViewController.h"
#import "DEMOLeftMenuViewController.h"
#import "DEMORightMenuViewController.h"

@implementation AppDelegate (GLTabBarController)

- (RESideMenu*)sideMenuViewController
{
    
    DEMOLeftMenuViewController *leftMenuViewController = [[DEMOLeftMenuViewController alloc] init];
    DEMORightMenuViewController *rightMenuViewController = [[DEMORightMenuViewController alloc] init];

    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:[self tabBarController]
                                                                    leftMenuViewController:leftMenuViewController
                                                                   rightMenuViewController:rightMenuViewController];
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
//    sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
//    sideMenuViewController.delegate = self;
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuViewController.contentViewShadowOpacity = 0.6;
    sideMenuViewController.contentViewShadowRadius = 12;
    sideMenuViewController.contentViewShadowEnabled = YES;
    
    
    return sideMenuViewController;
}

- (GLTabBarController*)tabBarController
{
    GLSpecialButtonSubclass* specialButton = [[GLSpecialButtonSubclass alloc] init];

    GLTabBarController* tabBarController=[GLTabBarController tabBarControllerWithViewControllers:[self setupViewControllers] tabBarItemsAttributes:[self customizeTabBarForControll] SpecialButtonWith:specialButton ];
    
//    [tabBarController setTabBarHeight:40];
//    [tabBarController xzm_setShadeItemBackgroundColor:[UIColor grayColor]];

    return tabBarController;
}

- (NSArray*)setupViewControllers
{
    
    Class vc1 = [ZTTableViewController class];
    NSArray *vcclass = @[vc1,vc1,vc1,vc1,vc1,vc1,vc1,vc1,vc1,vc1,vc1,vc1];
    NSArray *titles = @[@"太原理工大学",@"热点",@"视频",@"体育",@"事实",@"NBA",@"美女",@"美女",@"体育",@"体育",@"优衣库",@"沈阳地铁"];
    
    ZTViewController *vca = [[ZTViewController alloc]initWithMneuViewStyle:MenuViewStyleDefault];
    [vca loadVC:vcclass AndTitle:titles];
//    GLHomeViewController *firstViewController = [[GLHomeViewController alloc] init];
    UINavigationController *firstNavigationController = [[MLNavigationController alloc]
                                                   initWithRootViewController:vca];
    
    GLMessageViewController *secondViewController = [[GLMessageViewController alloc] init];
    UINavigationController *secondNavigationController = [[MLNavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    GLDiscoveryViewController *thirdViewController = [[GLDiscoveryViewController alloc] init];
    UINavigationController *thirdNavigationController = [[MLNavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    GLPersonViewController *fourthViewController = [[GLPersonViewController alloc] init];
    UINavigationController *fourthNavigationController = [[MLNavigationController alloc]
                                                    initWithRootViewController:fourthViewController];
    
    NSArray* array=@[firstNavigationController,secondNavigationController,thirdNavigationController, fourthNavigationController];
    return array;
    
}

- (NSArray*)customizeTabBarForControll {
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:144.0/255.0 green:144.0/255.0 blue:144.0/255.0 alpha:1];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:241.0/255.0 green:124.0/255.0 blue:0/255.0 alpha:1];
    
    NSDictionary *dict1 = @{
//                            GLTabBarItemTitle : @"首页",
                            GLTabBarItemImage : @"tabbar_home_os7",
                            GLTabBarItemSelectedImage : @"tabbar_home_selected_os7",
                            GLTabBarItemTitleTextAttributes : normalAttrs,
                            GLTabBarItemSelectedTitleTextAttributes : selectedAttrs
                            };
    NSDictionary *dict2 = @{
//                            GLTabBarItemTitle : @"消息",
                            GLTabBarItemImage : @"tabbar_message_center_os7",
                            GLTabBarItemSelectedImage : @"tabbar_message_center_selected_os7",
                            GLTabBarItemTitleTextAttributes : normalAttrs,
                            GLTabBarItemSelectedTitleTextAttributes : selectedAttrs
                            };
    NSDictionary *dict3 = @{
//                            GLTabBarItemTitle : @"发现",
                            GLTabBarItemImage : @"tabbar_discover_os7",
                            GLTabBarItemSelectedImage : @"tabbar_discover_selected_os7",
                            GLTabBarItemTitleTextAttributes : normalAttrs,
                            GLTabBarItemSelectedTitleTextAttributes : selectedAttrs
                            };
    NSDictionary *dict4 = @{
//                            GLTabBarItemTitle : @"我的",
                            GLTabBarItemImage : @"tabbar_profile_os7",
                            GLTabBarItemSelectedImage : @"tabbar_profile_selected_os7",
                            GLTabBarItemTitleTextAttributes : normalAttrs,
                            GLTabBarItemSelectedTitleTextAttributes : selectedAttrs
                            };
    NSArray *tabBarItemsAttributes = @[ dict1, dict2, dict3, dict4 ];
    return tabBarItemsAttributes;
}


@end
