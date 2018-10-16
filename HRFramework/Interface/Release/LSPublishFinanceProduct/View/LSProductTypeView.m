//
//  LSProductTypeView.m
//  LSZH
//
//  Created by risenb-ios5 on 16/6/7.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSProductTypeView.h"

@implementation LSProductTypeView

//初始化
-(instancetype)init
{
    self = [[[NSBundle mainBundle]loadNibNamed:@"LSProductTypeView" owner:self options:nil]lastObject];
    
    
    
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


- (IBAction)ButtonAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    
    [self hideContrl];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
