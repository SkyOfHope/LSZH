//
//  LSNeedOfficeRentDetailHeader.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSNeedOfficeRentDetailHeader.h"

#import "LSShareView.h"

@interface LSNeedOfficeRentDetailHeader()

@property (strong, nonatomic) LSShareView *shareView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *zujinLabel;
@property (strong, nonatomic) IBOutlet UILabel *sizeLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *peitaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *qizuDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *regDateLabel;

@end

@implementation LSNeedOfficeRentDetailHeader

-(instancetype)init{
    
    self = [[[NSBundle mainBundle]loadNibNamed:@"LSNeedOfficeRentDetailHeader" owner:self options:nil]lastObject];
    if (self)
    {
        self.titleLabel.text = @"";
        self.viewCountLabel.text = @"";
        self.zujinLabel.text = @"";
        self.addressLabel.text = @"";
        self.qizuDateLabel.text = @"";
        self.sizeLabel.text = @"";
        self.regDateLabel.text = @"";

        
    }
    
    return self;
}


- (IBAction)shareBtnAction:(UIButton *)sender {
    
//    NSLog(@"分享分享分享分享分享分享");
    
    self.shareView = [[LSShareView alloc]init];
    self.shareView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
    //    self.alertView.backgroundColor = RGBColor(0, 0, 0, .5);
    self.shareView.layer.cornerRadius = 5;
    self.shareView.layer.masksToBounds = YES;
    [AppDelegate.window addSubview:self.shareView];
    
    self.shareView.frame = SCREEN_BOUNDS;
    
}

- (NSString *)CheckString:(NSString *)str
{
    if (!str) {
        return @"";
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return str;
}

-(void)buildingWithModel:(LSGetItemWantHouseModel *)model{
    
    self.titleLabel.text = model.title;
    self.viewCountLabel.text = model.viewCount;
    self.zujinLabel.text = [NSString stringWithFormat:@"%@-%@元",model.rizujinStart,model.rizujinEnd];
    self.addressLabel.text = model.city;
    self.sizeLabel.text = [NSString stringWithFormat:@"%@-%@m²",model.sizeStart,model.sizeEnd];

    self.peitaoLabel.text = model.peitaoSheshi;
    if (model.qizuDate.length > 0) {
        
        self.qizuDateLabel.text = [self cutAndReplaceDate:model.qizuDate][0];
    }
    if (model.regDate.length > 0) {
        
        self.regDateLabel.text = [self cutAndReplaceDate:model.regDate][0];
    }
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(updateData)]) {
        [_delegate updateData];
    }
    
    
    
}

//截取时间字符串
//0为日期 1为时间
-(NSMutableArray*)cutAndReplaceDate:(NSString *)date{
    
    NSArray *arr = [date componentsSeparatedByString:@" "];
    
    NSString *dateStr = [arr[0] stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    NSMutableArray *dateArr = [NSMutableArray arrayWithArray:arr];
    
    if (dateStr) {
        [dateArr replaceObjectAtIndex:0 withObject:dateStr];
    }
    
    return dateArr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
