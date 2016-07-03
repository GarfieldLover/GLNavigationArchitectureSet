//
//  GLPageControlView.h
//  GLNavigationArchitectureSet
//
//  Created by zhangke on 16/7/1.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Style
 */
typedef NS_ENUM(NSUInteger, GLPageControlStyle) {
    /**
     *  字体缩放
     */
    GLPageControlFontChangeStyle,
    /**
     *  带下划线
     */
    GlPageControlMarkChangeStyle,
};


@protocol GLPageControlViewDelegate <NSObject>

- (void)pageControlViewDidSelectWithIndex:(NSInteger)index;

@end


@interface GLPageControlView : UIView

@property (nonatomic, weak) id<GLPageControlViewDelegate> delegate;

@property (nonatomic, assign) GLPageControlStyle style;

- (instancetype)initWithPageControlStyle:(GLPageControlStyle)style AndTitles:(NSArray *)titles;

- (void)SelectedBtnMoveToCenterWithIndex:(int)index WithRate:(CGFloat)rate;

- (void)selectWithIndex:(int)index;

- (void)moveToCenterWithIndex:(NSInteger)index;

@end


