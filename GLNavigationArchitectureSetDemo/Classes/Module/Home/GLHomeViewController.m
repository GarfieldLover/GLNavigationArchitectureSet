//
//  GLHomeViewController.m
//  GLNavigationArchitectureSet
//
//  Created by zhangke on 16/6/27.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "GLHomeViewController.h"
#import "GLHomeManagerViewController.h"
#import "ZTViewController.h"

@implementation GLHomeViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.navigationItem.title=@"首页";

    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"管理" style:UIBarButtonItemStyleDone target:self action:@selector(gotoGuanliVC)];

    
    
    
    Class vc1 = [UIViewController class];
    NSArray *vcclass = @[vc1,vc1,vc1,vc1,vc1,vc1,vc1,vc1,vc1,vc1,vc1,vc1];
    NSArray *titles = @[@"太原理工大学",@"热点",@"视频",@"体育",@"事实",@"NBA",@"美女",@"美女",@"体育",@"体育",@"优衣库",@"沈阳地铁"];
    
    
    ZTViewController *vca = [[ZTViewController alloc]initWithMneuViewStyle:MenuViewStyleDefault];
    [vca loadVC:vcclass AndTitle:titles];
    vca.view.bounds=self.view.bounds;
    
    [self addChildViewController:vca];
    [self.view addSubview:vca.view];
}

-(void)gotoGuanliVC
{
    GLHomeManagerViewController* vc=[[GLHomeManagerViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
