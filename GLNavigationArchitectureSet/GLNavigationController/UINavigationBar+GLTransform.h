//
//  UINavigationBar+GLTransform.h
//  GLNavigationArchitectureSet
//
//  Created by zhangke on 16/7/3.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (GLTransform)

- (void)setBackgroundColor:(UIColor *)backgroundColor;

- (void)setElementsAlpha:(CGFloat)alpha;

- (void)setTranslationY:(CGFloat)translationY;

- (void)reset;

@end
