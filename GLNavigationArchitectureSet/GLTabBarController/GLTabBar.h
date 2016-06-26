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

@property (nullable, nonatomic) GLSpecialButton* specialButton;

- (void)setTabBarSpecialButtonWith:(nonnull GLSpecialButton *)specialButton;

@end
