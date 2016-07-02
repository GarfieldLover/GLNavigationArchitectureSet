//
//  GLPersonViewController.m
//  GLNavigationArchitectureSet
//
//  Created by zhangke on 16/6/27.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "GLPersonViewController.h"
#import "UINavigationBar+Awesome.h"
#import "GLMoreViewController.h"


@interface GLPersonViewController ()<UITableViewDelegate,UITableViewDataSource>{
    CGFloat scaleImageHeight;
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView *scaleImageView;

@end


@implementation GLPersonViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    

    self.view.backgroundColor=[UIColor whiteColor];
    
    self.navigationItem.title=@"我的";
    
    UIButton* right=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage* image=[UIImage imageNamed:@"tabbar_more_selected"];
    [right setImage:image forState:UIControlStateNormal];
    [right setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [right addTarget:self action:@selector(moreVC) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:right];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    UIImage* scaleImage=[UIImage imageNamed:@"scaleImage"];
    scaleImageHeight=scaleImage.size.height;
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // 下移TableView内容
    _tableView.frame = self.view.bounds;

    _tableView.contentInset = UIEdgeInsetsMake(scaleImage.size.height, 0, 0, 0);
    
    _scaleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, scaleImage.size.height)];
    _scaleImageView.contentMode = UIViewContentModeScaleAspectFill;
    _scaleImageView.clipsToBounds = YES;
    _scaleImageView.image = scaleImage;
    
    [self.view addSubview:_tableView];
    [self.view addSubview:_scaleImageView];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1]];

}

-(void)moreVC
{
    GLMoreViewController* more=[[GLMoreViewController alloc] init];
    [self.navigationController pushViewController:more animated:YES];
}

-(UIImage*)cropImage
{
//    rect = CGRectMake(self.size.width/4*3, 0, self.size.width/4, self.size.height);
//    break;
//    default:
//    break;
//    }
//    CGImageRef imageRef = self.CGImage;
//    CGImageRef imagePartRef = CGImageCreateWithImageInRect(imageRef, rect);
//    UIImage *cropImage = [UIImage imageWithCGImage:imagePartRef];
//    CGImageRelease(imagePartRef);
//    return cropImage;
    return nil;
}

-(void)viewWillAppear:(BOOL)animated
{

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self scrollViewDidScroll:self.tableView];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];

}


#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 计算当前偏移位置
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat delta = scaleImageHeight+offsetY;
    if(delta<0.0){
        CGRect rect=self.scaleImageView.frame;
        rect.size.height= scaleImageHeight - delta;
        self.scaleImageView.frame=rect;
    }else{
        CGRect rect=self.scaleImageView.frame;
        rect.origin.y=-delta;
        self.scaleImageView.frame=rect;
    }
    
#if 1
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    if (offsetY > -64.0f*2) {
        CGFloat alpha = MIN(1, (64*2+ offsetY) / 64);

        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }

#else
    if (offsetY > -scaleImageHeight) {

        if (offsetY > -scaleImageHeight+44) {
            [self setNavigationBarTransformProgress:1];
        } else {
            [self setNavigationBarTransformProgress:((offsetY+scaleImageHeight) / 44.0f)];
        }
    } else {
        [self setNavigationBarTransformProgress:0];
        self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
    }
#endif
}

- (void)setNavigationBarTransformProgress:(CGFloat)progress
{
    [self.navigationController.navigationBar lt_setTranslationY:(-44 * progress)];
    [self.navigationController.navigationBar lt_setElementsAlpha:(1-progress)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 33;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifer = @"systemCells";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}





@end
