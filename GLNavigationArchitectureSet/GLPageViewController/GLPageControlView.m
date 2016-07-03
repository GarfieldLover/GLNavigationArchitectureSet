//
//  GLPageControlView.m
//  GLNavigationArchitectureSet
//
//  Created by zhangke on 16/7/1.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "GLPageControlView.h"
#import "GLPageButton.h"
#import "GLPageDefine.h"

@interface GLPageControlView ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *pageControlScrollView;
@property (nonatomic,strong)GLPageButton *selectedBtn;
@property (nonatomic,strong)UIView  *line;
@property (nonatomic,assign)CGFloat sumWidth;
@property (nonatomic,assign)NSInteger btnCount;

@end

@implementation GLPageControlView

- (instancetype)initWithPageControlStyle:(GLPageControlStyle)style AndTitles:(NSArray *)titles
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.style=style;
        self.btnCount=titles.count;

        [self loadWithScollviewAndBtnWithTitles:titles];
    }
    return self;
}

- (void)loadWithScollviewAndBtnWithTitles:(NSArray *)titles {
    
    UIScrollView *pageControlScrollView = [[UIScrollView alloc]init];
    pageControlScrollView.showsVerticalScrollIndicator = NO;
    pageControlScrollView.showsHorizontalScrollIndicator = NO;
    //    pageControlScrollView.backgroundColor = [UIColor whiteColor];
    pageControlScrollView.delegate = self;
    self.pageControlScrollView= pageControlScrollView;
    [self addSubview:self.pageControlScrollView];
    //btn创建
    
    for (int i = 0; i < titles.count; i++) {
        GLPageButton *btn = [[GLPageButton alloc ]initWithTitles:titles AndIndex:i];
        btn.tag = i;
        
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.pageControlScrollView addSubview:btn];
        
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    GLPageButton *btn = nil;
    GLPageButton *btn1 = nil;
    self.sumWidth = 0;
    
    for (int i = 0; i < self.btnCount; i++){
        btn= self.pageControlScrollView.subviews[i];
        if (i>=1) {
            btn1 = self.pageControlScrollView.subviews[i-1];
        }
        UIFont *titleFont = btn.titleLabel.font;
        
        NSDictionary* dic=@{NSFontAttributeName:titleFont};
        CGSize titleS = [btn.titleLabel.text sizeWithAttributes:dic];
        
        
        btn.width = titleS.width + 2 *BtnGap;
        btn.x = btn1.x + btn1.width + BtnGap;
        btn.y = 0;
        btn.height = self.height - 2;
        self.sumWidth += btn.width;
        if (btn == [self.pageControlScrollView.subviews lastObject]) {
            CGFloat width = self.bounds.size.width;
            CGFloat height = self.bounds.size.height;
            self.pageControlScrollView.size = CGSizeMake(width, height);
            
            self.pageControlScrollView.contentSize = CGSizeMake(btn.x + btn.width+ BtnGap, 0);
            self.pageControlScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
        if (i == 0) {
            btn.selected = YES;
            self.selectedBtn = btn;
        }
        btn = nil;
        btn1 = nil;
    }
    if (self.pageControlScrollView.contentSize.width < self.width) {
        CGFloat margin = (ScreenWidth - self.sumWidth)/(self.btnCount + 1);
        for (int i = 0; i < self.btnCount; i++){
            btn= self.pageControlScrollView.subviews[i];
            if (i>=1) {
                btn1 = self.pageControlScrollView.subviews[i-1];
            }
            btn.x = btn1.x + btn1.width + margin;
            
        }
    }
    
    if (self.style == GLPageControlFontChangeStyle) {
        [self.selectedBtn ChangSelectedColorAndScalWithRate:0.1];
    }else{
        [self addProgressView];
    }
}

- (void)addProgressView {
    
    self.line.height = 2;
    self.line.y = self.height - self.line.height;
}

- (void)click:(GLPageButton *)btn {
    
    if (self.selectedBtn == btn) return;
    if ([self.delegate respondsToSelector:@selector(pageControlViewDidSelectWithIndex:)]) {
        [self.delegate pageControlViewDidSelectWithIndex:btn.tag];
    }
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    [self moveToCenterWithIndex:(int)btn.tag];
    
    if (self.style == GLPageControlFontChangeStyle) {
        
        [btn selectedItemWithoutAnimation];
        [self.selectedBtn deselectedItemWithoutAnimation];
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            self.line.x = btn.x;
            self.line.width = btn.width;
        }];
    }
    self.selectedBtn = btn;
}

