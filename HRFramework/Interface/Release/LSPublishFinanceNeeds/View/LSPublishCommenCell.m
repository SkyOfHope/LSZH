//
//  LSPublishCommenCell.m
//  LSZH
//
//  Created by risenb-ios5 on 16/6/8.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSPublishCommenCell.h"

@implementation LSPublishCommenCell

-(instancetype)init
{
    self = [[[NSBundle mainBundle]loadNibNamed:@"LSPublishCommenCell" owner:self options:nil]lastObject];
    if (self)
    {
        
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}


-(void)changeSelectedState:(BOOL)isSelected {
    [self.img setImage:isSelected ? [UIImage imageNamed:@"发布选中"] : [UIImage imageNamed:@"发布未选中"]];
}



-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
