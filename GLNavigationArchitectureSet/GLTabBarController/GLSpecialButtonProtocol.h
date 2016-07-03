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

/**
 *  特殊按钮位置
 *
 *  @return 特殊按钮位置
 */
- (NSUInteger)indexOfSpecialButton;

@optional

/**
 *  特殊按钮点击的vc，可以不返回
 *
 *  @return 特殊按钮点击的vc
 */
- (UIViewController *)specialViewController;

@end
