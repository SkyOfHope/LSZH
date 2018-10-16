//
//  LSTestDynamicNoImageTableViewCell.m
//  LSZH
//
//  Created by apple  on 16/7/4.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSTestDynamicNoImageTableViewCell.h"

@interface LSTestDynamicNoImageTableViewCell ()


@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *time;


@end




@implementation LSTestDynamicNoImageTableViewCell

-(void)buildingSecondCellWithModel:(LSGetSyqdtModel *)model{
    
    self.title.text = model.title;
    self.time.text = [self cutAndReplaceDate:model.publishdate][0];
 
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
    
//    self.
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
