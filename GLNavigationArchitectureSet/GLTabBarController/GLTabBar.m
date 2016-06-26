//
//  GLTabBar.m
//  GLNavigationArchitectureSet
//
//  Created by ZK on 16/6/24.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "GLTabBar.h"

@interface GLTabBar ()


@property (nonatomic, assign) CGFloat tabBarItemWidth;

@property (nonatomic, copy) NSArray *tabBarButtonArray;

@end


@implementation GLTabBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)setTabBarSpecialButtonWith:(nonnull GLSpecialButton *)specialButton
{
    _specialButton = specialButton;
    [self addSubview:self.specialButton];

    [_specialButton resetaddTarget];
    

}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    if(!self.specialButton){
        return;
    }
    
    CGFloat barWidth = self.bounds.size.width;
    CGFloat barHeight = self.bounds.size.height;
    
    //    NSArray *sortedSubviews = [self sortedSubviews];
    self.tabBarButtonArray = [self tabBarButtonFromTabBarSubviews:self.subviews];
    //    [self setupSwappableImageViewDefaultOffset:self.tabBarButtonArray[0]];
    
    
    CGFloat itemWidth = (barWidth - CGRectGetWidth(self.specialButton.bounds)) / self.tabBarButtonArray.count;
    CGFloat specialButtonWidth = self.specialButton.bounds.size.width;

    NSUInteger specialButtonIndex = [self.specialButton indexOfPlusButtonInTabBar];
    self.specialButton.center = CGPointMake(itemWidth*specialButtonIndex + specialButtonWidth/2.0,
                                            [self specialButtonCenterY]);


    
    [self.tabBarButtonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[UIView class]]){
            UIView* tabBarButton = (UIView*)obj;
            //调整UITabBarItem的位置
            CGFloat tabBarButtonX;
            if (idx >= specialButtonIndex) {
                tabBarButtonX = idx * itemWidth + specialButtonWidth;
            } else {
                tabBarButtonX = idx * itemWidth;
            }
            //仅修改childView的x和宽度,yh值不变
            tabBarButton.frame = CGRectMake(tabBarButtonX,
                                         CGRectGetMinY(tabBarButton.frame),
                                         itemWidth,
                                         CGRectGetHeight(tabBarButton.frame)
                                         );
        }
    }];
    
    //bring the plus button to top
    [self bringSubviewToFront:self.specialButton];
}


- (CGFloat)specialButtonCenterY
{
    CGFloat centerY = 0.0f;
    CGFloat barHeight = self.bounds.size.height;

    CGFloat heightDifference = self.specialButton.frame.size.height - barHeight;
    if (heightDifference < 0.0) {
        centerY = barHeight / 2.0;
    } else {
        centerY = barHeight / 2.0 - heightDifference * 0.5;
    }
    return centerY;
}

- (NSArray *)tabBarButtonFromTabBarSubviews:(NSArray *)tabBarSubviews
{
    NSMutableArray* tabBarButtonMutableArray = [NSMutableArray array];
    [tabBarSubviews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtonMutableArray addObject:obj];
        }
    }];
    if ([self.specialButton plusChildViewController]) {
        [tabBarButtonMutableArray removeObjectAtIndex:[self.specialButton indexOfPlusButtonInTabBar]];
    }
    return tabBarButtonMutableArray;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL canNotResponseEvent = self.hidden || (self.alpha <= 0.01f) || (self.userInteractionEnabled == NO);
    if (canNotResponseEvent) {
        return nil;
    }
    
    CGRect plusButtonFrame = self.specialButton.frame;
    BOOL isInPlusButtonFrame = CGRectContainsPoint(plusButtonFrame, point);
    if (isInPlusButtonFrame) {
        return self.specialButton;
    }
    
    return [super hitTest:point withEvent:event];
}



@end
