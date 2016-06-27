//
//  GLTabBar.m
//  GLNavigationArchitectureSet
//
//  Created by ZK on 16/6/24.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "GLTabBar.h"

@interface GLTabBar ()<UITabBarDelegate>


@property (nonatomic, assign) CGFloat tabBarItemWidth;

@property (nonatomic, copy) NSArray *tabBarButtonArray;

@property (nonatomic, strong) UIImageView * shadeItemImage;;

@end


@implementation GLTabBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate=self;
    }
    return self;
}


- (void)setTabBarSpecialButtonWith:(nullable GLSpecialButton *)specialButton
{
    if(!specialButton || _specialButton){
        return;
    }
    
    _specialButton = specialButton;
    [self addSubview:self.specialButton];

    if([_specialButton respondsToSelector:@selector(plusChildViewController)]){
        UIViewController* vc=[_specialButton plusChildViewController];
        if(vc){
            [_specialButton resetaddTarget];

        }
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    CGFloat barWidth = self.bounds.size.width;
    CGFloat barHeight = self.bounds.size.height;
    

    
    //    NSArray *sortedSubviews = [self sortedSubviews];
    self.tabBarButtonArray = [self tabBarButtonFromTabBarSubviews:self.subviews];


    
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
    
    //    [self setupSwappableImageViewDefaultOffset:self.tabBarButtonArray[0]];
    [self setupSwappableImageViewDefaultOffset];
    
    if(self.shadeItemImage){
        [self insertSubview:self.shadeItemImage belowSubview:self.tabBarButtonArray[0]];

        CGRect rect=self.shadeItemImage.frame;
        rect.size=CGSizeMake(itemWidth, barHeight);
        self.shadeItemImage.frame=rect;
        
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item // called when a new view is selected by the user (but not programatically
{

}

-(void)setupSwappableImageViewDefaultOffset
{
    UIButton* tabBarButton = self.tabBarButtonArray[0];
    __block BOOL shouldCustomizeImageView = YES;
    __block CGFloat swappableImageViewDefaultOffset = 0.f;
    CGFloat tabBarHeight = self.frame.size.height;
    [tabBarButton.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UITabBarButtonLabel")]) {
            shouldCustomizeImageView = NO;
        }
        CGFloat swappableImageViewHeight = obj.frame.size.height;
        BOOL ishaveSwappableImageView = [obj isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")];
        if (ishaveSwappableImageView) {
            swappableImageViewDefaultOffset = (tabBarHeight - swappableImageViewHeight) * 0.5 * 0.5 + (49-tabBarHeight)*0.5*0.5;
        }else{
            shouldCustomizeImageView = NO;
        }
    }];
    if(shouldCustomizeImageView){
        NSArray<UITabBarItem *> *tabBarItems = self.items;
        [tabBarItems enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIEdgeInsets imageInset = UIEdgeInsetsMake(swappableImageViewDefaultOffset, 0, -swappableImageViewDefaultOffset, 0);
            obj.imageInsets = imageInset;
        }];
        
        self.specialButton.center=CGPointMake(self.specialButton.center.x, CGRectGetHeight(self.bounds)/2);
    }
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

- (void)xzm_setShadeItemBackgroundImage:(UIImage *)backgroundImage
{
    if(!self.shadeItemImage){
        self.shadeItemImage=[[UIImageView alloc] init];
    }
    [self.shadeItemImage setImage:backgroundImage];
}

- (void)xzm_setShadeItemBackgroundColor:(UIColor *)coloer
{
    if(!self.shadeItemImage){
        self.shadeItemImage=[[UIImageView alloc] init];

    }
    [self.shadeItemImage setBackgroundColor:nil];
    [self.shadeItemImage setBackgroundColor:coloer];
}




@end
