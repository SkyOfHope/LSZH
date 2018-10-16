//
//  LSInsdustryTableViewCell.m
//  LSZH
//
//  Created by xun.liu on 16/6/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSInsdustryTableViewCell.h"

@interface LSInsdustryTableViewCell ()



@property (nonatomic, strong) NSArray *allindustrtArr;
@end


@implementation LSInsdustryTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutSubviews];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectImg.userInteractionEnabled = YES;
    self.selectImg.hidden = YES;
    [self.titleBtn setTintColor:[UIColor darkGrayColor]];
//    self.selected = NO;
    
    if (self.isSelected == YES) {
        [self.titleBtn setTintColor:[UIColor blueColor]];
        self.selectImg.hidden = NO;
    }
    if (self.isSelected == NO) {
        [self.titleBtn setTintColor:[UIColor darkGrayColor]];
        self.selectImg.hidden = YES;
    }

}

- (void) layoutSubviews {
    if (self.isSelected == YES) {
        [self.titleBtn setTintColor:[UIColor blueColor]];
        self.selectImg.hidden = NO;
    }
    if (self.isSelected == NO) {
        [self.titleBtn setTintColor:[UIColor darkGrayColor]];
        self.selectImg.hidden = YES;
    }
    
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
