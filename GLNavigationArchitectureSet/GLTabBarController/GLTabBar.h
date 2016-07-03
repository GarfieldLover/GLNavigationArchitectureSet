//
//  GLTabBar.h
//  GLNavigationArchitectureSet
//
//  Created by ZK on 16/6/24.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLSpecialButton.h"

@interface GLTabBar : UITabBar

@property (nullable, nonatomic, readonly) GLSpecialButton* specialButton;

- (void)setTabBarSpecialButtonWith:(nullable GLSpecialButton *)specialButton;


- (void)setShadeItemBackgroundImage:(UIImage * _Nonnull)backgroundImage;


- (void)setShadeItemBackgroundColor:(UIColor * _Nonnull)coloer;


- (void)setShadeIndex:(NSUInteger)index;

@end
