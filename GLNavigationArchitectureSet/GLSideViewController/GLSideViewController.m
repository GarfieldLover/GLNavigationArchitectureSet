//
//  GLSideViewController.m
//  GLNavigationArchitectureSet
//
//  Created by zhangke on 16/7/3.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "GLSideViewController.h"
#import "UIViewController+GLSide.h"

@interface GLSideViewController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, assign) BOOL visible;
@property (nonatomic, assign) BOOL leftMenuVisible;
@property (nonatomic, assign) BOOL rightMenuVisible;
@property (nonatomic, assign) CGPoint originalPoint;
@property (nonatomic, strong) UIButton *contentButton;
@property (nonatomic, strong) UIView *SideViewContainer;
@property (nonatomic, strong) UIView *contentViewContainer;
@property (nonatomic, assign) BOOL didNotifyDelegate;

@property (nonatomic, assign) NSUInteger panMinimumOpenThreshold;
@property (nonatomic, assign)  BOOL interactivePopGestureRecognizerEnabled;
@property (nonatomic, assign)  BOOL fadeSideView;
@property (nonatomic, assign)  BOOL scaleContentView;
@property (nonatomic, assign)  BOOL scaleBackgroundImageView;
@property (nonatomic, assign)  BOOL scaleSideView;
@property (nonatomic, assign)  BOOL contentViewShadowEnabled;
@property (nonatomic, strong)  UIColor *contentViewShadowColor;
@property (nonatomic, assign)  CGSize contentViewShadowOffset;
@property (nonatomic, assign)  CGFloat contentViewShadowOpacity;
@property (nonatomic, assign)  CGFloat contentViewShadowRadius;
@property (nonatomic, assign)  CGFloat contentViewScaleValue;
@property (nonatomic, assign)  CGFloat contentViewInPortraitOffsetCenterX;
@property (nonatomic, assign) CGAffineTransform SideViewControllerTransformation;

@end

@implementation GLSideViewController

#pragma mark -
#pragma mark Instance lifecycle

- (id)init
{
    self = [super init];
    if (self) {
        [self initParam];
    }
    return self;
}

- (void)initParam
{
    _SideViewContainer = [[UIView alloc] init];
    _contentViewContainer = [[UIView alloc] init];
    
    _animationDuration = 0.25f;
    _interactivePopGestureRecognizerEnabled = YES;
    
    _SideViewControllerTransformation = CGAffineTransformMakeScale(1.5f, 1.5f);
    
    _scaleContentView = YES;
    _scaleBackgroundImageView = YES;
    _scaleSideView = YES;
    _fadeSideView = YES;
    
    _panMinimumOpenThreshold = 60.0;
    
    _contentViewShadowEnabled = YES;
    _contentViewShadowColor = [UIColor blackColor];
    _contentViewShadowOffset = CGSizeZero;
    _contentViewShadowOpacity = 0.4f;
    _contentViewShadowRadius = 8.0f;
    _contentViewInPortraitOffsetCenterX  = 0.f;
    _contentViewScaleValue = 0.7f;
}

#pragma mark -
#pragma mark Public methods

- (id)initWithContentViewController:(UIViewController *)contentViewController leftSideViewController:(UIViewController *)leftSideViewController rightSideViewController:(UIViewController *)rightSideViewController
{
    self = [self init];
    if (self) {
        _contentViewController = contentViewController;
        _leftSideViewController = leftSideViewController;
        _rightSideViewController = rightSideViewController;
    }
    return self;
}

- (void)presentLeftSideViewController
{
    [self presentSideViewContainerWithSideViewController:self.leftSideViewController];
    [self showLeftSideViewController];
}

- (void)presentRightSideViewController
{
    [self presentSideViewContainerWithSideViewController:self.rightSideViewController];
    [self showRightSideViewController];
}

- (void)hideSideViewController
{
    [self hideSideViewControllerAnimated:YES];
}

