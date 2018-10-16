
#import "HRVersion.h"

static NSString *const APP_LAST_VERSION = @"1.0";
static NSString *const APP_LAST_VERSION_KEY = @"APP_LAST_VERSION_KEY";

@implementation HRVersion

+ (instancetype)shareInstance {
    static HRVersion * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}
+ (instancetype) allocWithZone:(struct _NSZone *)zone {
    return [HRVersion shareInstance];
}
- (instancetype)copyWithZone:(struct _NSZone *)zone{
    return [HRVersion shareInstance];
}


+ (BOOL)check {
    
    NSString *version = [UserDefault objectForKey:APP_LAST_VERSION_KEY];
    if (!version) {
        [UserDefault setObject:APP_LAST_VERSION forKey:APP_LAST_VERSION_KEY];
    }
    
    NSString *currentVersion = APP_VERSION;
    NSString *lastVersion = [UserDefault objectForKey:APP_LAST_VERSION_KEY];
    
    [UserDefault setObject:currentVersion forKey:APP_LAST_VERSION_KEY];
    
    return currentVersion > lastVersion;;
}


@end
