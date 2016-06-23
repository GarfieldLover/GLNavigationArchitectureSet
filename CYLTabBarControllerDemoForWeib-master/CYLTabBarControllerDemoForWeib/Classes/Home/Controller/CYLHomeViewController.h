//
//  CYLHomeViewController.h
//  CYLTabBarController演示Demo
//
//  Created by微博@iOS程序犭袁 （http://weibo.com/luohanchenyilong/）on 15-10-20.
//  Copyright (c) 2014年 https://github.com/ChenYilong . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYLHomeViewController : UITableViewController

@end

@import UIKit;
@implementation UIBarButtonItem (UIBarButtonItemAddition)
+ (UIBarButtonItem *)itemImage:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action;
{
    // 创建一个UIButton
    UIButton *btn = [[UIButton alloc] init];
    // 设置默认状态图片
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    // 设置高亮状态图片
    [btn setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    // 设置按钮大小
    //仅修改btn的size,xy值不变
    btn.frame = CGRectMake(CGRectGetMinX(btn.frame),
                           CGRectGetMinY(btn.frame),
                           btn.currentImage.size.width,
                           btn.currentImage.size.height
                           );
    // 添加按钮监听事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 生成UIBarButtonItem
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end

@implementation UIView (UIViewAddition)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect bounds = self.bounds;
    bounds.size.width = width;
    self.bounds = bounds;
}

- (CGFloat)width
{
    return self.bounds.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect bounds = self.bounds;
    bounds.size.height = height;
    self.bounds = bounds;
}

- (CGFloat)height
{
    return self.bounds.size.height;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

@end