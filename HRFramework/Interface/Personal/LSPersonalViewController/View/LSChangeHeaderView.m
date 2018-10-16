//
//  LSChangeHeaderView.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/19.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSChangeHeaderView.h"

@interface LSChangeHeaderView ()


@end

@implementation LSChangeHeaderView

//初始化
-(instancetype)init
{
    self = [[[NSBundle mainBundle]loadNibNamed:@"LSChangeHeaderView" owner:self options:nil]lastObject];
    if (self)
    {
        
    }
    return self;
}

//隐藏界面
-(void)hideContrl
{
    [UIView animateWithDuration:.3 animations:^{
//        self.bottom = self.superview.top;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark 触发事件
- (IBAction)hideShareAction:(UIButton *)sender
{
    self.hidden = YES;
//    [self hideContrl];
}

- (IBAction)localPhotoAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(localPhotoAction)]) {
        [_delegate localPhotoAction];
    }
    
}

- (IBAction)takePhotoAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(takePhotoAction)]) {
        [_delegate takePhotoAction];
    }
    
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
