//
//  BaseViewController.m
//  GLNavigationArchitectureSet
//
//  Created by zhangke on 16/6/27.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

-(instancetype)init
{
    self=[super init];
    if(self){

    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.hidesBottomBarWhenPushed=YES;

    
    self.view.backgroundColor=[UIColor whiteColor];
    

    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"X" forState:UIControlStateNormal];
    button.frame=CGRectMake(0, 0, 40, 40);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:button];

}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    self.hidesBottomBarWhenPushed=YES;
//
//}

@end
