//
//  GLPageVCModel.m
//  GLNavigationArchitectureSet
//
//  Created by zhangke on 16/7/3.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "GLPageVCModel.h"
#import "GLHomeTableViewController.h"

@implementation GLPageVCModel

-(UIViewController *)getViewControllerWithIndex:(NSUInteger)index
{
    return [[GLHomeTableViewController alloc] init];
}

-(void)didSelectViewControllerWithIndex:(NSUInteger)index
{
    
}

@end
