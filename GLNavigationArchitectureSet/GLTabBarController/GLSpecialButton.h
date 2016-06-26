//
//  GLSpecialButton.h
//  GLNavigationArchitectureSet
//
//  Created by ZK on 16/6/24.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLSpecialButtonProtocol.h"

@interface GLSpecialButton : UIButton<GLSpecialButtonProtocol>

-(void)resetaddTarget;

@end
