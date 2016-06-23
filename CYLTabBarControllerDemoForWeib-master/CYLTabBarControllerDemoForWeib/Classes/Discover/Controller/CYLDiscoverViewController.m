//
//  CYLDiscoverViewController.m
//  CYLTabBarController演示Demo
//
//  Created by微博@iOS程序犭袁 （http://weibo.com/luohanchenyilong/）on 15-10-20.
//  Copyright (c) 2014年 https://github.com/ChenYilong . All rights reserved.
//

#import "CYLDiscoverViewController.h"
#import "CYLSearchBar.h"

@interface CYLDiscoverViewController ()

@end

@implementation CYLDiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.添加一个搜索框
//    self.navigationItem.titleView = [[UISwitch alloc] init];
    
    // 1.创建一个搜索框
    CYLSearchBar *searchBar = [[CYLSearchBar alloc] init];

    // 2.设置frame 注意:由于设置的是导航条的头部视图,所以x,y无效
    searchBar.frame = CGRectMake(0, 0, 300, 35);
    
    // 3.把搜索框添加到导航控制器的View中
    self.navigationItem.titleView = searchBar;
    
}

@end
