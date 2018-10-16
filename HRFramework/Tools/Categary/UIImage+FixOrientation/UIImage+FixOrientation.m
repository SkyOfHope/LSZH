

#import "UIImage+FixOrientation.h"

@implementation UIImage (FixOrientation)


- (UIImage *)fix {
    return [UIImage imageWithCGImage:[self CGImage]
                        scale:1.0
                  orientation: UIImageOrientationUp];
}

@end
