//
//  GLTabBarController.m
//  GLNavigationArchitectureSet
//
//  Created by ZK on 16/6/22.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "GLTabBarController.h"
#import "GLTabBar.h"

NSString *const GLTabBarItemTitle = @"GLTabBarItemTitle";
NSString *const GLTabBarItemImage = @"GLTabBarItemImage";
NSString *const GLTabBarItemSelectedImage = @"GLTabBarItemSelectedImage";
NSString *const GLTabBarItemTitleTextAttributes = @"GLTabBarItemTitleTextAttributes";
NSString *const GLTabBarItemSelectedTitleTextAttributes = @"GLTabBarItemSelectedTitleTextAttributes";



@interface GLTabBarController ()<UITabBarControllerDelegate>


@end


@implementation GLTabBarController

@dynamic viewControllers;

+ (nullable instancetype)tabBarControllerWithViewControllers:(nonnull NSArray<__kindof UIViewController *> *)viewControllers tabBarItemsAttributes:(nonnull NSArray<NSDictionary *> *)tabBarItemsAttributes SpecialButtonWith:(nullable GLSpecialButton *)specialButton
{
    GLTabBarController *tabBarController = [[GLTabBarController alloc] initWithViewControllers:viewControllers tabBarItemsAttributes:tabBarItemsAttributes SpecialButtonWith:specialButton];
    return tabBarController;
}

- (nullable instancetype)initWithViewControllers:(nonnull NSArray<__kindof UIViewController *> *)viewControllers tabBarItemsAttributes:(nonnull NSArray<NSDictionary *> *)tabBarItemsAttributes SpecialButtonWith:(nullable GLSpecialButton *)specialButton
{
    if(![GLTabBarController checkWithViewControllers:viewControllers tabBarItemsAttributes:tabBarItemsAttributes]){
        return nil;
    }
    
    if (self = [super init]) {
        
        GLTabBar* tabBar = [[GLTabBar alloc] init];
        [self setValue:tabBar forKey:@"tabBar"];
        [tabBar setTabBarSpecialButtonWith:specialButton];
        
        self.tabBarItemsAttributes = tabBarItemsAttributes;
        self.viewControllers = viewControllers;

    }
    return self;
}

+(BOOL)checkWithViewControllers:(nonnull NSArray<__kindof UIViewController *> *)viewControllers tabBarItemsAttributes:(nonnull NSArray<NSDictionary *> *)tabBarItemsAttributes
{
    if(!viewControllers || !tabBarItemsAttributes || viewControllers.count != tabBarItemsAttributes.count){
        [NSException raise:@"GLTabBarController" format:@"请检查viewControllers和tabBarItemsAttributes是否为空，并数量相同"];
        return NO;
    }
    return YES;
}

-(GLSpecialButton*)specialButton
{
    if([self.tabBar isKindOfClass:[GLTabBar class]]){
        GLTabBar* tab=(GLTabBar*)self.tabBar;
        return tab.specialButton;
    }
    return nil;
}

-(void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers
{
    if ([[self specialButton] plusChildViewController]) {
        NSMutableArray *viewControllersWithPlusButton = [NSMutableArray arrayWithArray:viewControllers];
        [viewControllersWithPlusButton insertObject:[[self specialButton] plusChildViewController] atIndex:[[self specialButton] indexOfPlusButtonInTabBar]];
        viewControllers = [viewControllersWithPlusButton copy];
    }
    
    NSInteger index = 0;
    for (UIViewController *viewController in viewControllers) {
        NSString *title = nil;
        NSString *normalImageName = nil;
        NSString *selectedImageName = nil;
        NSDictionary *selectedImageNamexx = nil;
        
        NSDictionary *selectedImageNameff = nil;
        
        if (viewController != [[self specialButton] plusChildViewController]) {
            title = self.tabBarItemsAttributes[index][GLTabBarItemTitle];
            normalImageName = self.tabBarItemsAttributes[index][GLTabBarItemImage];
            selectedImageName = self.tabBarItemsAttributes[index][GLTabBarItemSelectedImage];
            selectedImageNamexx=self.tabBarItemsAttributes[index][GLTabBarItemTitleTextAttributes];
            selectedImageNameff=self.tabBarItemsAttributes[index][GLTabBarItemSelectedTitleTextAttributes];
        } else {
            index--;
        }
        
        [self addOneChildViewController:viewController
                              WithTitle:title
                        normalImageName:normalImageName
                      selectedImageName:selectedImageName
                      selectedImageName:selectedImageNamexx selectedImageName:selectedImageNameff];
        
        //        [viewController cyl_setTabBarController:self];
                index++;
    }
}

- (void)addOneChildViewController:(UIViewController *)viewController
                        WithTitle:(NSString *)title
                  normalImageName:(NSString *)normalImageName
                selectedImageName:(NSString *)selectedImageName
                selectedImageName:(NSDictionary *)selectedImageNamexx
                selectedImageName:(NSDictionary *)selectedImageNameff

{
    viewController.tabBarItem.title = title;
    if (normalImageName) {
        UIImage *normalImage = [UIImage imageNamed:normalImageName];
        normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.tabBarItem.image = normalImage;
    }
    if (selectedImageName) {
        UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.tabBarItem.selectedImage = selectedImage;
        [viewController.tabBarItem setTitleTextAttributes:selectedImageNamexx forState:UIControlStateNormal];
        [viewController.tabBarItem setTitleTextAttributes:selectedImageNameff forState:UIControlStateSelected];

    }
//    if (self.shouldCustomizeImageInsets) {
        viewController.tabBarItem.imageInsets = UIEdgeInsetsZero;
//    }
//    if (self.shouldCustomizeTitlePositionAdjustment) {
//        viewController.tabBarItem.titlePositionAdjustment = self.titlePositionAdjustment;
//    }
    [self addChildViewController:viewController];
}

-(void)setSelectedViewController:(__kindof UIViewController *)selectedViewController
{
    [super setSelectedViewController:selectedViewController];
    
    if(selectedViewController!=[[self specialButton] plusChildViewController]){
        [[self specialButton] setSelected:NO];
    }else{
        [[self specialButton] setSelected:YES];
    }
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController*)viewController {
    
    
//    NSUInteger selectedIndex = tabBarController.selectedIndex;
//    UIButton *plusButton = CYLExternPlusButton;
//    if (CYLPlusChildViewController) {
//        if ((selectedIndex == CYLPlusButtonIndex) && (viewController != CYLPlusChildViewController)) {
//            plusButton.selected = NO;
//        }
//    }
    return YES;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    

}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    if (!self.tabBarHeight) {
        return;
    }
    self.tabBar.frame = ({
        CGRect frame = self.tabBar.frame;
        CGFloat tabBarHeight = self.tabBarHeight;
        frame.size.height = tabBarHeight;
        frame.origin.y = self.view.frame.size.height - tabBarHeight;
        frame;
    });
}

/**
 *  设置高亮背景图片
 *
 *  @param backgroundImage 高亮背景图片
 */
- (void)xzm_setShadeItemBackgroundImage:(UIImage * _Nonnull)backgroundImage
{
    [(GLTabBar*)self.tabBar xzm_setShadeItemBackgroundImage:backgroundImage];
}

/**
 *  设置高亮背景颜色
 *
 *  @param coloer 高亮背景颜色
 */
- (void)xzm_setShadeItemBackgroundColor:(UIColor * _Nonnull)coloer
{
    [(GLTabBar*)self.tabBar xzm_setShadeItemBackgroundColor:coloer];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
