//
//  LSMyReceiveAppontmentDetailCell.m
//  LSZH
//
//  Created by risenb-ios5 on 16/6/13.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSMyReceiveAppontmentDetailCell.h"

@interface LSMyReceiveAppontmentDetailCell()


@property (weak, nonatomic) IBOutlet UIView *lastView;


@property (strong, nonatomic) IBOutlet UIImageView *headImg;
//因为缩放原因,headImg不使用,上层覆盖按钮
@property (weak, nonatomic) IBOutlet UIButton *headImgBtn;


@property (strong, nonatomic) IBOutlet UILabel *organizationNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *mobileLabel;
@property (strong, nonatomic) IBOutlet UILabel *sendDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *remarkLabel;
@property (strong, nonatomic) IBOutlet UIButton *userTypeNameBtn;




@property (weak, nonatomic) IBOutlet UILabel *chanpinLab;
@property (weak, nonatomic) IBOutlet UILabel *guanjianciLab;
@property (weak, nonatomic) IBOutlet UILabel *faxingdanweiLab;



@property (weak, nonatomic) IBOutlet UILabel *keywordsLab;
@property (weak, nonatomic) IBOutlet UILabel *faqishijianLab;
@property (weak, nonatomic) IBOutlet UILabel *danweiLab;
@property (weak, nonatomic) IBOutlet UILabel *fujianTitle;


@property (weak, nonatomic) IBOutlet UIView *theLastViewMayBeHideen;

//@property (weak, nonatomic) IBOutlet UILabel *rongzizhutiLab;

@property (weak, nonatomic) IBOutlet UIView *itemCell;

@property (strong, nonatomic) LSShouDaoDetailModel *model;


@property (weak, nonatomic) IBOutlet UILabel *itemTypeLab;

@end


@implementation LSMyReceiveAppontmentDetailCell

- (void)awakeFromNib {
    // Initialization code
    
    
    //头像切圆
    self.headImg.layer.cornerRadius = 27.5;
    self.headImg.layer.masksToBounds = YES;
    
    
}


