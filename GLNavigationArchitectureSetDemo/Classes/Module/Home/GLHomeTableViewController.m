//
//  GLHomeTableViewController.m
//  GLNavigationArchitectureSet
//
//  Created by zhangke on 16/7/3.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "GLHomeTableViewController.h"
#import "NoLimitScorllview.h"

@interface GLHomeTableViewController ()<NoLimitScorllviewDelegate>

@end

@implementation GLHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 80;
    
    NSArray *images = @[@"01.jpg",@"02.jpg",@"03.jpg",@"04.jpg"];
    NSArray *titlles = @[@"01-图片",@"02-图片",@"03-图片",@"04-图片"];
    NoLimitScorllview *view = [[NoLimitScorllview alloc]initWithShowImages:images AndTitals:titlles];
    view.delegate = self;
    self.tableView.tableHeaderView = view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 15;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [ tableView dequeueReusableCellWithIdentifier:ID ];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"00"];
    cell.textLabel.text = @"this is a demo";
    cell.detailTextLabel.text = @"Accept what was and what is, and you’ll have more positive energy to pursue what will be";
    cell.detailTextLabel.numberOfLines = 0;
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


@end


