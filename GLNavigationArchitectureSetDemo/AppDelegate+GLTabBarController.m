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
#import "GLNavigationController.h"
#import "GLPageViewController.h"
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
    NSArray *titles = @[@"首页",@"电视剧",@"综艺",@"会员",@"电影",@"测试超长长长长长长长长",@"动漫",@"韩日剧",@"自媒体",@"体育",@"娱乐",@"直播"];
    
    GLPageViewController* pageViewController = [[GLPageViewController alloc] initWithMneuViewStyle:GlPageControlMarkChangeStyle];
    [pageViewController loadVC:vcclass AndTitle:titles needaddMenuView:YES];
    
    
//    GLHomeViewController *firstViewController = [[GLHomeViewController alloc] init];
    UINavigationController *firstNavigationController = [[GLNavigationController alloc]
                                                   initWithRootViewController:pageViewController];
//    [firstNavigationController.navigationBar addSubview:pageViewController.Menview];
//    pageViewController.Menview.frame=firstNavigationController.navigationBar.frame;
    
    GLMessageViewController *secondViewController = [[GLMessageViewController alloc] init];
    UINavigationController *secondNavigationController = [[GLNavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    GLDiscoveryViewController *thirdViewController = [[GLDiscoveryViewController alloc] init];
    UINavigationController *thirdNavigationController = [[GLNavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    GLPersonViewController *fourthViewController = [[GLPersonViewController alloc] init];
    UINavigationController *fourthNavigationController = [[GLNavigationController alloc]
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
