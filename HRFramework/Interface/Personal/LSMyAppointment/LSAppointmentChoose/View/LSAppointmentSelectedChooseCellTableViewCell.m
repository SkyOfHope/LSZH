//
//  LSAppointmentSelectedChooseCellTableViewCell.m
//  LSZH
//
//  Created by apple  on 16/6/30.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSAppointmentSelectedChooseCellTableViewCell.h"

@interface LSAppointmentSelectedChooseCellTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *ImageVIew;



@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *faixngdanwei;

@property (weak, nonatomic) IBOutlet UILabel *guanjianci;


@property (weak, nonatomic) IBOutlet UILabel *shijian;
@property (weak, nonatomic) IBOutlet UIButton *leixing;

//@property (weak, nonatomic) IBOutlet UILabel *leixing;



@property (weak, nonatomic) IBOutlet UIButton *delete;

@property (weak, nonatomic) IBOutlet UILabel *danwei;

@property (weak, nonatomic) IBOutlet UILabel *guanjian;

@property (weak, nonatomic) IBOutlet UILabel *date;

@property (weak, nonatomic) IBOutlet UIButton *imageBtn;

@end




@implementation LSAppointmentSelectedChooseCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)buildingFinancingWithModel:(LSSelectMeetItemListModel *)model{
    
    
    self.danwei.text = @"融资主体:";
    self.guanjian.text = @"关键词:";
    self.date.text = @"时间:";

    /*
     @property (nonatomic,copy) NSString *itemTypeId;//标识id
     @property (nonatomic,copy) NSString *itemId;//项目ID
     @property (nonatomic,copy) NSString *title;//标题
     @property (nonatomic,copy) NSString *imgPath;//图片地址
     @property (nonatomic,copy) NSString *zidu1;//日租金结束值
     @property (nonatomic,copy) NSString *ziduan2;//地理位置
     @property (nonatomic,copy) NSString *ziduan3;//面积起始值
     @property (nonatomic,copy) NSString *regDate;//发布时间
     */
    
    [self.leixing setTitle:model.itemTypeName forState:UIControlStateNormal];
    
    self.title.text = model.title;
    self.faixngdanwei.text = model.ziduan1;
    self.guanjianci.text = model.ziduan2;
    self.shijian.text = [self cutAndReplaceDate:model.regDate][0];

//    [self.ImageVIew sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"文化金融产品列表"]];

    UIImageView *img = [[UIImageView alloc]init];
    [img sd_setImageWithURL:[NSURL URLWithString:model.imgPath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.imageBtn setBackgroundImage:img.image forState:UIControlStateNormal];
    }];
    
    
    [self.delete addTarget:self action:@selector(shanchutableView) forControlEvents:UIControlEventTouchUpInside];

    
    
}


-(void)buildingJinRongWithModel:(LSSelectMeetItemListModel *)model{
    //    self.img =
    
    [self.leixing setTitle:model.itemTypeName forState:UIControlStateNormal];
    
    self.guanjian.text = @"关键词:";
    self.faixngdanwei.text = @"发行单位:";
    self.date.text = @"时间:";
    
    
    
    self.title.text = model.title;
    self.faixngdanwei.text = model.ziduan1;
    self.guanjianci.text = model.ziduan2;
    self.shijian.text = [self cutAndReplaceDate:model.regDate][0];
    
//    [self.ImageVIew sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"文化金融产品列表"]];
    
    UIImageView *img = [[UIImageView alloc]init];
    [img sd_setImageWithURL:[NSURL URLWithString:model.imgPath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.imageBtn setBackgroundImage:img.image forState:UIControlStateNormal];
    }];
    
    [self.delete addTarget:self action:@selector(shanchutableView) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)buildingRentHouseWithModel:(LSSelectMeetItemListModel *)model{
    
    [self.leixing setTitle:model.itemTypeName forState:UIControlStateNormal];
    
    self.danwei.text = @"日租金:";
    self.guanjian.text = @"面积:";
    self.date.text = @"时间:";
    
    self.faixngdanwei.text = [NSString stringWithFormat:@"%@元/日",model.ziduan1];
    self.guanjianci.text = [NSString stringWithFormat:@"%@m²",model.ziduan2];
    self.title.text = model.title;
    self.shijian.text = [self cutAndReplaceDate:model.regDate][0];

    UIImageView *img = [[UIImageView alloc]init];
    [img sd_setImageWithURL:[NSURL URLWithString:model.imgPath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.imageBtn setBackgroundImage:img.image forState:UIControlStateNormal];
    }];
    
    [self.delete addTarget:self action:@selector(shanchutableView) forControlEvents:UIControlEventTouchUpInside];

}



-(void)buildingWantHouseModel:(LSSelectMeetItemListModel *)model{
    
    [self.leixing setTitle:model.itemTypeName forState:UIControlStateNormal];
    
    self.danwei.text = @"求租单位:";
    self.date.text = @"时间:";
    self.guanjian.text = @"需求面积:";
    
    self.guanjianci.text = [NSString stringWithFormat:@"%@m²",model.ziduan2];
    self.faixngdanwei.text = model.ziduan1;
    self.title.text = model.title;
    self.shijian.text = [self cutAndReplaceDate:model.regDate][0];
    
//    [self.ImageVIew sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"文化金融产品列表"]];
    
    UIImageView *img = [[UIImageView alloc]init];
    [img sd_setImageWithURL:[NSURL URLWithString:model.imgPath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.imageBtn setBackgroundImage:img.image forState:UIControlStateNormal];
    }];
    
    [self.delete addTarget:self action:@selector(shanchutableView) forControlEvents:UIControlEventTouchUpInside];
    
}

//-(void)buildingWantHouseModel:(LSSelectMeetItemListModel *)model{
//    
//    self.danwei.text = @"求租单位:";
//    self.date.text = @"时间:";
//    self.guanjian.text = @"需求面积:";
//    
//    self.guanjianci.text = [NSString stringWithFormat:@"%@m²",model.ziduan2];
//    self.faixngdanwei.text = model.zidu1;
//    self.title.text = model.title;
//    self.shijian.text = [self cutAndReplaceDate:model.regDate][0];
//    
////    [self.ImageVIew sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"文化金融产品列表"]];
//    
//    UIImageView *img = [[UIImageView alloc]init];
//    [img sd_setImageWithURL:[NSURL URLWithString:model.imgPath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        [self.imageBtn setBackgroundImage:img.image forState:UIControlStateNormal];
//    }];
//    
//    [self.delete addTarget:self action:@selector(shanchutableView) forControlEvents:UIControlEventTouchUpInside];
//    
//}



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
