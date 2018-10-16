/*===================================
 ||    @param name   CheckVersion   ||
 ||    @param author muyingbo       ||
 ||    @param date   2016-05-02     ||
 ===================================*/

#import <Foundation/Foundation.h>

@interface HRVersion : NSObject

/**
 *  singleton
 */
+ (instancetype)shareInstance;

/**
 *  check version update
 *
 *  @return
 */
+ (BOOL)check;

@end
