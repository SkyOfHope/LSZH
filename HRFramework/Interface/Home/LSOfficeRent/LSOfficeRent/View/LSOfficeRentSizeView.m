//
//  LSOfficeRentSizeView.m
//  LSZH
//
//  Created by risenb-ios5 on 16/6/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSOfficeRentSizeView.h"

@interface  LSOfficeRentSizeView()
@property (strong, nonatomic) IBOutlet UITextField *sizeStart;
@property (strong, nonatomic) IBOutlet UITextField *sizeEnd;

@end


@implementation LSOfficeRentSizeView

//初始化
-(instancetype)init
{
    self = [[[NSBundle mainBundle]loadNibNamed:@"LSOfficeRentSizeView" owner:self options:nil]lastObject];
    if (self)
    {
        
    }
    return self;
}

-(void)setStart:(NSString *)start{
    _start = start;
    self.sizeStart.text = start;
}
-(void)setEnd:(NSString *)end{
    _end = end;
    self.sizeEnd.text = end;
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


- (IBAction)cancelBtnAction:(UIButton *)sender {
    
    [self hideContrl];
    
}

- (IBAction)sureBtnAction:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(SendSizeStart:WithSizeEnd:)]) {
        
        [_delegate SendSizeStart:self.sizeStart.text WithSizeEnd:self.sizeEnd.text];
    }
    
    
    

    
    
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
