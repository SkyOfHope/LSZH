//
//  LSCustomBtn.m
//  LSZH
//
//  Created by apple  on 16/6/29.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSCustomBtn.h"

@interface LSCustomBtn ()


@property (strong, nonatomic) UIButton *btn;

@end


@implementation LSCustomBtn



-(void)layoutSubviews{
    
    self.titleLabel.frame = CGRectMake(0, self.frame.size.height / 2, self.frame.size.width, self.frame.size.height/2);
    
    self.titleLabel.font = [UIFont systemFontOfSize:11];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.btn = [[UIButton alloc]initWithFrame:CGRectMake((self.frame.size.width - 21) / 2 , 5, 21, 39/2)];
    
    [self addSubview:self.btn];

    [self.btn setBackgroundImage:[UIImage imageNamed:@"约谈"] forState:UIControlStateNormal];
    
    self.btn.userInteractionEnabled = NO;


    [self.btn setBackgroundImage:self.btnImg forState:UIControlStateNormal];
    
    
}


@end