#pragma mark View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.contentButton = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectNull];
        [button addTarget:self action:@selector(hideSideViewController) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    self.backgroundImageView = ({
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        imageView.image = self.backgroundImage;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageView;
    });
    if (self.scaleBackgroundImageView){
        self.backgroundImageView.transform = CGAffineTransformMakeScale(1.7f, 1.7f);
    }
    [self.view addSubview:self.backgroundImageView];
    
    self.SideViewContainer.frame = self.view.bounds;
    self.SideViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.SideViewContainer.alpha = !self.fadeSideView ?: 0;
    [self.view addSubview:self.SideViewContainer];
    
    self.contentViewContainer.frame = self.view.bounds;
    self.contentViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.contentViewContainer];
    [self updateContentViewShadow];
    
    if(self.contentViewController){
        [self addChildViewController:self.contentViewController];
        self.contentViewController.view.frame = self.view.bounds;
        [self.contentViewContainer addSubview:self.contentViewController.view];
        [self.contentViewController didMoveToParentViewController:self];
    }
    
    if (self.leftSideViewController) {
        [self addChildViewController:self.leftSideViewController];
        self.leftSideViewController.view.frame = self.view.bounds;
        self.leftSideViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.SideViewContainer addSubview:self.leftSideViewController.view];
        [self.leftSideViewController didMoveToParentViewController:self];
    }
    
    if (self.rightSideViewController) {
        [self addChildViewController:self.rightSideViewController];
        self.rightSideViewController.view.frame = self.view.bounds;
        self.rightSideViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.SideViewContainer addSubview:self.rightSideViewController.view];
        [self.rightSideViewController didMoveToParentViewController:self];
    }
    
    self.view.multipleTouchEnabled = NO;
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    panGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:panGestureRecognizer];
}

#pragma mark -
#pragma mark Private methods

- (void)presentSideViewContainerWithSideViewController:(UIViewController *)SideViewController
{
    if (self.scaleSideView) {
        self.SideViewContainer.transform = CGAffineTransformIdentity;
        self.SideViewContainer.frame = self.view.bounds;
        self.SideViewContainer.alpha = !self.fadeSideView ?: 0;
        self.SideViewContainer.transform = self.SideViewControllerTransformation;
    }
    
    if (self.scaleBackgroundImageView) {
        self.backgroundImageView.transform = CGAffineTransformIdentity;
        self.backgroundImageView.frame = self.view.bounds;
        self.backgroundImageView.transform = CGAffineTransformMakeScale(1.7f, 1.7f);
    }
    
    if ([self.delegate respondsToSelector:@selector(sideMenu:willShowSideViewController:)]) {
        [self.delegate sideMenu:self willShowSideViewController:SideViewController];
    }
}

- (void)showLeftSideViewController
{
    if (!self.leftSideViewController) {
        return;
    }
    self.leftSideViewController.view.hidden = NO;
    self.rightSideViewController.view.hidden = YES;
    [self.view.window endEditing:YES];
    
    [self addContentButton];
    [self updateContentViewShadow];
    [self resetContentViewScale];
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        if (self.scaleContentView) {
            self.contentViewContainer.transform = CGAffineTransformMakeScale(self.contentViewScaleValue, self.contentViewScaleValue);
        } else {
            self.contentViewContainer.transform = CGAffineTransformIdentity;
        }
        
        self.contentViewContainer.center = CGPointMake(self.contentViewInPortraitOffsetCenterX + CGRectGetWidth(self.view.frame), self.contentViewContainer.center.y);
        
        self.SideViewContainer.alpha = !self.fadeSideView ?: 1.0f;
        self.SideViewContainer.transform = CGAffineTransformIdentity;
        self.backgroundImageView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        if (!self.visible && [self.delegate respondsToSelector:@selector(sideMenu:didShowSideViewController:)]) {
            [self.delegate sideMenu:self didShowSideViewController:self.leftSideViewController];
        }
        
        self.visible = YES;
        self.leftMenuVisible = YES;
    }];
}

