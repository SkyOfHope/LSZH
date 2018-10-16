//
//  LSListGroupSectionHeaderView.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/30.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSListGroupSectionHeaderView.h"

@implementation LSListGroupSectionHeaderView


-(instancetype)initWithSection:(NSInteger)section
{
    self = [[[NSBundle mainBundle]loadNibNamed:@"LSListGroupSectionHeaderView" owner:self options:nil]lastObject];
    if (self)
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        self.tag = section;
        [self addGestureRecognizer:tap];

    }
    return self;
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
//    ZYQFriends *friend = [ZYQFriends allFriends][tap.view.tag];
    
//    friend.isOpen = !friend.isOpen;
    
    
//    if ([_delegate respondsToSelector:@selector(open:)]) {
//        [_delegate open:tap.view.tag];
//    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
