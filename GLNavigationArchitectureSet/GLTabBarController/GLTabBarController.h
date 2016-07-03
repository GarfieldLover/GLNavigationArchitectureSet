//
//  GLTabBarController.h
//  GLNavigationArchitectureSet
//
//  Created by ZK on 16/6/22.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLTabBar.h"
#import "GLSpecialButton.h"


extern NSString * _Nonnull const GLTabBarItemTitle;
extern NSString * _Nonnull const GLTabBarItemImage;
extern NSString * _Nonnull const GLTabBarItemSelectedImage;
extern NSString * _Nonnull const GLTabBarItemTitleTextAttributes;
extern NSString * _Nonnull const GLTabBarItemSelectedTitleTextAttributes;


@interface GLTabBarController : UITabBarController

/*!
 *  UITabBar height
 */
@property (nonatomic, assign) CGFloat tabBarHeight;


+ (nullable instancetype)tabBarControllerWithViewControllers:(nonnull NSArray<__kindof UIViewController *> *)viewControllers tabBarItemsAttributes:(nonnull NSArray<NSDictionary *> *)tabBarItemsAttributes SpecialButtonWith:(nullable GLSpecialButton *)specialButton;


- (nullable instancetype)initWithViewControllers:(nonnull NSArray<__kindof UIViewController *> *)viewControllers tabBarItemsAttributes:(nonnull NSArray<NSDictionary *> *)tabBarItemsAttributes SpecialButtonWith:(nullable GLSpecialButton *)specialButton;


- (void)setShadeItemBackgroundImage:(UIImage * _Nonnull)backgroundImage;

- (void)setShadeItemBackgroundColor:(UIColor * _Nonnull)coloer;




@end
