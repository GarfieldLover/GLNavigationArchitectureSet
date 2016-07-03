

#import <UIKit/UIKit.h>
@class NoLimitScorllview;

@protocol NoLimitScorllviewDelegate <NSObject>

@optional
- (void)NoLimitScorllview:(NoLimitScorllview *)scorllview ImageDidSelectedWithIndex:(int)index;

@end

@interface NoLimitScorllview : UIView

@property (nonatomic,weak)id<NoLimitScorllviewDelegate> delegate;
- (instancetype)initWithShowImages:(NSArray *)images AndTitals:(NSArray *)titals;

@end
