
#import "HRFirstEnter.h"

@implementation HRFirstEnter

+ (void)isFirst:(void(^)())block {
    NSNumber *value = [UserDefault valueForKey:USERDEFAULT_FIRST_ENTER_PROGRAM];
    if (value == nil || ![value boolValue]) {
        [UserDefault setObject:@(YES) forKey:USERDEFAULT_FIRST_ENTER_PROGRAM];
        block();
    }
}

@end
