//
//  LSMailboxTableViewCell.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/20.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSMailboxTableViewCell.h"

@interface LSMailboxTableViewCell()
@property (strong, nonatomic) IBOutlet UILabel *strContent;

@property (strong, nonatomic) IBOutlet UILabel *regDateLabel;


@end

@implementation LSMailboxTableViewCell


-(void)buildingWithModle:(LSGetUserMessageListModel *)model{
    
    self.strContent.text = model.strContent;
    self.regDateLabel.text = [self cutAndReplaceDate:model.regDate][0];
    
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
