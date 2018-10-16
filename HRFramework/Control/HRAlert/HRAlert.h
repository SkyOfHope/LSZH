/*=================================
 ||    @param name   ADView       ||
 ||    @param author muyingbo     ||
 ||    @param date   2016-03-28   ||
 =================================*/

#import <Foundation/Foundation.h>

@interface HRAlert : NSObject

/**
 *  alert
 *
 *  @param title
 *  @param message
 *  @param actionTitles
 *  @param block
 */
+ (void)showTitle:(NSString *)title message:(NSString *)message action:(NSArray *)actionTitles click:(void (^)(NSInteger tag))block;



@end
