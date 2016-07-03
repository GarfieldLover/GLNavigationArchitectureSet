//
//  GLPageViewController.m
//  GLNavigationArchitectureSet
//
//  Created by zhangke on 16/7/1.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "GLPageViewController.h"
#import "GLPageDefine.h"

@interface GLPageViewController ()<UIScrollViewDelegate, GLPageControlViewDelegate>

@property (nonatomic, strong) UIScrollView *containerScrollView;

@property (nonatomic, strong) NSMutableArray *controllerFrames;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, assign) NSInteger selectedIndex;

//vc缓存
@property (nonatomic, strong) NSMutableDictionary *controllerCache;

@property (nonatomic, assign) BOOL  needPageControlView;

@end


@implementation GLPageViewController
@synthesize pageControlView=_pageControlView;

#pragma mark 加载
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
}

- (instancetype)initWithTitles:(NSArray *)titles pageControlStyle:(GLPageControlStyle)style needPageControlView:(BOOL)needPageControlView
{
    if (self = [super init]) {
        
        self.style=style;
        self.titles  = titles;
        
        self.needPageControlView = needPageControlView;
        [self loadSideViewWithTitles:self.titles];
    }
    return self;
}

- (void)loadSideViewWithTitles:(NSArray *)titles
{
    GLPageControlView *pageControlView = [[GLPageControlView alloc]initWithPageControlStyle:self.style AndTitles:titles];
    if(self.needPageControlView){
        [self.view addSubview:pageControlView];
    }else{
        pageControlView.backgroundColor=[UIColor clearColor];
    }
    pageControlView.delegate = self;
    _pageControlView = pageControlView;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    if(self.controllerFrames.count==0){
        for (int j = 0; j < self.titles.count; j++) {
            CGFloat X = j * ScreenWidth;
            CGFloat Y = 0;
            CGFloat height = self.view.height;
            CGRect frame = CGRectMake(X, Y, ScreenWidth, height);
            [self.controllerFrames addObject:[NSValue valueWithCGRect:frame]];
        }
    }

    if(self.needPageControlView){
        _pageControlView.frame = CGRectMake(0, 0, ScreenWidth, MenuHeight);
    }
    self.containerScrollView.frame = CGRectMake(0, self.needPageControlView?_pageControlView.y+_pageControlView.height:0, ScreenWidth,ScreenHeight - self.containerScrollView.y);
    self.containerScrollView.contentSize = CGSizeMake(self.titles.count * self.containerScrollView.width, 0);
    
    self.selectedIndex=0;
    [self addxxff];
}


- (void)addViewControllerViewAtIndex:(NSInteger)index
{
    //delegate取vc
    UIViewController* vc = [self.delegate getViewControllerWithIndex:index];

    vc.view.frame = [self.controllerFrames[index] CGRectValue];
    [self.controllerCache setObject:vc forKey:@(index)];
    [self addChildViewController:vc];
    [self.containerScrollView addSubview:vc.view];
}

- (void)removeViewControllerAtIndex:(NSInteger)index
{
    UIViewController* viewController=[self.controllerCache objectForKey:@(index)];
    if(viewController){
        [viewController.view removeFromSuperview];
        [viewController willMoveToParentViewController:nil];
        [viewController removeFromParentViewController];
        [self.controllerCache removeObjectForKey:@(index)];
    }
    
}

- (BOOL)isInScreen:(CGRect)frame
{
    CGFloat x = frame.origin.x;
    CGFloat ScreenWith = self.containerScrollView.frame.size.width;
    
    CGFloat contentOffsetX = self.containerScrollView.contentOffset.x;
    
    NSLog(@"%f,%f,%f----------",contentOffsetX , CGRectGetMaxX(frame), x - contentOffsetX);

    if (CGRectGetMaxX(frame) >contentOffsetX && x - contentOffsetX < ScreenWith ){
        return YES;
    }else{
        return NO;
    }
}

- (void)addCachedViewController:(UIViewController *)viewController atIndex:(NSInteger)index
{
    if(viewController.parentViewController!=self && viewController.view.superview!=self.containerScrollView){
        [self addChildViewController:viewController];
        [self.containerScrollView addSubview:viewController.view];
    }
}

