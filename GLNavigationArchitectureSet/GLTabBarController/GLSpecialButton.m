//
//  GLSpecialButton.m
//  GLNavigationArchitectureSet
//
//  Created by ZK on 16/6/24.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "GLSpecialButton.h"

@implementation GLSpecialButton

-(instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

-(void)resetaddTarget
{
    if([self respondsToSelector:@selector(plusChildViewController)]){
        
        NSArray<NSString *> *selectorNamesArray = [self actionsForTarget:self forControlEvent:UIControlEventTouchUpInside];
        [selectorNamesArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SEL selector =  NSSelectorFromString(obj);
            [self removeTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
        }];
        
        [self addTarget:self action:@selector(plusChildViewControllerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

-(void)plusChildViewControllerButtonClicked:(GLSpecialButton*)button
{
    
    
    button.selected=YES;
    UIViewController* vc= [self GetiewController];
    if([vc isKindOfClass:[UITabBarController class]]){
        UITabBarController* tabvc=(UITabBarController*)vc;
        tabvc.selectedIndex=[button indexOfPlusButtonInTabBar];
    }
}

- (UIViewController *)GetiewController {
    Class vcc = [UIViewController class];
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: vcc])
            return (UIViewController *)responder;
    return nil;
}



//over
- (NSUInteger)indexOfPlusButtonInTabBar
{
    return 2;
}

- (UIViewController *)plusChildViewController
{
    return nil;
}

@end
