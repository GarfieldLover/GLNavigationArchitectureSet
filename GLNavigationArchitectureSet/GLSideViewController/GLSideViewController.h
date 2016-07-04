//
//  GLSideViewController.h
//  GLNavigationArchitectureSet
//
//  Created by zhangke on 16/7/3.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GLSideViewControllerDelegate;

@interface GLSideViewController : UIViewController <UIGestureRecognizerDelegate>

@property (strong, readonly, nonatomic) UIViewController *contentViewController;
@property (strong, readonly, nonatomic) UIViewController *leftSideViewController;
@property (strong, readonly, nonatomic) UIViewController *rightSideViewController;

@property (weak, readwrite, nonatomic) id<GLSideViewControllerDelegate> delegate;

@property (assign, readwrite, nonatomic) NSTimeInterval animationDuration;

@property (strong, readwrite, nonatomic) UIImage *backgroundImage;

@property (nonatomic, assign)  BOOL fadeSideView;
@property (nonatomic, assign)  BOOL scaleContentView;
@property (nonatomic, assign)  BOOL scaleBackgroundImageView;
@property (nonatomic, assign)  BOOL scaleSideView;


- (id)initWithContentViewController:(UIViewController *)contentViewController
             leftSideViewController:(UIViewController *)leftSideViewController
            rightSideViewController:(UIViewController *)rightSideViewController;
- (void)presentLeftSideViewController;
- (void)presentRightSideViewController;
- (void)hideSideViewController;

@end


@protocol GLSideViewControllerDelegate <NSObject>

@optional

- (void)sideMenu:(GLSideViewController *)sideMenu willShowSideViewController:(UIViewController *)SideViewController;
- (void)sideMenu:(GLSideViewController *)sideMenu didShowSideViewController:(UIViewController *)SideViewController;

- (void)sideMenu:(GLSideViewController *)sideMenu willHideSideViewController:(UIViewController *)SideViewController;
- (void)sideMenu:(GLSideViewController *)sideMenu didHideSideViewController:(UIViewController *)SideViewController;

@end