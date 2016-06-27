//
//  GLHomeViewController.m
//  GLNavigationArchitectureSet
//
//  Created by zhangke on 16/6/27.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "GLHomeViewController.h"
#import "GLHomeManagerViewController.h"

@implementation GLHomeViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"管理" style:UIBarButtonItemStyleDone target:self action:@selector(gotoGuanliVC)];

}

-(void)gotoGuanliVC
{
    GLHomeManagerViewController* vc=[[GLHomeManagerViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