- (void)showRightSideViewController
{
    if (!self.rightSideViewController) {
        return;
    }
    self.leftSideViewController.view.hidden = YES;
    self.rightSideViewController.view.hidden = NO;
    [self.view.window endEditing:YES];
    
    [self addContentButton];
    [self updateContentViewShadow];
    [self resetContentViewScale];
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        if (self.scaleContentView) {
            self.contentViewContainer.transform = CGAffineTransformMakeScale(self.contentViewScaleValue, self.contentViewScaleValue);
        } else {
            self.contentViewContainer.transform = CGAffineTransformIdentity;
        }
        self.contentViewContainer.center = CGPointMake(-self.contentViewInPortraitOffsetCenterX, self.contentViewContainer.center.y);
        NSLog(@"-----%f",self.contentViewContainer.center.x);
        
        self.SideViewContainer.alpha = !self.fadeSideView ?: 1.0f;
        self.SideViewContainer.transform = CGAffineTransformIdentity;
        self.backgroundImageView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        if (!self.rightMenuVisible && [self.delegate respondsToSelector:@selector(sideMenu:didShowSideViewController:)]) {
            [self.delegate sideMenu:self didShowSideViewController:self.rightSideViewController];
        }
        
        self.visible = !(self.contentViewContainer.frame.size.width == self.view.bounds.size.width && self.contentViewContainer.frame.size.height == self.view.bounds.size.height && self.contentViewContainer.frame.origin.x == 0 && self.contentViewContainer.frame.origin.y == 0);
        self.rightMenuVisible = self.visible;
    }];
}

- (void)hideSideViewControllerAnimated:(BOOL)animated
{
    BOOL rightMenuVisible = self.rightMenuVisible;
    if ([self.delegate respondsToSelector:@selector(sideMenu:willHideSideViewController:)]) {
        [self.delegate sideMenu:self willHideSideViewController:rightMenuVisible ? self.rightSideViewController : self.leftSideViewController];
    }
    
    self.visible = NO;
    self.leftMenuVisible = NO;
    self.rightMenuVisible = NO;
    [self.contentButton removeFromSuperview];
    
    __typeof (self) __weak weakSelf = self;
    void (^animationBlock)(void) = ^{
        __typeof (weakSelf) __strong strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        strongSelf.contentViewContainer.transform = CGAffineTransformIdentity;
        strongSelf.contentViewContainer.frame = strongSelf.view.bounds;
        if (strongSelf.scaleSideView) {
            strongSelf.SideViewContainer.transform = strongSelf.SideViewControllerTransformation;
        }
        strongSelf.SideViewContainer.alpha = !self.fadeSideView ?: 0;
        
        if (strongSelf.scaleBackgroundImageView) {
            strongSelf.backgroundImageView.transform = CGAffineTransformMakeScale(1.7f, 1.7f);
        }
    };
    void (^completionBlock)(void) = ^{
        __typeof (weakSelf) __strong strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        if (!strongSelf.visible && [strongSelf.delegate respondsToSelector:@selector(sideMenu:didHideSideViewController:)]) {
            [strongSelf.delegate sideMenu:strongSelf didHideSideViewController:rightMenuVisible ? strongSelf.rightSideViewController : strongSelf.leftSideViewController];
        }
    };
    
    if (animated) {
        [UIView animateWithDuration:self.animationDuration animations:^{
            animationBlock();
        } completion:^(BOOL finished) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            completionBlock();
        }];
    } else {
        animationBlock();
        completionBlock();
    }
}

- (void)addContentButton
{
    if (self.contentButton.superview)
        return;
    
    self.contentButton.autoresizingMask = UIViewAutoresizingNone;
    self.contentButton.frame = self.contentViewContainer.bounds;
    self.contentButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.contentViewContainer addSubview:self.contentButton];
}

