//
//  GLTabBarController.m
//  GLNavigationArchitectureSet
//
//  Created by ZK on 16/6/22.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "GLTabBarController.h"


NSString *const GLTabBarItemTitle = @"GLTabBarItemTitle";
NSString *const GLTabBarItemImage = @"GLTabBarItemImage";
NSString *const GLTabBarItemSelectedImage = @"GLTabBarItemSelectedImage";
NSString *const GLTabBarItemTitleTextAttributes = @"GLTabBarItemTitleTextAttributes";
NSString *const GLTabBarItemSelectedTitleTextAttributes = @"GLTabBarItemSelectedTitleTextAttributes";



@interface GLTabBarController ()

@property (nonatomic, strong) NSArray *tabBarItemsAttributes;

@end


@implementation GLTabBarController


+ (nullable instancetype)tabBarControllerWithViewControllers:(nonnull NSArray<__kindof UIViewController *> *)viewControllers tabBarItemsAttributes:(nonnull NSArray<NSDictionary *> *)tabBarItemsAttributes
{
    GLTabBarController *tabBarController = [[GLTabBarController alloc] initWithViewControllers:viewControllers tabBarItemsAttributes:tabBarItemsAttributes];
    return tabBarController;
}

- (nullable instancetype)initWithViewControllers:(nonnull NSArray<__kindof UIViewController *> *)viewControllers tabBarItemsAttributes:(nonnull NSArray<NSDictionary *> *)tabBarItemsAttributes
{
    if(![GLTabBarController checkWithViewControllers:viewControllers tabBarItemsAttributes:tabBarItemsAttributes]){
        return nil;
    }
    
    if (self = [super init]) {
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

-(void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers
{
    [viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *title = nil;
        NSString *normalImageName = nil;
        NSString *selectedImageName = nil;
        NSDictionary *selectedImageNamexx = nil;

        NSDictionary *selectedImageNameff = nil;

//        if (viewController != CYLPlusChildViewController) {
            title = self.tabBarItemsAttributes[idx][GLTabBarItemTitle];
            normalImageName = self.tabBarItemsAttributes[idx][GLTabBarItemImage];
            selectedImageName = self.tabBarItemsAttributes[idx][GLTabBarItemSelectedImage];
        selectedImageNamexx=self.tabBarItemsAttributes[idx][GLTabBarItemTitleTextAttributes];
        selectedImageNameff=self.tabBarItemsAttributes[idx][GLTabBarItemSelectedTitleTextAttributes];

//        } else {
//            idx--;
//        }
        
        [self addOneChildViewController:obj
                              WithTitle:title
                        normalImageName:normalImageName
                      selectedImageName:selectedImageName
         selectedImageName:selectedImageNamexx selectedImageName:selectedImageNameff];
        
//        [viewController cyl_setTabBarController:self];
//        idx++;
    }];
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
//        viewController.tabBarItem.imageInsets = self.imageInsets;
//    }
//    if (self.shouldCustomizeTitlePositionAdjustment) {
//        viewController.tabBarItem.titlePositionAdjustment = self.titlePositionAdjustment;
//    }
    [self addChildViewController:viewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
