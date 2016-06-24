//
//  GLSpecialButtonProtocol.h
//  GLNavigationArchitectureSet
//
//  Created by ZK on 16/6/24.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GLSpecialButtonProtocol <NSObject>

@required
/*!
 用来自定义加号按钮的位置，如果不实现默认居中。
 @attention 以下两种情况下，必须实现该协议方法，否则 CYLTabBarController 会抛出 exception 来进行提示：
 1. 添加了 PlusButton 且 TabBarItem 的个数是奇数。
 2. 实现了 `+plusChildViewController`。
 @return 用来自定义加号按钮在 TabBar 中的位置。
 *
 */
- (NSUInteger)indexOfPlusButtonInTabBar;

/*!
 实现该方法后，能让 PlusButton 的点击效果与跟点击其他 UITabBarButton 效果一样，跳转到该方法指定的 UIViewController 。
 @attention 必须同时实现 `+indexOfPlusButtonInTabBqr` 来指定 PlusButton 的位置。
 @return 指定 PlusButton 点击后跳转的 UIViewController。
 *
 */
- (UIViewController *)plusChildViewController;

@end
