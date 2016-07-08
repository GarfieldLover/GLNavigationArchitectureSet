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
};


/**
 *  滑动类型，只对ScreenShotPopStyle 起作用
 */
typedef NS_ENUM(NSUInteger, DragType) {
    /**
     *  👈
     */
    Left,
    /**
     *  👉
     */
    Right,
    /**
     *  🈲️
     */
    forbid
};

@protocol GLNavigationControllerDelegate <NSObject>

@optional

-(void)pushNextViewController;

@end


@interface GLNavigationController : UINavigationController

@property (nonatomic,weak) id<GLNavigationControllerDelegate> pushViewControllerdelegate;

@property (nonatomic,assign) PopStyle popStyle;

@property (nonatomic,assign) DragType dragType;

/**
 *  left模式下，topview在最右侧，则不变化DragType
 */
@property (nonatomic,assign) BOOL viewInRightMax;

/**
 *  取消当前手势滑动
 */
-(void)cancelGestureRecognizerMove;


@end
