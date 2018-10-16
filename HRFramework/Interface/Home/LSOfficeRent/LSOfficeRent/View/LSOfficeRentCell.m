//
//  LSOfficeRentCell.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/23.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSOfficeRentCell.h"

#import "LSSendAppointmentViewController.h"

@interface LSOfficeRentCell()
@property (weak, nonatomic) IBOutlet UILabel *biaoJiLabel;
@property (weak, nonatomic) IBOutlet UILabel *bJTitleLabel;


@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *rentMoneyLabel;
@property (strong, nonatomic) IBOutlet UILabel *sizeLabel;
@property (strong, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *regDataLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UIButton *appointment;


@property (weak, nonatomic) IBOutlet UILabel *userType;

@end

@implementation LSOfficeRentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(LSGetItemRentHouseListModel *)model {
    _model = model;
}

-(void)buildingWithModel:(LSGetItemRentHouseListModel *)model{
    
    self.titleLabel.hidden = NO;
    self.biaoJiLabel.hidden = YES;
    self.bJTitleLabel.hidden = YES;
    
    self.titleLabel.text = model.title;
    self.rentMoneyLabel.text = model.rizujin;
    self.addressLabel.text = model.address;
    self.sizeLabel.text = model.size;
    self.viewCountLabel.text = model.viewCount;
    self.regDataLabel.text = [self cutAndReplaceDate:model.regDate][0];
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"文化金融产品列表"]];
    
    self.paraDict = [NSMutableDictionary dictionary];
    [self.paraDict setObject:model.userId forKey:@"toUserId"];
    [self.paraDict setObject:model.rentId forKey:@"itemId"];
    [self.paraDict setObject:@"3" forKey:@"itemTypeId"];

    [self.img sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"占位"]];
    
    self.userType.text = model.userTypeName;

    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userdefault objectForKey:@"userId"];
    
    if ([model.userId isEqualToString:userId]) {
        [self.appointment setHidden:YES];
    }else{
        [self.appointment setHidden:NO];
    }
    
}

-(void)buildingWithGetItemRentHouseTJModel:(LSGetItemRentHouseTJModel *)modelTJ{
    
    self.titleLabel.hidden = YES;
    self.biaoJiLabel.hidden = NO;
    self.bJTitleLabel.text = modelTJ.title;
    self.bJTitleLabel.hidden = NO;
    
    
    self.titleLabel.text = modelTJ.title;
    self.rentMoneyLabel.text = modelTJ.rizujin;
//    self.addressLabel.text = modelTJ.city;
    self.sizeLabel.text = modelTJ.size;
    self.viewCountLabel.text = modelTJ.viewCount;
    self.regDataLabel.text = [self cutAndReplaceDate:modelTJ.regDate][0];
//    [self.img sd_setImageWithURL:[NSURL URLWithString:modelTJ.imgPath] placeholderImage:[UIImage imageNamed:@"文化金融产品列表"]];
    
    self.paraDict = [NSMutableDictionary dictionary];
    [self.paraDict setObject:modelTJ.userId forKey:@"toUserId"];
    [self.paraDict setObject:modelTJ.rentId forKey:@"itemId"];
    [self.paraDict setObject:@"3" forKey:@"itemTypeId"];
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:modelTJ.imgPath] placeholderImage:[UIImage imageNamed:@"占位"]];
    
    self.userType.text = modelTJ.userTypeName;
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userdefault objectForKey:@"userId"];
    
    if ([modelTJ.userId isEqualToString:userId]) {
        [self.appointment setHidden:YES];
    }else{
        [self.appointment setHidden:NO];
    }

    
    
}




//cell约谈按钮
- (IBAction)apponitmentBtn:(UIButton *)sender {
    
    LSSendAppointmentViewController *sendVC = [[LSSendAppointmentViewController alloc]initWithNibName:@"LSSendAppointmentViewController" bundle:nil];

    sendVC.paraDict = self.paraDict;
    
    [self.viewController.navigationController pushViewController:sendVC animated:YES];
    
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
