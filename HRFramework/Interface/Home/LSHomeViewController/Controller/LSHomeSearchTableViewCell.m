//
//  LSHomeSearchTableViewCell.m
//  LSZH
//
//  Created by posco imac4 on 16/6/6.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSHomeSearchTableViewCell.h"

@implementation LSHomeSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)buildingHomeSearchWithModel:(LSHomeSearchModel *)model {

    self.titleLab.text = model.title;
    self.timeLab.text = [self cutAndReplaceDate:model.publishdate][0];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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


@end
