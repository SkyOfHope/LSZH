
//
//  LSMyReceiveAppointmentListCell.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSMyReceiveAppointmentListCell.h"

#import "LSShouDaoYueTanModel.h"

#import "UIImageView+WebCache.h"

//#import "LSAppointmentDetailViewController"

#import "LSAppointmentDetailViewController.h"

@interface LSMyReceiveAppointmentListCell ()
//图片
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
//标题
@property (weak, nonatomic) IBOutlet UILabel *title;
//联系人
@property (weak, nonatomic) IBOutlet UILabel *contactPerson;
//联系电话
@property (weak, nonatomic) IBOutlet UILabel *contactPhone;
//时间
@property (weak, nonatomic) IBOutlet UILabel *time;
//发帖类型
@property (weak, nonatomic) IBOutlet UILabel *documentType;
//详细信息按钮
- (IBAction)detailBtn:(UIButton *)sender;

@end


@implementation LSMyReceiveAppointmentListCell


    /*
     @property (nonatomic, copy)NSString *userId;
     @property (nonatomic, copy)NSString *userTypeId;
     @property (nonatomic, copy)NSString *userTypeName;
     */
//    [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.shoudaoyuetan.headImg]];
//    self.title.text = shoudaoyuetan.name;
//    self.contactPerson.text = shoudaoyuetan.realName;
//    self.contactPhone.text = shoudaoyuetan.mobile;
//    self.time.text = shoudaoyuetan.maxDate;
//    self.documentType.text = shoudaoyuetan.userTypeName;


-(void)setShoudaoyuetan:(LSShouDaoYueTanModel *)shoudaoyuetan{
    /*
     userId：发送约谈用户的Id
     headImg：头像
     name：联系人姓名
     realName：真实姓名
     mobile：联系电话
     userTypeId：用户类别Id（1园区）
     userTypeName：用户类别名称
     maxDate：用户发送约谈的时间
     */
    _shoudaoyuetan = shoudaoyuetan;

//        self.title.text = @"未知企业";
    if (shoudaoyuetan.organizationName != nil) {
        self.title.text = shoudaoyuetan.organizationName;
    }
//    self.contactPerson.text = @"未知";
    if (shoudaoyuetan.name != nil) {
        self.contactPerson.text = shoudaoyuetan.name;
    }

    self.contactPhone.text = shoudaoyuetan.mobile;
    
    self.time.text = [self cutAndReplaceDate:shoudaoyuetan.maxDate][0];
    
    self.documentType.text = shoudaoyuetan.userTypeName;

    self.headImage.layer.cornerRadius = self.headImage.frame.size.width/2;
    self.headImage.layer.masksToBounds = YES;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:shoudaoyuetan.headImg] placeholderImage:[UIImage imageNamed:@"占位"]];
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




- (IBAction)detailBtn:(UIButton *)sender {
    
    [self.delegate toDetailContrillerWithModel:self.shoudaoyuetan];
    
}
@end
