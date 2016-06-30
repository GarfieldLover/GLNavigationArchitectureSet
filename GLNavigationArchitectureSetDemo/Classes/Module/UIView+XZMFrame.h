
//  Created by 谢忠敏 on 15/6/28.
//  Copyright (c) 2015年 谢忠敏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XZMFrame)
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;
@property (nonatomic, assign)CGFloat centerX;
@property (nonatomic, assign)CGFloat centerY;
@property (nonatomic, assign)CGSize size;

- (BOOL)isShowingOnKeyWindow;

+ (instancetype)viewFromXib;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com