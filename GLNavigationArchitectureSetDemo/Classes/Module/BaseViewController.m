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
        
        self.hidesBottomBarWhenPushed=YES;

    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton* left=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage* image=[UIImage imageNamed:@"round_back_btn_normal.png"];
    [left setImage:image forState:UIControlStateNormal];
    [left setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [left addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:left];
    
}

-(void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
