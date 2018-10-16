
//
//  LSTestDynamicCell.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/23.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSTestDynamicCell.h"

@interface LSTestDynamicCell()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelWidth;

@end

@implementation LSTestDynamicCell



-(void)buildingWithModel:(LSGetSyqdtModel *)model{
    
    self.titleLabel.text = model.title;
    self.dateLabel.text = [self cutAndReplaceDate:model.publishdate][0];
    
        [self.imageView setHidden:NO];
        [self.img sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"占位"]];
    
}


//截取时间字符串
//0为日期 1为时间
-(NSMutableArray*)cutAndReplaceDate:(NSString *)date{
    
    NSArray *arr = [date componentsSeparatedByString:@" "];
    
    NSString *dateStr = [arr[0] stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    NSMutableArray *dateArr = [NSMutableArray arrayWithArray:arr];
    
    [dateArr replaceObjectAtIndex:0 withObject:dateStr];
    
    return dateArr;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
