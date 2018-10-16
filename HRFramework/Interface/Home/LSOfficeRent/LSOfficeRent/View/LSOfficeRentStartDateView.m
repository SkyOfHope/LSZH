 //
//  LSOfficeRentStartDateView.m
//  LSZH
//
//  Created by risenb-ios5 on 16/6/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSOfficeRentStartDateView.h"


@interface LSOfficeRentStartDateView ()
{
    NSString *dateType;
}

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end


@implementation LSOfficeRentStartDateView


//初始化
-(instancetype)init
{
    self = [[[NSBundle mainBundle]loadNibNamed:@"LSOfficeRentStartDateView" owner:self options:nil]lastObject];
    
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    NSLocale *loacale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    self.datePicker.locale = loacale;

//    self.datePicker.minimumDate = [NSDate date];
    
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

- (void)hideViewWithStatusType:(BOOL)statusType
{
    self.status = statusType;
    
    if (statusType) {
        
        NSLog(@"🌹🌹🌹🌹🌹🌹🌹🌹🌹");
        self.pickView.hidden = NO;
        self.changeView.hidden = YES;
        
    } else {
        NSLog(@"@#@#@#@#@#@#@");
        self.pickView.hidden = YES;
        self.changeView.hidden = NO;
    }
}

- (IBAction)cancelBtnAction:(UIButton *)sender {
    
    if (self.status == YES) {
        
        [self.delegate sendDateStr:@""];
        
        [self hideContrl];
    
    }
    self.pickView.hidden = YES;
    
}
#pragma mark - 开始时间
- (IBAction)startAction:(id)sender {
    self.pickView.hidden = NO;
    dateType = @"start";
}
#pragma mark - 结束时间
- (IBAction)endAction:(id)sender {
    self.pickView.hidden = NO;
    dateType = @"end";
}

- (IBAction)sureBtnAction:(UIButton *)sender {
    
    //点击确定按钮 将日期控件的日期取出 转换成字符串格式
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateStr = [formatter stringFromDate:self.datePicker.date];
    
    
    
    NSLog(@"%@",dateStr);
    
    //用户选择日期后 应该将日期传递给主控制器 作为网络请求的参数
    
    
    //并隐藏界面
    
    
    if (self.status == YES) {
        
        [self.delegate sendDateStr:dateStr];
        
        [self hideContrl];
    }else{
    
        self.pickView.hidden = YES;
        if([dateType isEqualToString:@"start"]) {
            
            if([[self setFormat:self.endBtn.titleLabel.text] intValue] > 0){
                if ([[self setFormat:dateStr] intValue] > [[self setFormat:self.endBtn.titleLabel.text] intValue]){
                    NSLog(@"bukeyi");
                }else{
                    [self.startBtn setTitle:dateStr forState:UIControlStateNormal];
                    [self.startBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }
            }else{
                [self.startBtn setTitle:dateStr forState:UIControlStateNormal];
                [self.startBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            
            
        }else{
            
            if ([[self setFormat:dateStr] intValue] < [[self setFormat:self.startBtn.titleLabel.text ] intValue]){
                NSLog(@"bukeyi");
            }else{
                [self.endBtn setTitle:dateStr forState:UIControlStateNormal];
                [self.endBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }   
            
            
        }
        
    }
    
}
- (IBAction)cancelBtn:(id)sender {
    
    [self removeFromSuperview];
}
- (IBAction)enterBtn:(id)sender {
    
    UIColor *startCor = self.startBtn.titleLabel.textColor; // 起始时间
    UIColor *endCor = self.endBtn.titleLabel.textColor;     // 结束时间
    
    if(![startCor isEqual:[UIColor blackColor]]){
        NSLog(@"<<<<<<<<开始时间不能为空");
    }else if (![endCor isEqual:[UIColor blackColor]]){
        NSLog(@"<<<<<<<<结束时间不能为空");
    }else if (![startCor isEqual:[UIColor blackColor]] && ![endCor isEqual:[UIColor blackColor]]) {
        NSLog(@"<<<<<<<<时间不能为空");
    }else{
//        [self.delegate sendDateStr:@""];
        
//        [self.delegate sendDateStr:self.startBtn.titleLabel.text WithEndDataStr:self.endBtn.titleLabel.text];
        [self removeFromSuperview];
    }
    
    
    
}

- (NSString *)format:(NSDate *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyyMMdd"];
    
    NSString *dateStr = [formatter stringFromDate:date];
    
    return dateStr;
}

- (NSString *)setFormat:(NSString *)str {
    

    
    NSString *trimmedString = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return trimmedString;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
