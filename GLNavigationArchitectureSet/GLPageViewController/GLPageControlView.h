//
//  GLPageControlView.h
//  GLNavigationArchitectureSet
//
//  Created by zhangke on 16/7/1.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GLPageControlStyle) {
    GLPageControlFontChangeStyle,     // 字体缩放
    GlPageControlMarkChangeStyle,     // 带下划线 (颜色会变化)
};

@class GLPageControlView;

@protocol GLPageControlViewDelegate <NSObject>

- (void)pageControlViewDidSelectWithIndex:(NSUInteger)index;

@end


@interface GLPageControlView : UIView

@property (nonatomic, weak) id<GLPageControlViewDelegate> delegate;

@property (nonatomic, assign) GLPageControlStyle style;

- (instancetype)initWithMneuViewStyle:(GLPageControlStyle)style AndTitles:(NSArray *)titles;

- (void)SelectedBtnMoveToCenterWithIndex:(int)index WithRate:(CGFloat)rate;

- (void)selectWithIndex:(int)index AndOtherIndex:(int)tag;

@end
