/*================================
||    @param name   buttonAction ||
||    @param author muyingbo     ||
||    @param date   2016-04-03   ||
=================================*/

#import <UIKit/UIKit.h>

@interface UIButton (AddAction)

- (void)addAction:(void(^)(NSInteger tag))block;

@end
