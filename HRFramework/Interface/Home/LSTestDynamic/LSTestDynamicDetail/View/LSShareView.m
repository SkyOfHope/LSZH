
//
//  LSShareView.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/26.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSShareView.h"
#import "HRShareManager.h"
#import "LSTestDynamicDetailViewController.h"


@interface LSShareView()

@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;

@end

@implementation LSShareView

//初始化
-(instancetype)init
{
    self = [[[NSBundle mainBundle]loadNibNamed:@"LSShareView" owner:self options:nil]lastObject];
    if (self)
    {
        
    }
    
    NSLog(@"  标题标题标题标题%@",self.title);
    
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

- (IBAction)wx:(id)sender {
    NSLog(@"wxwxwx");
    
    [HRShareManager shareTo:PlatformWechatSession title:self.title image:[UIImage imageNamed:@"文创实验 2"] content:self.title url:self.url completed:^{
        
    }];
    
    [self hideContrl];
    
}

- (IBAction)qq:(id)sender {
    NSLog(@"qqqqqq");
    
   
    [HRShareManager shareTo:PlatformWechatTimeline title:self.title image:[UIImage imageNamed:@"文创实验 2"] content:self.title url:self.url completed:^{
        
    }];
    
    [self hideContrl];
}


- (IBAction)wb:(id)sender {
    NSLog(@"wbwbwb");
    
    
}





- (IBAction)cancelBtnAction:(UIButton *)sender {
    [self hideContrl];
}



@end
