//
//  GLNavigationController.m
//  GLNavigationArchitectureSet
//
//  Created by zhangke on 16/7/1.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "GLNavigationController.h"

#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]
#define TOP_VIEW  [UIApplication sharedApplication].delegate.window.rootViewController.view
#define ViewWith  KEY_WINDOW.bounds.size.width

static CGFloat animateDuration = 0.25f;

@interface GLNavigationController ()<UIGestureRecognizerDelegate>
{
    CGPoint startTouch;
    
    UIImageView *lastScreenShotView;
    UIView *blackMask;
}

@property (nonatomic,strong) UIView *backgroundView;

@property (nonatomic,assign) BOOL isMoving;

@property (nonatomic,strong) UIPanGestureRecognizer *recognizer;

@property (nonatomic,strong) NSMutableDictionary *screenShotsDic;

@end

@implementation GLNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.canDragBack = YES;
        
        self.screenShotsDic=[NSMutableDictionary dictionary];
        
    }
    return self;
}

- (void)dealloc
{
    self.screenShotsDic = nil;
    
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // draw a shadow for navigation view to differ the layers obviously.
    // using this way to draw shadow will lead to the low performace
    // the best alternative way is making a shadow image.
    //
    self.view.layer.shadowColor = [[UIColor blackColor]CGColor];
    self.view.layer.shadowOffset = CGSizeMake(5, 5);
    self.view.layer.shadowRadius = 5;
    self.view.layer.shadowOpacity = 1;
    
//    UIImageView *shadowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"leftside_shadow_bg"]];
//    shadowImageView.frame = CGRectMake(-10, 0, 10, TOP_VIEW.frame.size.height);
//    [TOP_VIEW addSubview:shadowImageView];
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                                                                action:@selector(paningGestureReceive:)];
    recognizer.delegate = self;
    [recognizer delaysTouchesBegan];
    [self.view addGestureRecognizer:recognizer];
    
    self.recognizer=recognizer;
    
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// override the push method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    UIImage *capturedImage = [self.screenShotsDic objectForKey:self.topViewController.description];
    if(!capturedImage){
        capturedImage = [self capture];
        
        if (capturedImage && self.topViewController.description) {
            [self.screenShotsDic setObject:capturedImage forKey:self.topViewController.description];
        }
    }
    
    [super pushViewController:viewController animated:animated];
}

// override the pop method
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController* screenShotViewController=[self.viewControllers objectAtIndex:self.viewControllers.count-2];
    if(screenShotViewController && [self.screenShotsDic objectForKey:screenShotViewController.description]){
        [self.screenShotsDic removeObjectForKey:screenShotViewController.description];
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
    
    CGRect rect=lastScreenShotView.frame;
    rect.origin.x= (-self.backgroundView.frame.size.width/3) *((ViewWith-x)/ViewWith);
    lastScreenShotView.frame=rect;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (self.viewControllers.count <= 1 || !self.canDragBack) return NO;
    
    if([touch.view isKindOfClass:NSClassFromString(@"HorizontalTableViewCell")]
       || [touch.view.superview isKindOfClass:NSClassFromString(@"HorizontalTableViewCell")]
       || [touch.view isKindOfClass:NSClassFromString(@"PlayerControlPanel")]
       || [touch.view.superview isKindOfClass:NSClassFromString(@"PlayerControlPanel")]
       || [touch.view.superview.superview isKindOfClass:NSClassFromString(@"PlayerControlPanel")]
       ){
        return NO;
    }
    if([touch.view isKindOfClass:NSClassFromString(@"UIImageView")] && touch.view.frame.origin.y==20.0 &&  touch.view.frame.size.height==41.0){
        return NO;
    }
    
    return YES;
}

/*
 -(BOOL)shouldReceiveTouch:(UIView *)touchView
 {
 if([touchView isKindOfClass:[UIWindow class]]){
 return YES;
 }
 if([touchView isKindOfClass:NSClassFromString(@"HorizontalTableViewCell")]
 || [touchView isKindOfClass:NSClassFromString(@"PlayerControlPanel")]){
 return NO;
 }
 
 [self shouldReceiveTouch:touchView.superview];
 
 return YES;
 }
 */

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
    CGPoint touchPoint = [recoginzer locationInView:KEY_WINDOW];
    
    // begin paning, show the backgroundView(last screenshot),if not exist, create it.
    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        
        _isMoving = YES;
        startTouch = touchPoint;
        
        if (!self.backgroundView)
        {
            CGRect frame = TOP_VIEW.frame;
            
            self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            [TOP_VIEW.superview insertSubview:self.backgroundView belowSubview:TOP_VIEW];
            
            blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            blackMask.backgroundColor = [UIColor blackColor];
            [self.backgroundView addSubview:blackMask];
        }
        
        self.backgroundView.hidden = NO;
        
        if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
        
        UIImage *lastScreenShot = nil;
        UIViewController* screenShotViewController=[self.viewControllers objectAtIndex:self.viewControllers.count-2];
        if(screenShotViewController){
            lastScreenShot =  [self.screenShotsDic objectForKey:screenShotViewController.description];
        }
        
        lastScreenShotView = [[UIImageView alloc]initWithImage:lastScreenShot];
        CGRect rect=lastScreenShotView.frame;
        rect.origin.x=-self.backgroundView.frame.size.width/3;
        lastScreenShotView.frame=rect;
        [self.backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];
        
        //End paning, always check that if it should move right or move left automatically
    }else if (recoginzer.state == UIGestureRecognizerStateEnded){
        
        if (touchPoint.x - startTouch.x > ViewWith*0.2)
        {
            [UIView animateWithDuration:animateDuration animations:^{
                [self moveViewWithX:ViewWith];
            } completion:^(BOOL finished) {
                
                [self popViewControllerAnimated:NO];
                CGRect frame = TOP_VIEW.frame;
                frame.origin.x = 0;
                TOP_VIEW.frame = frame;
                
                _isMoving = NO;
                self.backgroundView.hidden = YES;
                
            }];
        }
        else
        {
            [UIView animateWithDuration:animateDuration animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                _isMoving = NO;
                self.backgroundView.hidden = YES;
            }];
            
        }
        return;
        
        // cancal panning, alway move to left side automatically
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        
        [UIView animateWithDuration:animateDuration animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;
            self.backgroundView.hidden = YES;
        }];
        
        return;
    }
    
    // it keeps move with touch
    if (_isMoving) {
        [self moveViewWithX:touchPoint.x - startTouch.x];
    }
}

@end
