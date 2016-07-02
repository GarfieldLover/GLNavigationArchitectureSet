//
//  GLPageViewController.h
//  GLNavigationArchitectureSet
//
//  Created by zhangke on 16/7/1.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLPageControlView.h"

@interface GLPageViewController : UIViewController

@property (nonatomic,assign) GLPageControlStyle style;

@property (nonatomic,strong,readonly) GLPageControlView *Menview;

/**
 *  缓存中可以存储最大控制器的量（经测试，NSCache初步是FIFO的，它的最大数量最大就是这个属性，超过会释放当前最先进入的
 */
@property (nonatomic,assign)NSInteger countLimit;
//加载控制器的类
- (void)loadVC:(NSArray *)viewcontrollerClass AndTitle:(NSArray *)titles needaddSideView:(BOOL)need;

- (instancetype)initWithMneuViewStyle:(GLPageControlStyle)style;

@end