#pragma mark delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index = (int)(scrollView.contentOffset.x/self.view.width);
    CGFloat rate = scrollView.contentOffset.x/self.view.width;
    
    self.selectedIndex=index;
    
    [self addxxff];
    [self removexxx:self.selectedIndex];

    [_pageControlView SelectedBtnMoveToCenterWithIndex:index WithRate:rate];
}

-(void)addxxff
{
    
    [self addxxx:self.selectedIndex-1];
    [self addxxx:self.selectedIndex];
    [self addxxx:self.selectedIndex+1];
    
}

- (void)addxxx:(NSInteger)index
{
    if(index>self.selectedIndex+1 || index< self.selectedIndex-1 || index<0){
        return;
    }
    UIViewController *vc = [self.controllerCache objectForKey:@(index)];
    
    if (vc) {
        //把内存中的取出来创建
        [self addCachedViewController:vc atIndex:index];
    }else{
        //创建
        [self addViewControllerViewAtIndex:index];
    }
}

-(void)removexxx:(NSInteger)index
{
    for(NSString* key in self.controllerCache.allKeys){
        NSInteger page = key.integerValue;
        if(page != index-1 && page != index && page != index+1 ){
            [self removeViewControllerAtIndex:page];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.x < 0 || scrollView.contentOffset.x > scrollView.contentSize.width){
        return;
    }
    int page = (int)(scrollView.contentOffset.x/self.view.width);
    
    //因为我用的UItabbar做的展示，所以切换tabar的时候，会出现控制器不清除的结果，使得通知中心紊乱，其他控制器也可以接收当前控制器发送的通知，所以，我把通知名称设置为唯一的；
    NSString *name  = [NSString stringWithFormat:@"scrollViewDidFinished%zd",_pageControlView.style];
    NSDictionary *info = @{
                           @"index":@(page)};
    [[NSNotificationCenter defaultCenter]postNotificationName:name  object:nil userInfo:info];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (scrollView.contentOffset.x < 0 || scrollView.contentOffset.x > scrollView.contentSize.width){
        return;
    }
    
    if(!decelerate){
        int page = (int)(scrollView.contentOffset.x/ScreenWidth);
        
        if (page == 0) {
            [_pageControlView selectWithIndex:page AndOtherIndex:page + 1 ];
        }else if (page == self.controllerFrames.count - 1){
            [_pageControlView selectWithIndex:page AndOtherIndex:page - 1];
        }else{
            [_pageControlView selectWithIndex:page AndOtherIndex:page + 1 ];
            [_pageControlView selectWithIndex:page AndOtherIndex:page - 1];
        }
    }
}

- (void)pageControlViewDidSelectWithIndex:(NSInteger)index
{
    [self removeViewControllerAtIndex:_selectedIndex];
    
    self.containerScrollView.contentOffset = CGPointMake(index * ScreenWidth, 0);
    self.selectedIndex = index;
    
    UIViewController *vc = [self.controllerCache objectForKey:@(index)];
    if (vc == nil) {
        vc = [self.controllerCache objectForKey:@(index)];
        if (vc) {
            [self addCachedViewController:vc atIndex:index];
        }else{
            [self addViewControllerViewAtIndex:index];
        }
    }
}

#pragma mark Lazy load
- (NSArray *)titles {
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}

- (UIScrollView *)containerScrollView {
    if (!_containerScrollView) {
        self.containerScrollView = [[UIScrollView alloc]init];
        self.containerScrollView.backgroundColor = [UIColor whiteColor];
        self.containerScrollView.pagingEnabled = YES;
        self.containerScrollView.delegate = self;
        [self.view addSubview:self.containerScrollView];
    }
    return _containerScrollView;
}

- (NSMutableArray *)controllerFrames {
    if (!_controllerFrames) {
        _controllerFrames = [NSMutableArray array];
    }
    return _controllerFrames;
}

- (NSMutableDictionary *)controllerCache {
    if (!_controllerCache) {
        _controllerCache = [NSMutableDictionary dictionaryWithCapacity:3];
    }
    return _controllerCache;
}


@end
