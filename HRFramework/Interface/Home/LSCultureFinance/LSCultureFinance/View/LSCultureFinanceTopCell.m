
//
//  LSCultureFinanceTopCell.m
//  LSZH
//
//  Created by risenb-ios5 on 16/6/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSCultureFinanceTopCell.h"

@interface LSCultureFinanceTopCell()

@end

@implementation LSCultureFinanceTopCell

- (void)awakeFromNib {
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
}

-(void)changeSelectedState:(BOOL)isSelected {
    [self.img setHidden:!isSelected];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
