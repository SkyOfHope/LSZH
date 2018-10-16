//
//  LSPolicyInformationCell.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/23.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSPolicyInformationCell.h"

@interface   LSPolicyInformationCell()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *publishdateLabel;



@end

@implementation LSPolicyInformationCell

-(void)buildingWithModel:(LSGetArticleListModel *)model{
    
    self.titleLabel.text = model.title;
    self.viewCountLabel.text = model.viewCount;
//    self.publishdateLabel.text = model.publishdate;
    
    self.publishdateLabel.text = [self cutAndReplaceDate:model.publishdate][0];
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
