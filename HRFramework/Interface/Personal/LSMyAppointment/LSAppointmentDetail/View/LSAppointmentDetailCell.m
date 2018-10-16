//
//  LSAppointmentDetailCell.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/21.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSAppointmentDetailCell.h"

@interface LSAppointmentDetailCell ()

@property (weak, nonatomic) IBOutlet UIView *itemCell;

@property (strong, nonatomic) LSFaQiDetailModel *modelFaQi;

@end


@implementation LSAppointmentDetailCell

- (void)awakeFromNib {
    // Initialization code
    
    
    
    self.titleLab.text = @"";
    self.chanpinLab.text = @"";
    self.faxingdanweiLab.text = @"";
    self.guanjianciLab.text = @"";
    
    self.rongzizhutiLab.text = @"";
    self.guanjianciLabel.text = @"";
    
    
    self.keyWordsLabel.text = @"";
    
    
    self.danweiLab.text  = @"";
    self.keywordsLab.text = @"";
    self.faqishijianLab.text = @"";
    self.yuanquLab.text = @"";
    self.yuetanneirongLab.text = @"";
    self.xinxiLab.text = @"";
    self.gerenLab.text = @"";
    //    self.shijianLab.text = model.fujianRegDate;
   
    self.shijianLab.text = @"";
    
    
    [self configUI];
    
}

-(void)configUI{
    
    self.yuanquLab.layer.cornerRadius = 2.5;
    self.yuanquLab.layer.masksToBounds = YES;
    
    
}


