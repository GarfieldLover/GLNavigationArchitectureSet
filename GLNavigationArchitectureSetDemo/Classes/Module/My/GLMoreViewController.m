//
//  GLMoreViewController.m
//  GLNavigationArchitectureSet
//
//  Created by ZK on 16/6/28.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "GLMoreViewController.h"
#import "UINavigationBar+GLTransform.h"

@implementation GLMoreViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    [self.navigationController.navigationBar setBackgroundColor:color];
}


@end
