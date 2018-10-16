//
//  LSOfficeRentMoneyView.m
//  LSZH
//
//  Created by risenb-ios5 on 16/6/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSOfficeRentMoneyView.h"


@interface LSOfficeRentMoneyView()

@property (strong, nonatomic) IBOutlet UITextField *moneyStart;
@property (strong, nonatomic) IBOutlet UITextField *moneyEnd;



@end

@implementation LSOfficeRentMoneyView


//初始化
-(instancetype)init
{
    self = [[[NSBundle mainBundle]loadNibNamed:@"LSOfficeRentMoneyView" owner:self options:nil]lastObject];
    if (self)
    {
        
    }
    return self;
}

-(void)setStart:(NSString *)start{
    _start = start;
    self.moneyStart.text = start;
}
-(void)setEnd:(NSString *)end{
    _end = end;
    self.moneyEnd.text = end;
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
    if (_delegate && [_delegate respondsToSelector:@selector(sendmoney:moneyend:)]) {
        [_delegate sendmoney:self.moneyStart.text moneyend:self.moneyEnd.text];
        
        NSLog(@"%@",self.moneyEnd.text);
        NSLog(@"%@",self.moneyStart.text);
        
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
