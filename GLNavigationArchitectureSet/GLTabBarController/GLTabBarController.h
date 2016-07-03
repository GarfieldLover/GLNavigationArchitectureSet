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
 * An array of the root view controllers displayed by the tab bar interface.
 */
@property (nonnull, nonatomic, readwrite, copy) NSArray<__kindof UIViewController *> *viewControllers;

/*!
 * The Attributes of items which is displayed on the tab bar.
 */
@property (nonnull, nonatomic, readwrite, copy) NSArray<NSDictionary *> *tabBarItemsAttributes;

/*!
 * Customize UITabBar height
 */
@property (nonatomic, assign) CGFloat tabBarHeight;



+ (nullable instancetype)tabBarControllerWithViewControllers:(nonnull NSArray<__kindof UIViewController *> *)viewControllers tabBarItemsAttributes:(nonnull NSArray<NSDictionary *> *)tabBarItemsAttributes SpecialButtonWith:(nullable GLSpecialButton *)specialButton;

- (nullable instancetype)initWithViewControllers:(nonnull NSArray<__kindof UIViewController *> *)viewControllers tabBarItemsAttributes:(nonnull NSArray<NSDictionary *> *)tabBarItemsAttributes SpecialButtonWith:(nullable GLSpecialButton *)specialButton;


/**
 *  设置高亮背景图片
 *
 *  @param backgroundImage 高亮背景图片
 */
- (void)setShadeItemBackgroundImage:(UIImage * _Nonnull)backgroundImage;

/**
 *  设置高亮背景颜色
 *
 *  @param coloer 高亮背景颜色
 */
- (void)setShadeItemBackgroundColor:(UIColor * _Nonnull)coloer;

@end
