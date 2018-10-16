
#import "NSDictionary+Log.h"

@implementation NSDictionary (Log)

- (void)log {
    NSString *tempStr1 = [[self description] stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str = [NSPropertyListSerialization propertyListFromData:tempData mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
    NSLog(@"%@",str);
}

@end
