//
//  GLPageViewController.h
//  GLNavigationArchitectureSet
//
//  Created by zhangke on 16/7/1.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLPageControlView.h"


@protocol GLPageViewControllerDelegate <NSObject>

@required

- (UIViewController*)getViewControllerWithIndex:(NSUInteger)index;

@end



@interface GLPageViewController : UIViewController

@property (nonatomic, weak) id<GLPageViewControllerDelegate> delegate;

@property (nonatomic,assign) GLPageControlStyle style;

@property (nonatomic,strong,readonly) GLPageControlView *pageControlView;

- (instancetype)initWithTitles:(NSArray *)titles pageControlStyle:(GLPageControlStyle)style needPageControlView:(BOOL)needPageControlView;

@end