- (void)updateContentViewShadow
{
    if (self.contentViewShadowEnabled) {
        CALayer *layer = self.contentViewContainer.layer;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:layer.bounds];
        layer.shadowPath = path.CGPath;
        layer.shadowColor = self.contentViewShadowColor.CGColor;
        layer.shadowOffset = self.contentViewShadowOffset;
        layer.shadowOpacity = self.contentViewShadowOpacity;
        layer.shadowRadius = self.contentViewShadowRadius;
    }
}

- (void)resetContentViewScale
{
    /**
     *  CGAffineTransformMake(a,b,c,d,tx,ty)
     ad缩放bc旋转tx,ty位移，基础的2D矩阵
     */
    CGAffineTransform t = self.contentViewContainer.transform;
    CGFloat scale = sqrt(t.a * t.a + t.c * t.c);
    CGRect frame = self.contentViewContainer.frame;
    self.contentViewContainer.transform = CGAffineTransformIdentity;
    self.contentViewContainer.transform = CGAffineTransformMakeScale(scale, scale);
    self.contentViewContainer.frame = frame;
}

#pragma mark -
#pragma mark UIGestureRecognizer Delegate (Private)

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if([self.contentViewController isKindOfClass:[UITabBarController class]]){
        UITabBarController* tabBarController= (UITabBarController*)self.contentViewController;
        if([tabBarController.selectedViewController isKindOfClass:[UINavigationController class]]){
            UINavigationController* nav = tabBarController.selectedViewController;
            if(nav.viewControllers.count>1){
                return NO;
            }
        }
    }else if ([self.contentViewController isKindOfClass:[UINavigationController class]]){
        UINavigationController* nav = (UINavigationController*)self.contentViewController;
        if(nav.viewControllers.count>1){
            return NO;
        }
    }
    
    return YES;
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer translationInView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self updateContentViewShadow];
        
        self.originalPoint = CGPointMake(self.contentViewContainer.center.x - CGRectGetWidth(self.contentViewContainer.bounds) / 2.0,
                                         self.contentViewContainer.center.y - CGRectGetHeight(self.contentViewContainer.bounds) / 2.0);
        
        self.SideViewContainer.transform = CGAffineTransformIdentity;
        self.SideViewContainer.frame = self.view.bounds;

        if (self.scaleBackgroundImageView) {
            self.backgroundImageView.transform = CGAffineTransformIdentity;
            self.backgroundImageView.frame = self.view.bounds;
        }
        
        [self addContentButton];
        
        [self.view.window endEditing:YES];
        self.didNotifyDelegate = NO;
        
    }else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGFloat delta = 0;
        if (self.visible) {
            delta = self.originalPoint.x != 0 ? (point.x + self.originalPoint.x) / self.originalPoint.x : 0;
        } else {
            delta = point.x / self.view.frame.size.width;
        }
        delta = MIN(fabs(delta), 1.6);
        
        
        CGFloat contentViewScale = self.scaleContentView ? 1 - ((1 - self.contentViewScaleValue) * delta) : 1;
        CGFloat backgroundViewScale = 1.7f - (0.7f * delta);
        CGFloat SideViewScale = 1.5f - (0.5f * delta);
        
        contentViewScale = MAX(contentViewScale, self.contentViewScaleValue);
        backgroundViewScale = MAX(backgroundViewScale, 1.0);
        SideViewScale = MAX(SideViewScale, 1.0);
        
        self.SideViewContainer.alpha = !self.fadeSideView ?: delta;
        
        if (self.scaleBackgroundImageView) {
            if (backgroundViewScale < 1) {
                self.backgroundImageView.transform = CGAffineTransformIdentity;
            }else{
                self.backgroundImageView.transform = CGAffineTransformMakeScale(backgroundViewScale, backgroundViewScale);
            }
        }
        
        if (self.scaleSideView) {
            self.SideViewContainer.transform = CGAffineTransformMakeScale(SideViewScale, SideViewScale);
        }
        
        if (contentViewScale > 1) {
            CGFloat oppositeScale = (1 - (contentViewScale - 1));
            self.contentViewContainer.transform = CGAffineTransformMakeScale(oppositeScale, oppositeScale);
            self.contentViewContainer.transform = CGAffineTransformTranslate(self.contentViewContainer.transform, point.x, 0);
        } else if(contentViewScale > self.contentViewScaleValue){
            self.contentViewContainer.transform = CGAffineTransformMakeScale(contentViewScale, contentViewScale);
            self.contentViewContainer.transform = CGAffineTransformTranslate(self.contentViewContainer.transform, point.x, 0);
        }
        
        if (self.visible) {
            if (self.contentViewContainer.frame.origin.x > self.contentViewContainer.frame.size.width / 2.0)
                point.x = MIN(0.0, point.x);
            
            if (self.contentViewContainer.frame.origin.x < -(self.contentViewContainer.frame.size.width / 2.0))
                point.x = MAX(0.0, point.x);
        }
        
        // Limit size
        //
        if (point.x < 0) {
            point.x = MAX(point.x, -[UIScreen mainScreen].bounds.size.height);
        } else {
            point.x = MIN(point.x, [UIScreen mainScreen].bounds.size.height);
        }
        [recognizer setTranslation:point inView:self.view];
        
        if (!self.didNotifyDelegate) {
            if (point.x > 0) {
                if (!self.visible && [self.delegate respondsToSelector:@selector(sideMenu:willShowSideViewController:)]) {
                    [self.delegate sideMenu:self willShowSideViewController:self.leftSideViewController];
                }
            }
            if (point.x < 0) {
                if (!self.visible && [self.delegate respondsToSelector:@selector(sideMenu:willShowSideViewController:)]) {
                    [self.delegate sideMenu:self willShowSideViewController:self.rightSideViewController];
                }
            }
            self.didNotifyDelegate = YES;
        }
        
        self.leftSideViewController.view.hidden = self.contentViewContainer.frame.origin.x < 0;
        self.rightSideViewController.view.hidden = self.contentViewContainer.frame.origin.x > 0;
        
        if (!self.leftSideViewController && self.contentViewContainer.frame.origin.x > 0) {
            self.contentViewContainer.transform = CGAffineTransformIdentity;
            self.contentViewContainer.frame = self.view.bounds;
            self.visible = NO;
            self.leftMenuVisible = NO;
        } else  if (!self.rightSideViewController && self.contentViewContainer.frame.origin.x < 0) {
            self.contentViewContainer.transform = CGAffineTransformIdentity;
            self.contentViewContainer.frame = self.view.bounds;
            self.visible = NO;
            self.rightMenuVisible = NO;
        }
        
    }else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        self.didNotifyDelegate = NO;
        if (self.panMinimumOpenThreshold > 0 && ((self.contentViewContainer.frame.origin.x < 0 && self.contentViewContainer.frame.origin.x > -((NSInteger)self.panMinimumOpenThreshold)) ||
            (self.contentViewContainer.frame.origin.x > 0 && self.contentViewContainer.frame.origin.x < self.panMinimumOpenThreshold))
            ){
            [self hideSideViewController];
            
        } else if (self.contentViewContainer.frame.origin.x == 0) {
            [self hideSideViewControllerAnimated:NO];
            
        }else {
            if ([recognizer velocityInView:self.view].x > 0) {
                if (self.contentViewContainer.frame.origin.x < 0) {
                    [self hideSideViewController];
                } else {
                    if (self.leftSideViewController) {
                        [self showLeftSideViewController];
                    }
                }
            } else {
                if (self.contentViewContainer.frame.origin.x < 80) {
                    if (self.rightSideViewController) {
                        [self showRightSideViewController];
                    }
                } else {
                    [self hideSideViewController];
                }
            }
        }
    }
}

#pragma mark -
#pragma mark Setters

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    if (self.backgroundImageView)
        self.backgroundImageView.image = backgroundImage;
}

@end