- (void)buildFaQiDetailWithFaQiDetailModel:(LSFaQiDetailModel *)model {
    
    if ([model.fujianItemId isEqualToString:@"0"]) {
        self.itemCell.hidden = YES;
    }else{
        self.itemCell.hidden = NO;
    }
    
    
/*
 titleLab;
 chanpinLab;
 faxingdanweiLab;
 danweiLab;
 keywordsLab;
 yuanquLab;
 faqishijianLab;
 yuetanneirongLab;
 ew *imgV;
 xinxiLab;
 rongzizhutiLab;
 guanjianciLab;
 gerenLab;
 shijianLab;
 */
    self.titleLab.text = model.title;
    //  itemTypeId：项目类别Id(1文化金融；2融资；3出租；4求租)
    NSInteger i = [model.itemTypeId integerValue];
    switch (i) {
        case 1:
        {
            self.danweiLab.text  = model.ziduan1;
            self.keywordsLab.text = model.ziduan2;

            self.chanpinLab.text = @"金融产品";
            self.faxingdanweiLab.text = @"发行单位：";
            self.guanjianciLab.text = @"关键词：";
//            self.rongzizhutiLab.text = @"发行单位：";
        }
            break;
        case 2:
        {
            self.danweiLab.text  = model.ziduan1;
            self.keywordsLab.text = model.ziduan2;

            self.chanpinLab.text = @"融资需求";
            self.faxingdanweiLab.text = @"融资主体：";
            self.guanjianciLab.text = @"关键词：";
//            self.rongzizhutiLab.text = @"融资主体：";
        }
            break;
        case 3:
        {
            self.danweiLab.text  = [NSString stringWithFormat:@"%@（元/日）",model.ziduan1];
            self.keywordsLab.text = [NSString stringWithFormat:@"%@（㎡）",model.ziduan2];
            self.chanpinLab.text = @"办公出租";
            self.faxingdanweiLab.text = @"日租金：";
            self.guanjianciLab.text = @"面积：";
//            self.rongzizhutiLab.text = @"办公空间出租：";
        }
            break;
        case 4:
        {
            self.danweiLab.text  = [NSString stringWithFormat:@"%@（元/日）",model.ziduan1];
            self.keywordsLab.text = [NSString stringWithFormat:@"%@（㎡）",model.ziduan2];
            self.chanpinLab.text = @"办公求租";
            self.faxingdanweiLab.text = @"日租金：";
            self.guanjianciLab.text = @"面积：";
//            self.rongzizhutiLab.text = @"日租金：";
        }
            break;
            
        default:
            break;
    }
    
//    (1文化金融；2融资；3出租；4求租)
    NSInteger j = [model.fujianItemTypeId integerValue];
    switch (j) {
        case 1:
        {
            self.keyWordsLabel.text = model.fujianZiduan2;
            self.gerenLab.text = model.fujianZiduan1;
            self.rongzizhutiLab.text = @"发行单位：";
            self.guanjianciLabel.text = @"关键词：";
            
        }
            break;
        case 2:
        {
            self.keyWordsLabel.text = model.fujianZiduan2;
            self.gerenLab.text = model.fujianZiduan1;
            self.rongzizhutiLab.text = @"融资主体：";
            self.guanjianciLabel.text = @"关键词：";
            
        }
            break;
        case 3:
        {
            self.keyWordsLabel.text = [NSString stringWithFormat:@"%@（㎡）",model.fujianZiduan2];
            self.gerenLab.text = [NSString stringWithFormat:@"%@（元/日）",model.fujianZiduan1];
            self.rongzizhutiLab.text = @"日租金：";
            self.guanjianciLabel.text = @"面积：";
            
        }
            break;
        case 4:
        {
            self.keyWordsLabel.text = [NSString stringWithFormat:@"%@（㎡）",model.fujianZiduan2];
            self.gerenLab.text = [NSString stringWithFormat:@"%@（元/日）",model.fujianZiduan1];

            self.rongzizhutiLab.text = @"日租金：";
            self.guanjianciLabel.text = @"面积：";
            
        }
            break;
            
        default:
            break;
    }

    
    
    
    
    
//    self.danweiLab.text  = model.ziduan1;
//    self.keywordsLab.text = model.ziduan2;
    NSString *detailTime = [self cutAndReplaceDate:model.regDate][1];
    NSString *subStr = [detailTime substringToIndex:detailTime.length - 3];
    self.faqishijianLab.text = [NSString stringWithFormat:@"%@  %@",[self cutAndReplaceDate:model.regDate][0],subStr];
    self.yuanquLab.text = [NSString stringWithFormat:@" %@ ",model.userTypeName];
    self.yuetanneirongLab.text = model.remark;
    self.xinxiLab.text = model.fujianTitle;
    
//    self.keyWordsLabel.text = model.fujianZiduan2;
//    
//    self.gerenLab.text = model.fujianZiduan1;
//    self.shijianLab.text = model.fujianRegDate;
    if (model.fujianRegDate.length) {
        NSString *riqi = [self cutAndReplaceDate:model.fujianRegDate][0];
        NSString *shijian = [self cutAndReplaceDate:model.fujianRegDate][1];
        self.shijianLab.text = [NSString stringWithFormat:@"%@  %@",riqi,[shijian substringToIndex:shijian.length - 3]];
    }
    
    
//    [self.imgV setHidden:YES];
//    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.fujianImgPath]placeholderImage:[UIImage imageNamed:@"文化金融产品列表"]];
    
    //使用中间imageView下载图片,下载之后将图片赋值给btn
//    UIImageView *plaveV = [[UIImageView alloc]init];
//    
//    [plaveV sd_setImageWithURL:[NSURL URLWithString:model.fujianImgPath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//        UIImage *img = plaveV.image;
//        self.imgV = plaveV.image;
//        [self.imgVBtn setBackgroundImage:img forState:UIControlStateNormal];
//        
//        [self.imgVBtn addTarget:self action:@selector(btnCLick) forControlEvents:UIControlEventTouchUpInside];
//    }];
    
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.fujianImgPath]placeholderImage:[UIImage imageNamed:@"占位"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        UIImage *img = self.imgV.image;
       
        [self.imgVBtn setBackgroundImage:img forState:UIControlStateNormal];
        
        [self.imgVBtn addTarget:self action:@selector(btnCLick) forControlEvents:UIControlEventTouchUpInside];
    }];

    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toDetailController)];
    
    [self.itemCell addGestureRecognizer:tap];
    
    self.modelFaQi = model;
    
}

-(void)toDetailController{
    
    if (_delegate && [_delegate respondsToSelector:@selector(pushToDetailViewController:)]) {
        [_delegate pushToDetailViewController:self.modelFaQi];
    }
    
}




-(void)btnCLick{
    NSLog(@"dasfaoisjiogera");
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



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
