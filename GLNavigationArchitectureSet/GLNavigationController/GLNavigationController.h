//
//  GLNavigationController.h
//  GLNavigationArchitectureSet
//
//  Created by zhangke on 16/7/1.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PopStyle){
    SystemPopStyle,
    ScreenShotPopStyle
};

@interface GLNavigationController : UINavigationController
/**
 *  设置手势是否有效
 *
 */
@property (nonatomic,assign) BOOL canDragBack;

@property (nonatomic,assign) PopStyle popStyle;

@end
