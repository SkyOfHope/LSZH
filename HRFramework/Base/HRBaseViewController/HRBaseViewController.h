/*=======================================
||    @param name   BaseViewController  ||
||    @param author muyingbo            ||
||    @param date   2016-04-03          ||
========================================*/

#import <UIKit/UIKit.h>


@interface HRBaseViewController : UIViewController

#pragma mark - NavigationTitle

/**
 *  NavigationTitle
 *
 *  @param title
 *  @param titleColor  
 *  @param size(system)
 */
- (void)navigationTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)size;

/**
 *  NavigationTitleView
 *
 *  @param view  CustomView
 *  @param block tap event block
 */
- (void)navigationTitleView:(UIView *)view click:(void(^)())block;


#pragma mark - NavigationBarButton
/**
 *  LeftBarButtonItems(imageView)
 *
 *  @param imageNames   imageName array
 *  @param block        button click (left->right tag=1,2,3...)
 */
- (void)navigationLeftBarButtonImageNames:(NSArray <NSString *> *)imageNames click:(void(^)(NSInteger buttonTag))block;

/**
 *  LeftBarButtonItems(title)
 *
 *  @param titles  title
 *  @param block   button click (left->right tag=1,2,3...)
 */
- (void)navigationLeftBarButtonTitles:(NSArray <NSString *> *)titles click:(void(^)(NSInteger buttonTag))block;

/**
 *  RightBarButtonItems(imageView)
 *
 *  @param imageNames imageNames array
 *  @param block      button click (right->left tag=1,2,3...)
 */
- (void)navigationRightBarButtonImageNames:(NSArray <NSString *> *)imageNames click:(void(^)(NSInteger buttonTag))block;
/**
 *  RightBarButtonItems(title)
 *
 *  @param titles title array
 *  @param block  button click (right->left tag=1,2,3...)
 */
- (void)navigationRightBarButtonTitles:(NSArray <NSString *> *)titles click:(void(^)(NSInteger buttonTag))block;



#pragma mark - Indicator
/**
 *  show indicator
 */
- (void)showIndicator;

/**
 *  hidden indicator
 */
- (void)hiddenIndicator;




@end
