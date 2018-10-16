//
//  LSMyAppointmentCell.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/20.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSMyAppointmentCell.h"

#import "LSSendYueTanModel.h"

@interface  LSMyAppointmentCell()

@property (strong, nonatomic) IBOutlet UIImageView *redPointImg;

@property (strong, nonatomic) IBOutlet UILabel *timelabel;

@property (weak, nonatomic) IBOutlet UIImageView *timeImg;
@property (weak, nonatomic) IBOutlet UILabel *timeImgLabel;

@property (weak, nonatomic) IBOutlet UILabel *SendTLabel;


@end


@implementation LSMyAppointmentCell

- (void)awakeFromNib {
    // Initialization code
    
}

//两个字段对应不同 模型 需要进行区分
-(void)buildingShouDaoYueTanWithModle:(LSyuetanModel *)model {
    
    self.SendTLabel.hidden = YES;
    self.timeLab.hidden = YES;
    self.timeImgLabel.hidden = NO;
    self.timeImg.hidden = NO;
    
    self.timeImgLabel.text = [self cutAndReplaceDate:model.regDate][0];
    
    self.zhutiLab.text = model.ziduan1;
    
    self.timelabel.text = model.maxDate;
//    self.timelabel.text = @"";
    self.timelabel.textColor = RGB(153, 153, 153);
    
//    self.RongZiBtn.titleLabel.text = model.userTypeName;
    [self.RongZiBtn setTitle:model.itemTypeName forState:UIControlStateNormal];
    if ([model.isWeiDu integerValue] > 0) {
        
        self.redPointImg.hidden = NO;
    } else {
        
        self.redPointImg.hidden = YES;
    }
    
    //  itemTypeId：项目类别Id(1文化金融；2融资；3出租；4求租)
    NSInteger i = [model.itemTypeId integerValue];
    switch (i) {
        case 1:
        {
            self.xuqiuLab.text = @"文化金融:";
            self.guanjianciLab.text = @"关键词:";
            self.keywordsLab.text = model.ziduan2;
            self.ziduan1.text = @"发行单位:";
        }
            break;
        case 2:
        {
            self.xuqiuLab.text = @"融资:";
            self.guanjianciLab.text = @"关键词:";
            self.keywordsLab.text = model.ziduan2;
            self.ziduan1.text = @"融资主体:";
        }
            break;
        case 3:
        {
            self.xuqiuLab.text = @"办公出租:";
            self.guanjianciLab.text = @"面积:";
            self.keywordsLab.text = [NSString stringWithFormat:@"%@M²",model.ziduan2];
            self.ziduan1.text = @"日租金:";
            self.zhutiLab.text = [NSString stringWithFormat:@"%@元/日",model.ziduan1];
        }
            break;
        case 4:
        {
            self.xuqiuLab.text = @"办公求租:";
            self.guanjianciLab.text = @"面积:";
            self.keywordsLab.text = [NSString stringWithFormat:@"%@M²",model.ziduan2];
            self.ziduan1.text = @"日租金:";
            self.zhutiLab.text = [NSString stringWithFormat:@"%@元/日",model.ziduan1];
        }
            break;
            
        default:
            break;
    }
    
    self.titleLab.text = model.title;
    

}

- (void)buildingfaqiYueTanWithModel:(LSSendYueTanModel *)model {
    /*
     列表集合数据（成功时返回），属性说明如下：
     meetId：标识Id
     itemTypeId：项目类别ID(1文化金融；2融资；3出租；4求租；)
     itemId：项目ID
     title：项目标题
     ImgPath：图片地址
     zidu1：字段1（文化金融显示为发行单位、融资显示为融资主体、办公空间出租和求租显示为日租金）
     ziduan2：字段2（文化金融和融资显示为关键字、办公空间出租和求租显示为面积）
     ziduan3：字段3（文化金融和融资显示为空、办公空间出租和求租显示为地理位置）
     regDate：发送时间
     state：查看状态
     
     
     */
    
    self.SendTLabel.hidden = NO;
    self.timeLab.hidden = NO;
    self.timeImgLabel.hidden = YES;
    self.timeImg.hidden = YES;
    
    NSString *detailTime = [self cutAndReplaceDate:model.sendDate][1];
    NSString *subStr =[detailTime substringToIndex:detailTime.length - 3];
    self.timeLab.text = [NSString stringWithFormat:@"%@  %@",[self cutAndReplaceDate:model.sendDate][0],subStr];
    
    [self.RongZiBtn setTitle:model.itemTypeName forState:UIControlStateNormal];

    self.zhutiLab.text = model.ziduan1;
    
    if ([model.state isEqualToString:@"未查看"]) {
        
//        self.redPointImg.hidden = NO;
        self.timelabel.textColor = RGB(0, 122, 255);
        self.timelabel.text = @"未查看";
    }else if ([model.state isEqualToString:@"已查看"]){
        
//        self.redPointImg.hidden = YES;
        self.timelabel.textColor = RGB(255, 174, 0);
        self.timelabel.text = @"已查看";
    }
    //以下两句取代上面的判断,因为我发起的约谈界面没有已查看或未查看
    
//    self.timelabel.hidden = YES;
    
    
    
//    if ([model.isWeiDu isEqual:@"1"]) {
//        [self.chakanBtn setTitle:@"未查看" forState:UIControlStateNormal];
//    } else {
        [self.chakanBtn setTitle:model.state forState:UIControlStateNormal];
//    }
    
    //  itemTypeId：项目类别Id(1文化金融；2融资；3出租；4求租)
    self.redPointImg.hidden = YES;//不可删除
    NSInteger i = [model.itemTypeId integerValue];
    switch (i) {
        case 1:
        {
            
            self.xuqiuLab.text = @"文化金融:";
            self.guanjianciLab.text = @"关键词:";
            self.keywordsLab.text = model.ziduan2;
            self.ziduan1.text = @"发行单位:";
        }
            break;
        case 2:
        {
            self.xuqiuLab.text = @"融资:";
            self.guanjianciLab.text = @"关键词:";
            self.keywordsLab.text = model.ziduan2;
            self.ziduan1.text = @"融资主体:";
        }
            break;
        case 3:
        {
            self.xuqiuLab.text = @"办公出租:";
            self.guanjianciLab.text = @"面积:";
            self.keywordsLab.text = [NSString stringWithFormat:@"%@M²",model.ziduan2];
            self.ziduan1.text = @"日租金:";
            self.zhutiLab.text = [NSString stringWithFormat:@"%@元/日",model.ziduan1];
        }
            break;
        case 4:
        {
            self.xuqiuLab.text = @"办公求租:";
            self.guanjianciLab.text = @"面积:";
            self.keywordsLab.text = [NSString stringWithFormat:@"%@M²",model.ziduan2];
            self.ziduan1.text = @"日租金:";
            self.zhutiLab.text = [NSString stringWithFormat:@"%@元/日",model.ziduan1];
        }
            break;
            
        default:
            break;
    }
    self.titleLab.text = model.title;
    
//    self.timeLab.text = [self cutStr:model.regDate];
   
//    self.timeLab.text = model.regDate;
//    self.titleLab.text = model.title;
//    [self.chakanBtn setTitle:model.state forState:UIControlStateNormal];
////    self.zhutiLab.text = model.userTypeName;
//    self.keywordsLab.text = model.ziduan2;
////    self.xuqiuLab.text = model.userTypeName;
//
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

//替换字符串

-(NSString*)cutStr:(NSString *)str{
    
    NSString *newStr = [str stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    return newStr;
}





@end
