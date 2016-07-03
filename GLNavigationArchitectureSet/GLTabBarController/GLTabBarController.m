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



@interface GLTabBarController ()

@property (nonnull, nonatomic, readwrite, copy) NSArray<NSDictionary *> *tabBarItemsAttributes;

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
    if ([[self specialButton] specialViewController]) {
        NSMutableArray *viewControllersWithPlusButton = [NSMutableArray arrayWithArray:viewControllers];
        [viewControllersWithPlusButton insertObject:[[self specialButton] specialViewController] atIndex:[[self specialButton] indexOfSpecialButton]];
        viewControllers = [viewControllersWithPlusButton copy];
    }
    
    NSInteger index = 0;
    for (UIViewController *viewController in viewControllers) {
        NSString *title = nil;
        NSString *normalImageName = nil;
        NSString *selectedImageName = nil;
        NSDictionary *titleText = nil;
        NSDictionary *selectedTitleText = nil;
        
        if (viewController != [[self specialButton] specialViewController]) {
            title = self.tabBarItemsAttributes[index][GLTabBarItemTitle];
            normalImageName = self.tabBarItemsAttributes[index][GLTabBarItemImage];
            selectedImageName = self.tabBarItemsAttributes[index][GLTabBarItemSelectedImage];
            titleText = self.tabBarItemsAttributes[index][GLTabBarItemTitleTextAttributes];
            selectedTitleText = self.tabBarItemsAttributes[index][GLTabBarItemSelectedTitleTextAttributes];
        } else {
            index--;
        }
        
        [self addOneChildViewController:viewController
                              WithTitle:title
                        normalImageName:normalImageName
                      selectedImageName:selectedImageName
                      titleText:titleText
                      selectedTitleText:selectedTitleText];
        index++;
    }
}

- (void)addOneChildViewController:(UIViewController *)viewController
                        WithTitle:(NSString *)title
                  normalImageName:(NSString *)normalImageName
                selectedImageName:(NSString *)selectedImageName
                titleText:(NSDictionary *)selectedImageNamexx
                selectedTitleText:(NSDictionary *)selectedImageNameff

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

    [self addChildViewController:viewController];
}

-(void)setSelectedViewController:(__kindof UIViewController *)selectedViewController
{
    [super setSelectedViewController:selectedViewController];
    
    if(selectedViewController!=[[self specialButton] specialViewController]){
        [[self specialButton] setSelected:NO];
    }else{
        [[self specialButton] setSelected:YES];
    }
    
    NSUInteger index= [self.viewControllers indexOfObject:selectedViewController];
    
    [(GLTabBar*)self.tabBar setShadeIndex:index];
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

- (void)setShadeItemBackgroundImage:(UIImage * _Nonnull)backgroundImage
{
    [(GLTabBar*)self.tabBar setShadeItemBackgroundImage:backgroundImage];
}

- (void)setShadeItemBackgroundColor:(UIColor * _Nonnull)coloer
{
    [(GLTabBar*)self.tabBar setShadeItemBackgroundColor:coloer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
