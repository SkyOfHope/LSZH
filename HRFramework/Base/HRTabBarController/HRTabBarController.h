/*======================================
||    @param name   TabBarController   ||
||    @param author muyingbo           ||
||    @param date   2016-04-03         ||
=======================================*/

#import <UIKit/UIKit.h>

@interface HRTabBarController : UITabBarController

/**
 *  init
 *
 *  @param controllerNames
 *
 *  @return instancetype
 */
- (instancetype)initWithViewControllers:(NSArray <NSString *>*)controllerNames;


/**
 *  TabBarImage
 *
 *  @param imageNames
 *  @param selectedImage
 */
- (void)setupTabBarImage:(NSArray <NSString *>*)imageNames selectedImage:(NSArray <NSString *>*)selectedImage;

/**
 *  TabBarTitles
 *
 *  @param titles
 */
- (void)setupTabBarTitles:(NSArray <NSString *>*)titles;


/**
 *  ItemTitleColor
 *
 *  @param selectedColor
 *  @param defaultColor
 */
- (void)setupItemTitleSelectedColor:(UIColor *)selectedColor defaultColor:(UIColor *)defaultColor;


/**
 *  adjust image position
 *
 *  @param edge
 */
- (void)setupImageEdge:(UIEdgeInsets)edge;

/**
 *  TabBarBackgroundColor
 *
 *  @param color
 */
- (void)setupTabBarBackgroundColor:(UIColor *)color;


/*~!
 *  brif    setupTabBarTopLineColor
 *  author  muyingbo
 *  time    2016-05-18
 */
- (void)setupTabBarTopLineColor:(UIColor *)color;


@end
