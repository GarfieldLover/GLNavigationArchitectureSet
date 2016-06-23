//
//  CYLProfileViewController.m
//  CYLTabBarController演示Demo
//
//  Created by微博@iOS程序犭袁 （http://weibo.com/luohanchenyilong/）on 15-10-20.
//  Copyright (c) 2014年 https://github.com/ChenYilong . All rights reserved.
//

#import "CYLProfileViewController.h"

@interface CYLProfileViewController ()

@end

@implementation CYLProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 给导航条右边添加一个按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    
    self.navigationItem.rightBarButtonItem = item;
}

- (void)setting
{
    // 跳转到下一个控制器
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor purpleColor];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
