//
//  GLNavigationController.m
//  GLNavigationArchitectureSet
//
//  Created by zhangke on 16/7/1.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "GLNavigationController.h"

#define TOP_VIEW  [UIApplication sharedApplication].delegate.window.rootViewController.view
#define ViewWith  [UIApplication sharedApplication].delegate.window.bounds.size.width

static CGFloat animateDuration = 0.25f;

@interface GLNavigationController ()<UIGestureRecognizerDelegate>{
    CGPoint startTouch;
    UIView *blackMask;
}

@property (nonatomic,strong) UIView *backgroundView;

@property (nonatomic,strong) UIImageView *lastScreenShotView;

@property (nonatomic,strong) NSMutableDictionary *screenShotsDic;

@property (nonatomic,strong) UIPanGestureRecognizer* systemPopStyleGestureRecognizer;

@property (nonatomic,strong) UIPanGestureRecognizer* screenShotPopStyleGestureRecognizer;

@end


@implementation GLNavigationController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.popStyle = SystemPopStyle;
        
        self.canDragBack = YES;
        
        self.screenShotsDic=[NSMutableDictionary dictionary];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.enabled = NO;

    if(self.popStyle==ScreenShotPopStyle){

        self.view.layer.shadowColor = [[UIColor blackColor]CGColor];
        self.view.layer.shadowOffset = CGSizeMake(5, 5);
        self.view.layer.shadowRadius = 5;
        self.view.layer.shadowOpacity = 1;
        
        
        UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                                                                    action:@selector(paningGestureReceive:)];
        recognizer.delegate = self;
        [recognizer delaysTouchesBegan];
        [self.view addGestureRecognizer:recognizer];
        
        self.screenShotPopStyleGestureRecognizer=recognizer;
        
    }else{
        UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]init];
        recognizer.delegate = self;
        [recognizer delaysTouchesBegan];
        
        self.systemPopStyleGestureRecognizer=recognizer;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.screenShotsDic = nil;
    
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
}

// override the push method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.popStyle == SystemPopStyle){
        
        if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.systemPopStyleGestureRecognizer]) {
            
            [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.systemPopStyleGestureRecognizer];
            
            NSArray *internalTargets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
            id internalTarget = [internalTargets.firstObject valueForKey:@"target"];
            
            NSString* handleNavigation = @"handleNavigation";
            NSString* Transition = @"Transition:";
            NSString* handleNavigationTransitionString =[NSString stringWithFormat:@"%@%@",handleNavigation,Transition];
            
            SEL internalAction = NSSelectorFromString(handleNavigationTransitionString);
            [self.systemPopStyleGestureRecognizer addTarget:internalTarget action:internalAction];

        }
        
    }else{
        UIImage *capturedImage = [self.screenShotsDic objectForKey:self.topViewController.description];
        if(!capturedImage){
            capturedImage = [self capture];
            
            if (capturedImage && self.topViewController.description) {
                [self.screenShotsDic setObject:capturedImage forKey:self.topViewController.description];
            }
        }
    }
    
    if (![self.viewControllers containsObject:viewController]) {
        [super pushViewController:viewController animated:animated];
    }
}

// override the pop method
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if(self.popStyle == ScreenShotPopStyle){
        UIViewController* screenShotViewController=[self.viewControllers objectAtIndex:self.viewControllers.count-2];
        if(screenShotViewController && [self.screenShotsDic objectForKey:screenShotViewController.description]){
            [self.screenShotsDic removeObjectForKey:screenShotViewController.description];
        }
    }
    
    return [super popViewControllerAnimated:animated];
}

- (BOOL)shouldAutorotate {
    return NO;
}

#pragma mark - Utility Methods

