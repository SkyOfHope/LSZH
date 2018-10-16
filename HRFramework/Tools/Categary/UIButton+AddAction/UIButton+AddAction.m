
#import "UIButton+AddAction.h"
#import <objc/runtime.h>

static char BlockAddrKey = 'k';

@interface UIButton ()

@property (nonatomic, copy) void(^block)(NSInteger tag);

@end

@implementation UIButton (AddAction)

- (void (^)(NSInteger))block {
    return objc_getAssociatedObject(self, &BlockAddrKey);
}

- (void)setBlock:(void (^)(NSInteger))block {
    objc_setAssociatedObject(self, &BlockAddrKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (void)addAction:(void(^)(NSInteger tag))block {
    self.block = block;
    [self addTarget:nil action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonAction:(UIButton *)bt {
    self.block(bt.tag);
}

@end
