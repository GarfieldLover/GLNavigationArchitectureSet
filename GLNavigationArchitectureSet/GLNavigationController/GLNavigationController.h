//
//  GLNavigationController.h
//  GLNavigationArchitectureSet
//
//  Created by zhangke on 16/7/1.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  pop模式
 */
typedef NS_ENUM(NSUInteger, PopStyle) {
    /**
     *  系统手势方法
     */
    SystemPopStyle,
    /**
     *  截屏方法
     */
    ScreenShotPopStyle
    
//    /**
//     *  左滑呼出next vc
//     */
//    ScreenShotPopStyle

};

@interface GLNavigationController : UINavigationController

/**
*  设置手势是否有效
*/
@property (nonatomic,assign) BOOL canDragBack;

@property (nonatomic,assign) PopStyle popStyle;

@end
