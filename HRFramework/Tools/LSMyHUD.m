//
//  LSMyHUD.m
//  LSZH
//
//  Created by posco imac4 on 16/6/6.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSMyHUD.h"

@implementation LSMyHUD


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        MBProgressHUD *mb=[[MBProgressHUD alloc] initWithView:self];
        mb.dimBackground=YES;
        mb.labelText=@"正在处理中...";
        mb.dimBackground=NO;
        [mb show:YES];
        [self addSubview:mb];
        mb.tag=12345;
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
