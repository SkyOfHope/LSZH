//
//  LSCultureFinanceCell.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/21.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSCultureFinanceCell.h"

#import "LSSendAppointmentViewController.h"




#import "LSGetItemFinancingListModel.h"
#import "LSGetItemJinRongListModel.h"
@interface LSCultureFinanceCell()

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *appointmentBtn;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *rongziZhutiLabel;
@property (strong, nonatomic) IBOutlet UILabel *keywordLabel;
@property (strong, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *regDateLabel;

@property (weak, nonatomic) IBOutlet UIButton *userType;


@property (strong, nonatomic) NSString *identifier;


@property (weak, nonatomic) IBOutlet UIButton *apponintment;




@end

@implementation LSCultureFinanceCell

-(void)buildingGetItemFinancingWithModel:(LSGetItemFinancingListModel *)model{
    
    self.titleLabel.text = model.title;
    self.rongziZhutiLabel.text = model.rongziZhuti;
    self.keywordLabel.text = model.keyword;
    self.viewCountLabel.text = model.viewCount;
    self.regDateLabel.text = [self cutAndReplaceDate:model.regDate][0];
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.imgPath]placeholderImage:[UIImage imageNamed:@"占位"]];
    
    //保存cell 内数据 需要传到下一个界面的参数
    self.cellForSendDict = [NSMutableDictionary dictionary];
    //保存的键值对 ：itemTypeId itemId toUserId
    
    [self.cellForSendDict setObject:model.userId forKey:@"toUserId"];
    [self.cellForSendDict setObject:model.financingId forKey:@"itemId"];
    [self.cellForSendDict setObject:@"1" forKey:@"itemTypeId"];
    
    [self.userType setTitle:model.userTypeName forState:UIControlStateNormal];
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userdefault objectForKey:@"userId"];
    
    if ([model.userId isEqualToString:userId]) {
        [self.apponintment setHidden:YES];
    }
    else
    {
        [self.apponintment setHidden:NO];
    }
    
}

-(void)buildingGetItemJinRongWithModel:(LSGetItemJinRongListModel *)model{
    
    self.titleLabel.text = model.title;
    NSLog(@"%@", model.unit);
    self.rongziZhutiLabel.text = model.unit;
    self.keywordLabel.text = model.keyword;
    self.viewCountLabel.text = model.viewCount;
    self.regDateLabel.text = [self cutAndReplaceDate:model.regDate][0];
    
    //保存cell 内数据 需要传到下一个界面的参数
    self.cellForSendDict = [NSMutableDictionary dictionary];
    //保存的键值对 ：itemTypeId itemId toUserId
    
    [self.cellForSendDict setObject:model.userId forKey:@"toUserId"];
    [self.cellForSendDict setObject:model.jinrongId forKey:@"itemId"];
    [self.cellForSendDict setObject:@"1" forKey:@"itemTypeId"];
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.imgPath]placeholderImage:[UIImage imageNamed:@"占位"]];
    [self.userType setTitle:model.userTypeName forState:UIControlStateNormal];
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userdefault objectForKey:@"userId"];
    
    if ([model.userId isEqualToString:userId]) {
        [self.apponintment setHidden:YES];
    }else
    {
        [self.apponintment setHidden:NO];
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

- (IBAction)appointmentBtnAction:(UIButton *)sender {
    

        
        LSSendAppointmentViewController *sendVC = [[LSSendAppointmentViewController alloc] init] ;
        
        sendVC.paraDict = self.cellForSendDict;
        
        [self.viewController.navigationController pushViewController:sendVC animated:YES];

    
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
