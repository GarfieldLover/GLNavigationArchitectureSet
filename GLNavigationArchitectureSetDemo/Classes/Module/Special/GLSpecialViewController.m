//
//  GLSpecialViewController.m
//  GLNavigationArchitectureSet
//
//  Created by zhangke on 16/7/3.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "GLSpecialViewController.h"
#import "POP.h"
#import "UIView+GLPage.h"

#define XZMScreenW [UIScreen mainScreen].bounds.size.width
#define XZMScreenH [UIScreen mainScreen].bounds.size.height

static NSInteger XZMSpringFactor = 6;
static CGFloat XZMSpringDelay = 0.05;


@interface GLSpecialViewController ()

@property (nonatomic, weak)UIImageView *imageView;

@end


@implementation GLSpecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.userInteractionEnabled = NO;
    
    /** 添加buttom */
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    NSUInteger cols = 3;
    CGFloat btnW = 60;
    CGFloat btnH = btnW + 30;
    CGFloat beginMargin = 20;
    CGFloat middleMargin = (XZMScreenW - 2 * beginMargin - cols *btnW)/ (cols - 1);
    CGFloat btnStartY = (XZMScreenH - 2 * btnH) * 0.5;
    
    for (int i = 0; i < images.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        btn.imageEdgeInsets=UIEdgeInsetsMake(-30, 30, 0, 0);
        btn.titleEdgeInsets=UIEdgeInsetsMake(30, -30, 0, 0);
        
//        btn.imageView.x = 0;
//        btn.imageView.y = 0;
//        btn.imageView.width = btn.width;
//        btn.imageView.height = btn.imageView.width;
//        
//        btn.titleLabel.x = 0;
//        btn.titleLabel.y = btn.imageView.height;
//        btn.titleLabel.width = btn.width;
//        btn.titleLabel.height = btn.height - btn.imageView.height;
        
        
        NSInteger col = i % cols;
        NSInteger row = i / cols;
        
        CGFloat btnX = col * (middleMargin +btnW) + beginMargin;
        CGFloat btnY = row * btnH + btnStartY;
        
        [self.view addSubview:btn];
        
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(chickBtnDown:) forControlEvents:UIControlEventTouchDown];
        
        [btn addTarget:self action:@selector(chickBtnUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.tag = i;
        
        CGFloat benginBtnY = btnStartY - XZMScreenH;
        
        /** 添加动画 */
        POPSpringAnimation *anima = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        
        anima.fromValue = [NSValue valueWithCGRect:CGRectMake(btnX, benginBtnY, btnW, btnH)];
        
        anima.toValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnY, btnW, btnH)];
        
        anima.springSpeed = XZMSpringFactor;
        
        anima.springBounciness = XZMSpringDelay;
        
        anima.beginTime = CACurrentMediaTime() + i * XZMSpringDelay;
        
        [btn pop_addAnimation:anima forKey:nil];
        
        [anima setCompletionBlock:^(POPAnimation *anima, BOOL finish) {
            
            
        }];
        

        
    }
    
    /** 添加sloganView指示条 */
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    
    sloganView.y = -XZMScreenW;
    
    [self.view addSubview:sloganView];
    
    CGFloat centerX = XZMScreenW * 0.5;
    
    CGFloat centerEndY = XZMScreenH * 0.15;
    
    CGFloat centerBenginY = centerEndY - XZMScreenH;
    
    /** 添加动画 */
    POPSpringAnimation *anima = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anima.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBenginY)];
    anima.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anima.springBounciness = XZMSpringDelay;
    anima.beginTime = CACurrentMediaTime() + XZMSpringDelay * images.count;
    
    anima.springSpeed = XZMSpringFactor;
    
    [sloganView pop_addAnimation:anima forKey:nil];
    
    [anima setCompletionBlock:^(POPAnimation *anima, BOOL finish) {
        
        /** 动画完成后 */
        self.view.userInteractionEnabled = YES;
        
        
        UIButton* cancel=[UIButton buttonWithType:UIButtonTypeCustom];
        [cancel setImage:[UIImage imageNamed:@"shareButtonCancel"] forState:UIControlStateNormal];
        [cancel setImage:[UIImage imageNamed:@"shareButtonCancelClick"] forState:UIControlStateHighlighted];
        cancel.frame=CGRectMake(100, self.view.frame.size.height-60, self.view.frame.size.width-100*2, 30);
        [self.view addSubview:cancel];
        cancel.alpha=0.0;
        
        [cancel addTarget:self action:@selector(chickBtnUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        anim.toValue = @(1.0);
        
        [cancel pop_addAnimation:anim forKey:@"alpha"];
        
    }];
}

- (void)cancelWithCompletionBlock:(void (^)())block
{
    self.view.userInteractionEnabled = NO;
    
    
    int index = 0;
    for (int i = index; i < self.view.subviews.count; i++) {
        UIView *view = self.view.subviews[i];
        
        POPSpringAnimation *anima = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        
        anima.springBounciness = XZMSpringDelay;
        
        anima.springSpeed = XZMSpringFactor;
        
        anima.beginTime = CACurrentMediaTime() + (i - index) * XZMSpringDelay;
        
        CGFloat endCenterY = view.centerY + XZMScreenH;
        
        anima.toValue = [NSValue valueWithCGPoint:CGPointMake(view.centerX, endCenterY)];
        
        [view pop_addAnimation:anima forKey:nil];
        
        if (i == self.view.subviews.count - 1) { // 最后一个动画完成时
            
            [anima setCompletionBlock:^(POPAnimation *anima, BOOL finish) {
                
                [self dismissViewControllerAnimated:NO completion:nil];
                
                block();
            }];
        }
        
        
    }
}

- (void)chickBtnDown:(UIButton *)btn
{
    POPBasicAnimation *anima = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    anima.toValue = [NSValue valueWithCGSize:CGSizeMake(1.1, 1.1)];
    
    [btn pop_addAnimation:anima forKey:nil];
    
}


- (void)chickBtnUpInside:(UIButton *)btn
{
    POPBasicAnimation *anima = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    
    anima.toValue = [NSValue valueWithCGSize:CGSizeMake(1.3, 1.3)];
    
    [btn pop_addAnimation:anima forKey:nil];
    
    [anima setCompletionBlock:^(POPAnimation *anima, BOOL finish) {
        
        
        POPBasicAnimation *anima2 = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        
        anima2.toValue = @(0);
        
        [btn pop_addAnimation:anima2 forKey:nil];
        
        [anima2 setCompletionBlock:^(POPAnimation *anima, BOOL finish) {
            
            [self cancelWithCompletionBlock:^{
                // 切换对应控制器
            }];
        }];
        
    }];
    
    
    
    
}


@end