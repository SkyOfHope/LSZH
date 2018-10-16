//
//  LSTestDynamicDetailCell.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/23.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSTestDynamicDetailCell.h"

@interface  LSTestDynamicDetailCell()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *regDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) NSString *detail;

@end

@implementation LSTestDynamicDetailCell

-(void)buildingWithModel:(LSGetArticleModel *)model{
    
    _detail = [self filterHTML:model.content];
    self.titleLabel.text = model.title;
    self.viewCountLabel.text = model.viewCount;
    self.regDateLabel.text = [self cutAndReplaceDate:model.regDate][0];
    self.contentLabel.text = _detail;
    
    

}

-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@"\n"];
//        html = [html stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    }
    return html;
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
