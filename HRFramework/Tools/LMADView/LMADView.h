
/**
 *  @param name   轮播图
 *  @param author muyingbo
 *  @param date   2016-03－28
 */

#import <UIKit/UIKit.h>

/**
 *  block 重定义
 *
 */
typedef void(^ImageViewTapBlockType)(NSInteger imageViewTag);

@interface LMADView : UIView

/**
 *  UIPageControl
 */
@property (nonatomic, strong) UIPageControl *pageControl;

/**
 *  初始化(本地图片)
 *
 *  @param frame 轮播图frame（图片大小）
 *  @param names 图片名称数组
 *
 *  @return instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame withImageNames: (NSArray <NSString *>*)names withtitles:(NSArray<NSString *> *)titles;

/**
 *  初始化（网络图片）
 *
 *  @param frame 轮播图frame（图片大小）
 *  @param urls  url数组
 *
 *  @return instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame withURLStrings:(NSArray<NSString *> *)urls withTitles:(NSArray<NSString *> *)titles;

/**
 *  开启计时器（默认关闭）
 *
 *  @param animationDuration 轮播时间
 */
- (void)openTimerWithAnimationDuration:(NSTimeInterval)animationDuration;
/**
 *  图片点击方法
 *
 *  @param block 返回第几张图片（1.2.3...）
 */
- (void)imageViewTap:(ImageViewTapBlockType)block;

@end