- (void)buildShouDaoDetailWithShouDaoDetailModel:(LSShouDaoDetailModel *)model2 {
    
    if ([model2.fujianItemId isEqualToString:@"0"]) {
        self.itemCell.hidden = YES;
    }else{
        self.itemCell.hidden = NO;
    }
    
    //  itemTypeId：项目类别Id(1文化金融；2融资；3出租；4求租)
    NSInteger i = [model2.fujianItemTypeId integerValue];
    
    switch (i) {
        case 1:
        {
            self.danweiLab.text  = model2.fujianZiduan1;
            self.keywordsLab.text = model2.fujianZiduan2;
            self.chanpinLab.text = @"文化金融";
            self.faxingdanweiLab.text = @"发行单位：";
            self.guanjianciLab.text = @"关键词：";
//            self.rongzizhutiLab.text = @"发行单位";
        }
            break;
        case 2:
        {
            self.danweiLab.text  = model2.fujianZiduan1;
            self.keywordsLab.text = model2.fujianZiduan2;
            self.chanpinLab.text = @"融资主体";
            self.faxingdanweiLab.text = @"融资主体：";
            self.guanjianciLab.text = @"关键词：";
//            self.rongzizhutiLab.text = @"融资主体";
        }
            break;
        case 3:
        {
            self.danweiLab.text  = [NSString stringWithFormat:@"%@（元/日）",model2.fujianZiduan1];
            self.keywordsLab.text = [NSString stringWithFormat:@"%@（㎡）",model2.fujianZiduan2];
            self.chanpinLab.text = @"办公出租";
            self.faxingdanweiLab.text = @"日租金（元/日）：";
            self.guanjianciLab.text = @"面积（㎡）：";
//            self.rongzizhutiLab.text = @"办公空间出租";
        }
            break;
        case 4:
        {
            self.danweiLab.text  = [NSString stringWithFormat:@"%@（元/日）",model2.fujianZiduan1];
            self.keywordsLab.text = [NSString stringWithFormat:@"%@（㎡）",model2.fujianZiduan2];
            self.chanpinLab.text = @"办公求租";
            self.faxingdanweiLab.text = @"日租金：";
            self.guanjianciLab.text = @"面积：";
//            self.rongzizhutiLab.text = @"日租金";
        }
            break;
            
        default:
            break;
    }
    
    //必传字段
    self.itemTypeLab.text = model2.fujianItemTypeName;

    self.organizationNameLabel.text = model2.organizationName;
    self.nameLabel.text = model2.name;
    self.mobileLabel.text = model2.mobile;
    
    //时间不要秒
    NSString *subStr = [model2.sendDate substringToIndex:model2.sendDate.length - 3];
//    self.sendDateLabel.text = subStr;
    self.sendDateLabel.text = [self cutAndReplaceDate:subStr];
    
    
//    self.userTypeNameBtn.titleLabel.text = model2.userTypeName;
    [self.userTypeNameBtn setTitle:model2.userTypeName forState:UIControlStateNormal];
    
    
    self.remarkLabel.text = model2.remark;
    //如果有返回的头像url
//    [self.headImg sd_setImageWithURL:[NSURL URLWithString:model2.headImg] placeholderImage:[UIImage imageNamed:@"占位"]];
    if (model2.headImg.length > 0) {
        
        [self.headImg setHighlighted:YES];
        
        
        [self.headImg sd_setImageWithURL:[NSURL URLWithString:model2.headImg] placeholderImage:[UIImage imageNamed:@"占位"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [self.headImgBtn setBackgroundImage:self.headImg.image forState:UIControlStateNormal];
        }];

        
//        UIImageView *placeV = [[UIImageView alloc]init];
//        
//        [placeV sd_setImageWithURL:[NSURL URLWithString:model2.headImg] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            [self.headImgBtn setBackgroundImage:placeV.image forState:UIControlStateNormal];
//        }];
    }
    
    self.headImgBtn.layer.cornerRadius = self.headImgBtn.frame.size.width / 2;
    self.headImgBtn.layer.masksToBounds = YES;
    
    //如果有附件项目则添加附件项目,否则不添加
    
    if (model2.fujianTitle.length > 0) {

        self.fujianTitle.text = model2.fujianTitle;
//        self.danweiLab.text  = model2.fujianZiduan1;
//        self.keywordsLab.text = model2.fujianZiduan2;
//        self.faqishijianLab.text = model2.fujianRegDate;
//        self.faqishijianLab.text = [self cutAndReplaceDate:model2.fujianRegDate];
        self.faqishijianLab.text = [[self cutAndReplaceDate:model2.fujianRegDate] substringToIndex:[self cutAndReplaceDate:model2.fujianRegDate].length - 3];
        //此外还有
        /*
         @property (nonatomic, copy)NSString *fujianItemTypeId;
         @property (nonatomic, copy)NSString *fujianItemId;
         @property (nonatomic, copy)NSString *fujianImgPath;
         @property (nonatomic, copy)NSString *fujianZiduan3;
         未使用
         */
    }else{
        [self.theLastViewMayBeHideen setHidden:YES];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toDetileController)];
    
    [self.itemCell addGestureRecognizer:tap];
    
    self.model = model2;
    
}

-(void)toDetileController{

    if ([self.delegate respondsToSelector:@selector(pushToDetailController:)]) {
        [self.delegate pushToDetailController:self.model];
    }

}

//截取时间字符串
//0为日期 1为时间
-(NSString*)cutAndReplaceDate:(NSString *)date{
    
//    NSArray *arr = [date componentsSeparatedByString:@""];
//    
//    NSString *dateStr = [arr[0] stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    NSString *dateStr = [date stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    return dateStr;
    
}


//替换字符串

-(NSString*)cutStr:(NSString *)str{
    
    NSString *newStr = [str stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    return newStr;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
