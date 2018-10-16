
#import "HRArchive.h"
#import "HRSandbox.h"

@implementation HRArchive

+ (void)archiveObject:(NSObject *)obj toPath:(NSString *)file {
    [NSKeyedArchiver archiveRootObject:obj toFile:SF(@"%@%@",[HRSandbox docPath], file)];
}

+ (id)unarchiveFromPath:(NSString *)file {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:SF(@"%@%@",[HRSandbox docPath], file)];
}

@end