// get the current view screen shot
- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(TOP_VIEW.bounds.size, TOP_VIEW.opaque, 0.0);
    [TOP_VIEW.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

// set lastScreenShotView 's position and alpha when paning
- (void)moveViewWithX:(float)x
{
    x = x>ViewWith ? ViewWith:x;
    x = x<0 ? 0:x;
    
    CGRect frame = TOP_VIEW.frame;
    frame.origin.x = x;
    TOP_VIEW.frame = frame;
    
    float alpha = 0.4 - (x/(ViewWith/0.4));
    
    blackMask.alpha = alpha;
    
    CGRect rect=self.lastScreenShotView.frame;
    rect.origin.x= (-self.backgroundView.frame.size.width/3) *((ViewWith-x)/ViewWith);
    self.lastScreenShotView.frame=rect;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (self.viewControllers.count <= 1)
        return NO;
    
    if (!self.canDragBack) {
        return NO;
    }
    
    if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    /**
     *  返回某些不支持View,比如横向滑动View
     */
    /*
    if([touch.view isKindOfClass:NSClassFromString(@"HorizontalTableViewCell")]
       || [touch.view.superview isKindOfClass:NSClassFromString(@"HorizontalTableViewCell")]
       || [touch.view isKindOfClass:NSClassFromString(@"PlayerControlPanel")]
       || [touch.view.superview isKindOfClass:NSClassFromString(@"PlayerControlPanel")]
       || [touch.view.superview.superview isKindOfClass:NSClassFromString(@"PlayerControlPanel")]
       ){
        return NO;
    }
    */
    
    return YES;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        
        // Find the current scrolling velocity in that view, in the Y direction.
        CGFloat yVelocity = [(UIPanGestureRecognizer*)otherGestureRecognizer velocityInView:otherGestureRecognizer.view].y;
        
        // Return YES iff the user is not actively scrolling up.
        return fabs(yVelocity) <= 0.25;
        
    }
    return YES;
}

#pragma mark - Gesture Recognizer

- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
{
    // If the viewControllers has only one vc or disable the interaction, then return.
    if (self.viewControllers.count <= 1 || !self.canDragBack) return;
    
    // we get the touch position by the window's coordinate
    CGPoint touchPoint = [recoginzer locationInView:[UIApplication sharedApplication].delegate.window];
    
    // begin paning, show the backgroundView(last screenshot),if not exist, create it.
    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        
        startTouch = touchPoint;

        self.backgroundView.hidden = NO;
        
        if (self.lastScreenShotView){
            [self.lastScreenShotView removeFromSuperview];
            self.lastScreenShotView=nil;
        }
        
        [self.backgroundView insertSubview:self.lastScreenShotView belowSubview:blackMask];
        
        //End paning, always check that if it should move right or move left automatically
    }else if (recoginzer.state == UIGestureRecognizerStateEnded){
        
        if (touchPoint.x - startTouch.x > ViewWith*0.2){
            [UIView animateWithDuration:animateDuration animations:^{
                [self moveViewWithX:ViewWith];
            } completion:^(BOOL finished) {
                
                [self popViewControllerAnimated:NO];
                CGRect frame = TOP_VIEW.frame;
                frame.origin.x = 0;
                TOP_VIEW.frame = frame;
                
                self.backgroundView.hidden = YES;
                
            }];
        }else{
            [UIView animateWithDuration:animateDuration animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                self.backgroundView.hidden = YES;
            }];
        }
        
        // cancal panning, alway move to left side automatically
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        
        [UIView animateWithDuration:animateDuration animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            self.backgroundView.hidden = YES;
        }];
        
    }else if (recoginzer.state == UIGestureRecognizerStateChanged){
        [self moveViewWithX:touchPoint.x - startTouch.x];
    }
    
}

-(UIView *)backgroundView
{
    if (!_backgroundView){
        CGRect frame = TOP_VIEW.frame;
        
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
        [TOP_VIEW.superview insertSubview:_backgroundView belowSubview:TOP_VIEW];
        
        blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
        blackMask.backgroundColor = [UIColor blackColor];
        [_backgroundView addSubview:blackMask];
    }
    return _backgroundView;
}

-(UIImageView *)lastScreenShotView
{
    if (!_lastScreenShotView){
        UIImage *lastScreenShot = nil;
        UIViewController* screenShotViewController=[self.viewControllers objectAtIndex:self.viewControllers.count-2];
        if(screenShotViewController){
            lastScreenShot =  [self.screenShotsDic objectForKey:screenShotViewController.description];
        }
        
        _lastScreenShotView = [[UIImageView alloc]initWithImage:lastScreenShot];
        CGRect rect=_lastScreenShotView.frame;
        rect.origin.x=-self.backgroundView.frame.size.width/3;
        _lastScreenShotView.frame=rect;
    }
    return _lastScreenShotView;
}


@end
