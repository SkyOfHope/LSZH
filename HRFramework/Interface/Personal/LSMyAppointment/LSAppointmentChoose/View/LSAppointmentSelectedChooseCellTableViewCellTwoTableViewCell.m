//
//  LSAppointmentSelectedChooseCellTableViewCellTwoTableViewCell.m
//  LSZH
//
//  Created by apple  on 16/7/30.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSAppointmentSelectedChooseCellTableViewCellTwoTableViewCell.h"

#import "LSSelectMeetItemListModel.h"

@interface LSAppointmentSelectedChooseCellTableViewCellTwoTableViewCell ()


@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *danwei;

@property (weak, nonatomic) IBOutlet UILabel *guanjian;

@property (weak, nonatomic) IBOutlet UILabel *date;

@property (weak, nonatomic) IBOutlet UILabel *diliweizhi;

@property (weak, nonatomic) IBOutlet UIButton *delete;


@property (weak, nonatomic) IBOutlet UIButton *leixing;

@end



@implementation LSAppointmentSelectedChooseCellTableViewCellTwoTableViewCell

-(void)setModel:(LSSelectMeetItemListModel *)model{
    
    _model = model;
    
    
    [self.leixing setTitle:model.itemTypeName forState:UIControlStateNormal];

    
    self.title.text = model.title;
//    self.danwei.text = [NSString stringWithFormat:@"日租金:%@",model.zidu1];
    
    NSString *dateT = [self cutAndReplaceDate:model.regDate][0];
    self.date.text = [NSString stringWithFormat:@"时间:%@",dateT];
    self.guanjian.text = [NSString stringWithFormat:@"需求面积:%@m²",model.ziduan2];
    
    [self.delete addTarget:self action:@selector(shanchutableView) forControlEvents:UIControlEventTouchUpInside];

    self.diliweizhi.text = [NSString stringWithFormat:@"地理位置:%@",model.ziduan3];
    
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


@end
