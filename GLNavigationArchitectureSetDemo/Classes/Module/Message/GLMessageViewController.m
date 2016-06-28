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
    
//    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"管理" style:UIBarButtonItemStyleDone target:self action:@selector(gotoGuanliVC)];
    
}

@end
