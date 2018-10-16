//
//  LSAppointmentChooseCell.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSAppointmentChooseCell.h"


@interface  LSAppointmentChooseCell()

@property (strong, nonatomic) IBOutlet UILabel *rongziNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *keyWordNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *sizeNamelable;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;



@property (weak, nonatomic) IBOutlet UIImageView *imageForAppointmentChoose;


@property (strong, nonatomic) IBOutlet UILabel *rongziZhutiLabel;
@property (strong, nonatomic) IBOutlet UILabel *keywordLabel;
@property (strong, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *regDateLabel;






@end


@implementation LSAppointmentChooseCell



-(void)buildingFinancingWithModel:(LSSelectMeetItemListModel *)model{
    
    
    //    self.img =
    self.rongziNameLabel.text = @"融资主体：";
    self.keywordLabel.text = @"关键词：";
    self.sizeNamelable.text = @"";
    
    self.titleLabel.text = model.title;
    self.rongziZhutiLabel.text = model.ziduan1;
    self.keywordLabel.text = model.ziduan2;
//    self.viewCountLabel.text = model.ziduan3;
    self.regDateLabel.text = [self cutAndReplaceDate:model.regDate][0];
    
    self.typeLabel.text = model.itemTypeName;
    
    [self.imageForAppointmentChoose sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"占位"]];

    if ([self.shouleToDoWhatAction isEqualToString:@"删除"]) {
        
        [self.stateBtn addTarget:self action:@selector(shanchutableView) forControlEvents:UIControlEventTouchUpInside];
    }
}


-(void)buildingJinRongWithModel:(LSSelectMeetItemListModel *)model{
    //    self.img =
    
    self.keyWordNameLabel.text = @"关键词：";
    self.sizeNamelable.text = @"";
    self.rongziNameLabel.text = @"发行单位：";
    
    self.titleLabel.text = model.title;
    self.rongziZhutiLabel.text = model.ziduan1;
    self.keywordLabel.text = model.ziduan2;
//    self.viewCountLabel.text = model.ziduan3;
//    self.viewCountLabel.text = @""
    
    self.regDateLabel.text = [self cutAndReplaceDate:model.regDate][0];
    
    self.typeLabel.text = model.itemTypeName;
    
    if ([self.shouleToDoWhatAction isEqualToString:@"删除"]) {

        [self.stateBtn addTarget:self action:@selector(shanchutableView) forControlEvents:UIControlEventTouchUpInside];
    }

}


-(void)buildingRentHouseWithModel:(LSSelectMeetItemListModel *)model{


    self.rongziNameLabel.text = @"日租金:";
    self.keyWordNameLabel.text = @"面积:";

    self.titleLabel.text = model.title;
    
    self.rongziZhutiLabel.text = [NSString stringWithFormat:@"%@元/日",model.ziduan1];
    self.keywordLabel.text = [NSString stringWithFormat:@"%@m²",model.ziduan2];

    self.regDateLabel.text = [self cutAndReplaceDate:model.regDate][0];
    
    self.typeLabel.text = model.itemTypeName;

    [self.sizeNamelable setHidden:YES];
    
    if ([self.shouleToDoWhatAction isEqualToString:@"删除"]) {

        [self.stateBtn addTarget:self action:@selector(shanchutableView) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(void)buildingWantHouseModel:(LSSelectMeetItemListModel *)model{
    
    
//    self.img =
    
    self.typeLabel.text = model.itemTypeName;
    
    self.titleLabel.text = model.title;
    self.rongziZhutiLabel.text = model.ziduan1;
    self.keywordLabel.text = model.ziduan2;
    self.viewCountLabel.text = model.ziduan3;
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

//当按钮标题为删除的时候选择的方法
-(void)shanchutableView{
    
    if ([self.delegate respondsToSelector:@selector(deleteSoureArrayWhichElement)]) {
        [self.delegate deleteSoureArrayWhichElement];
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
