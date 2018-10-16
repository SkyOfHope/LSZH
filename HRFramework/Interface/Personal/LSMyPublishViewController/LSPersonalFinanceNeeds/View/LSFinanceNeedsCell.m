//
//  LSFinanceNeedsCell.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/24.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSFinanceNeedsCell.h"

@interface LSFinanceNeedsCell()

@property (strong, nonatomic) IBOutlet UIImageView *img;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *rongziZhutiLabel;

@property (strong, nonatomic) IBOutlet UILabel *keywordLabel;
@property (strong, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *regDateLabel;



@end

@implementation LSFinanceNeedsCell


-(void)buildingWithModel:(LSGetMyFinancingListModel *)model{
    
//    self.img =
    self.titleLabel.text = model.title;
    self.rongziZhutiLabel.text = model.rongziZhuti;
    self.keywordLabel.text = model.keyword;
    self.viewCountLabel.text = model.viewCount;
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"占位"]];
    
    self.regDateLabel.text = [self cutAndReplaceDate:model.regDate][0];
    
}
- (IBAction)jieshufabuAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(jieshufabu:)]) {
        [_delegate jieshufabu:_jieshuBtn.tag];
    }
    
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
