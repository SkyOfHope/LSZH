
#import "HRNetStatusManager.h"
#import "Reachability.h"
#import "HRNetStatus.h"

@interface HRNetStatusManager ()

@property (nonatomic, strong) Reachability *connection;

@end

@implementation HRNetStatusManager

#pragma mark - ---------- Singleton ----------

+ (instancetype)shareConfiguration {
    static HRNetStatusManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}
+ (instancetype) allocWithZone:(struct _NSZone *)zone {
    return [HRNetStatusManager shareConfiguration];
}
- (instancetype) copyWithZone:(struct _NSZone *)zone{
    return [HRNetStatusManager shareConfiguration];
}


#pragma mark - ---------- Lifecycle ----------
- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
        self.connection = [Reachability reachabilityForInternetConnection];
        [self.connection startNotifier];
        
        [self networkStateChange];
    }
    return self;
}

- (void)dealloc {
    [self.connection stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - ---------- Private Methods ----------
- (void)networkStateChange {
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    Reachability *conn = [Reachability reachabilityForInternetConnection];

    if ([wifi currentReachabilityStatus] != NotReachable) {
        NSLog(@"Wifi");
        [HRNetStatus shareInstance].status = HRNetStatusEnumWifi;
    } else if ([conn currentReachabilityStatus] != NotReachable) {
        NSLog(@"Cellular");
        [HRNetStatus shareInstance].status = HRNetStatusEnumCellular;
    } else {
        NSLog(@"NotNet");
        [HRNetStatus shareInstance].status = HRNetStatusEnumNotNet;
    }
}



@end
