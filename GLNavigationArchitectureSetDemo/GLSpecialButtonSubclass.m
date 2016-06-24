//
//  GLSpecialButtonSubclass.m
//  GLNavigationArchitectureSet
//
//  Created by ZK on 16/6/24.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "GLSpecialButtonSubclass.h"

@implementation GLSpecialButtonSubclass

- (instancetype)init
{
	self = [super init];
	if (self) {
        UIImage *buttonImage = [UIImage imageNamed:@"tabbar_compose_button"];
        UIImage *highlightImage = [UIImage imageNamed:@"tabbar_compose_button_highlighted"];
        UIImage *iconImage = [UIImage imageNamed:@"tabbar_compose_icon_add"];
        UIImage *highlightIconImage = [UIImage imageNamed:@"tabbar_compose_icon_add"];
        
        self.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
//        self.frame = CGRectMake(0.0, 0.0, 200, 200);

        [self setImage:iconImage forState:UIControlStateNormal];
        [self setImage:highlightIconImage forState:UIControlStateHighlighted];
        [self setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
        [self addTarget:self action:@selector(specialButtonclick) forControlEvents:UIControlEventTouchUpInside];

	}
	return self;
}

- (void)specialButtonclick {
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UIViewController *viewController = tabBarController.selectedViewController;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                                            delegate:nil
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"发微薄", @"发照片", @"发视频", nil];
    [actionSheet showInView:viewController.view];
}



@end
