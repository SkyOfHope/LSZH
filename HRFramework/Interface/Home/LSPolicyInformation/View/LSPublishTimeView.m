

//
//  LSPublishTimeView.m
//  LSZH
//
//  Created by risenb-ios5 on 16/6/29.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSPublishTimeView.h"

@interface  LSPublishTimeView()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *startDate;
@property (strong, nonatomic) IBOutlet UITextField *endDate;


@end

@implementation LSPublishTimeView

-(instancetype)init{
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"LSPublishTimeView" owner:self options:nil]lastObject];
    
    if (self) {
        self.startDate.delegate = self;
        self.endDate.delegate = self;
        
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


- (IBAction)cancelBtnAction:(UIButton *)sender {
    
    [self hideContrl];
    
}

- (IBAction)sureBtnAction:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(sendDateStr:WithEndDataStr:)]) {
        
        [_delegate sendDateStr:self.startDate.text WithEndDataStr:self.endDate.text];
    }
    [self hideContrl];
}


//添加代理,在遵守协议之后实现方法即可
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.startDate) {
        
        if (self.startDate.text.length < 4) {
            return YES;
        }else{
            return NO;
        }
        
    }else{
        
        if (self.endDate.text.length < 4) {
            return YES;
        }else{
            return NO;
        }
        
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
