/*================================
||    @param name   ADView       ||
||    @param author muyingbo     ||
||    @param date   2016-03-28   ||
=================================*/

#import <UIKit/UIKit.h>

@interface HRADView : UIView

@property (nonatomic, strong) UIPageControl *pageControl;

- (instancetype)initWithFrame:(CGRect)frame imageNames:(NSArray <NSString *>*)names;

- (instancetype)initWithFrame:(CGRect)frame URLStrings:(NSArray<NSString *> *)urls;

- (void)openTimerWithAnimationDuration:(NSTimeInterval)animationDuration;

- (void)imageViewTap:(void(^)(NSInteger imageViewTagValue))block;


@end