- (void)SelectedBtnMoveToCenterWithIndex:(int)index WithRate:(CGFloat)Pagerate {
    
    int page  = (int)(Pagerate +0.5);
    CGFloat rate = Pagerate - index;
    int count = (int)self.btnCount;
    
    if (Pagerate < 0) return;
    if (index == count-1 || index >= count -1) return;
    if ( rate == 0)    return;
    
    self.selectedBtn.selected = NO;
    GLPageButton *currentbtn = self.pageControlScrollView.subviews[index];
    GLPageButton *nextBtn = self.pageControlScrollView.subviews[index + 1];
    
    if (self.style == GLPageControlFontChangeStyle) {
        
        [currentbtn ChangSelectedColorAndScalWithRate:rate];
        [nextBtn ChangSelectedColorAndScalWithRate:1-rate];
    }else {
        CGFloat margin;
        if (Pagerate < count-2){
            if (self.pageControlScrollView.contentSize.width < self.width){
                margin = (ScreenWidth - self.sumWidth)/(self.btnCount + 1);
                self.line.x =  currentbtn.x + (currentbtn.width + margin + BtnGap)* rate;
            }else{
                margin = BtnGap;
                self.line.x =  currentbtn.x + (currentbtn.width + margin)* rate;
            }
            
            self.line.width =  currentbtn.width + (nextBtn.width - currentbtn.width)*rate;
            [currentbtn ChangSelectedColorWithRate:rate];
            [nextBtn ChangSelectedColorWithRate:1-rate];
        }
    }
    self.selectedBtn = self.pageControlScrollView.subviews[page];
    self.selectedBtn.selected = YES;
    
}

/**
 *  使选中的按钮位移到scollview的中间
 */
- (void)moveToCenterWithIndex:(NSInteger)index
{
    GLPageButton *btn = self.pageControlScrollView.subviews[index];
    CGRect newframe = [btn convertRect:self.bounds toView:nil];
    CGFloat distance = newframe.origin.x  - self.centerX;
    CGFloat contenoffsetX = self.pageControlScrollView.contentOffset.x;
    int count = (int)self.btnCount;
    if (index > count-1) return;
    
    if ( self.pageControlScrollView.contentOffset.x + btn.x   > self.centerX ) {
        
        [self.pageControlScrollView setContentOffset:CGPointMake(contenoffsetX + distance + btn.width, 0) animated:YES];
    }else{
        
        [self.pageControlScrollView setContentOffset:CGPointMake(0 , 0) animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x <= 0) {
        
        [scrollView setContentOffset:CGPointMake(0 , 0)];
    }else if(scrollView.contentOffset.x + self.width >= scrollView.contentSize.width){
        
        [scrollView setContentOffset:CGPointMake(scrollView.contentSize.width - self.width, 0)];
    }
}

- (void)selectWithIndex:(int)index
{
    self.selectedBtn = self.pageControlScrollView.subviews[index];
    
    NSInteger count = self.btnCount;
    
    GLPageButton *leftbtn=nil;
    GLPageButton *rightbtn=nil;

    if (index == 0) {
        rightbtn = self.pageControlScrollView.subviews[index+1];
    }else if (index == count - 1){
        leftbtn = self.pageControlScrollView.subviews[index-1];
    }else{
        leftbtn = self.pageControlScrollView.subviews[index-1];
        rightbtn = self.pageControlScrollView.subviews[index+1];
    }
    leftbtn.selected = NO;
    rightbtn.selected = NO;

    self.selectedBtn.selected = YES;
    
    self.line.x = self.selectedBtn.x;
    self.line.width = self.selectedBtn.width;
    
    [self moveToCenterWithIndex:(int)self.selectedBtn.tag];
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc]init];
        GLPageButton *btn = [self.pageControlScrollView.subviews firstObject];
        _line.x = btn.x ;
        _line.width = btn.width;
        _line.backgroundColor = kSelectedColor;
        [self.pageControlScrollView addSubview:_line];
    }
    return _line;
}

- (void)dealloc
{

}

@end
