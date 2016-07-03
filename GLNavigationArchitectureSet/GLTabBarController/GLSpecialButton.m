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

-(void)resetTargetAction
{
    if([self respondsToSelector:@selector(specialViewController)]){
        
        NSArray<NSString *> *selectorNamesArray = [self actionsForTarget:self forControlEvent:UIControlEventTouchUpInside];
        [selectorNamesArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SEL selector =  NSSelectorFromString(obj);
            [self removeTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
        }];
        
        [self addTarget:self action:@selector(specialViewControllerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

-(void)specialViewControllerButtonClicked:(GLSpecialButton*)button
{
    button.selected=YES;
    
    UIViewController* vc= [self getViewController];
    
    if([vc isKindOfClass:[UITabBarController class]]){
        UITabBarController* tabvc=(UITabBarController*)vc;
        tabvc.selectedIndex=[button indexOfSpecialButton];
    }
}

- (UIViewController *)getViewController {
    Class vcc = [UIViewController class];
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: vcc])
            return (UIViewController *)responder;
    return nil;
}

//over
- (NSUInteger)indexOfSpecialButton
{
    return 2;
}


@end
