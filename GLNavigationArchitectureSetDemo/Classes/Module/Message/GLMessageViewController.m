//
//  GLMessageViewController.m
//  GLNavigationArchitectureSet
//
//  Created by zhangke on 16/6/27.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "GLMessageViewController.h"

@implementation GLMessageViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.navigationItem.title=@"消息";
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"左视图" style:UIBarButtonItemStyleDone target:self action:@selector(presentLeftSideViewController)];

    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"右视图" style:UIBarButtonItemStyleDone target:self action:@selector(presentRightSideViewController)];
    
}

@end
