//
//  LSNeedOfficeRentCell.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/23.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSNeedOfficeRentCell.h"

#import "LSSendAppointmentViewController.h"

@interface LSNeedOfficeRentCell()

@property (weak, nonatomic) IBOutlet UILabel *BiaojiLabel;
@property (weak, nonatomic) IBOutlet UILabel *BJTitleLabel;



@property (strong, nonatomic) IBOutlet UIImageView *eyeImageView;
@property (strong, nonatomic) IBOutlet UIImageView *whatchImageView;


@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *rizujinStartLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *regDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *sizeStartLabel;

@property (weak, nonatomic) IBOutlet UILabel *orginzetionType;



@end

@implementation LSNeedOfficeRentCell

-(void)buildingGetItemWantHouseWithModle:(LSGetItemWantHouseListModel *)model{
    
    self.titleLabel.hidden = NO;
    self.BiaojiLabel.hidden = YES;
    self.BJTitleLabel.hidden = YES;
    
    self.eyeImageView.image = [UIImage imageNamed:@"浏览人数"];
    self.whatchImageView.image = [UIImage imageNamed:@"时间"];
    self.eyeImageView.hidden = NO;
    self.whatchImageView.hidden = NO;
    
    self.titleLabel.text = model.title;
    
    //租金
    NSString *startZuJin = model.rizujinStart;
    NSString *endZuJin = model.rizujinEnd;
    self.rizujinStartLabel.text = [NSString stringWithFormat:@"%@-%@元/日",startZuJin,endZuJin];
    
    
    self.addressLabel.text = model.address;
    self.viewCountLabel.text = model.viewCount;
    self.regDateLabel.text =[self cutAndReplaceDate:model.regDate][0];
    //大小
    NSString *startSize = model.sizeStart;
    NSString *endSize = model.sizeEnd;
    self.sizeStartLabel.text = [NSString stringWithFormat:@"%@-%@ m²",startSize,endSize];
    
    
    self.paraDict = [NSMutableDictionary dictionary];
    [self.paraDict setObject:model.userId forKey:@"userId"];
    [self.paraDict setObject:model.wantId forKey:@"itemId"];
    [self.paraDict setObject:@"4" forKey:@"itemTypeId"];
    self.orginzetionType.text = model.userTypeName;
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userdefault objectForKey:@"userId"];
    
    if ([model.userId isEqualToString:userId]) {
        [self.appointmentBtn setHidden:YES];
    }else{
        [self.appointmentBtn setHidden:NO];
    }
    
    
}

-(void)buildingWithGetItemWantHouseTJModle:(LSGetItemWantHouseTJModel *)model{
    
    
    self.titleLabel.hidden = YES;
    self.BiaojiLabel.hidden = NO;
    self.BJTitleLabel.text = model.title;
    self.BJTitleLabel.hidden = NO;
    
    self.eyeImageView.image = [UIImage imageNamed:@"浏览人数"];
    self.whatchImageView.image = [UIImage imageNamed:@"时间"];
    self.eyeImageView.hidden = NO;
    self.whatchImageView.hidden = NO;
    
    self.titleLabel.text = model.title;
    
    //租金
    NSString *startZuJin = model.rizujinStart;
    NSString *endZuJin = model.rizujinEnd;
    self.rizujinStartLabel.text = [NSString stringWithFormat:@"%@-%@元/日",startZuJin,endZuJin];
    
    
    self.addressLabel.text = model.city;
    self.viewCountLabel.text = model.viewCount;
    self.regDateLabel.text =[self cutAndReplaceDate:model.regDate][0];
    //大小
    NSString *startSize = model.sizeStart;
    NSString *endSize = model.sizeEnd;
    self.sizeStartLabel.text = [NSString stringWithFormat:@"%@-%@ m²",startSize,endSize];
    
    
    self.paraDict = [NSMutableDictionary dictionary];
    [self.paraDict setObject:model.userId forKey:@"userId"];
    [self.paraDict setObject:model.wantId forKey:@"itemId"];
    [self.paraDict setObject:@"4" forKey:@"itemTypeId"];
    self.orginzetionType.text = model.userTypeName;
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userdefault objectForKey:@"userId"];
    
    if ([model.userId isEqualToString:userId]) {
        [self.appointmentBtn setHidden:YES];
    }else{
        [self.appointmentBtn setHidden:NO];
    }

    
}


-(void)buildingWantHouseWithModel:(LSGetCollectWantHouseList *)model{
    
    self.titleLabel.hidden = NO;
    self.BiaojiLabel.hidden = YES;
    self.BJTitleLabel.hidden = YES;
    
    self.eyeImageView.image = [UIImage imageNamed:@"浏览人数"];
    self.whatchImageView.image = [UIImage imageNamed:@"时间"];
    self.eyeImageView.hidden = NO;
    self.whatchImageView.hidden = NO;
    
    self.titleLabel.text = model.title;
//    self.rizujinStartLabel.text = model.rizujinStart;
    self.rizujinStartLabel.text = [NSString stringWithFormat:@"%@-%@元/日",model.rizujinStart,model.rizujinEnd];
    self.addressLabel.text = model.address;
    self.viewCountLabel.text = model.viewCount;
    self.regDateLabel.text = [self cutAndReplaceDate:model.regDate][0];
//    self.sizeStartLabel.text = model.sizeStart;
    self.sizeStartLabel.text = [NSString stringWithFormat:@"%@-%@㎡",model.sizeStart,model.sizeEnd];;
    [self.appointmentBtn setTitle:@"取消收藏" forState:UIControlStateNormal];

    
}

-(void)buildingWantHouseModel:(LSSelectMeetItemListModel *)model{
    
    self.titleLabel.hidden = NO;
    self.BiaojiLabel.hidden = YES;
    self.BJTitleLabel.hidden = YES;
    
    //    self.img =
    self.eyeImageView.image = [UIImage imageNamed:@"时间"];
    self.whatchImageView.image = [UIImage imageNamed:@"时间"];
    self.eyeImageView.hidden = NO;
    self.whatchImageView.hidden = YES;
    
    self.titleLabel.text = model.title;
    self.rizujinStartLabel.text = [NSString stringWithFormat:@"日租金:%@元/日",model.ziduan1];
    self.sizeStartLabel.text = [NSString stringWithFormat:@"%@㎡",model.ziduan2];
    self.addressLabel.text = model.ziduan3;
    self.viewCountLabel.text = [self cutAndReplaceDate:model.regDate][0];
    self.regDateLabel.text = @"";
    self.orginzetionType.text = @"办公求租";
    
    
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



- (IBAction)appointmentBtn:(UIButton *)sender {
    
    
    //如果按钮内容为取消约谈则按钮功能改变
    if ([self.appointmentBtn.titleLabel.text isEqualToString:@"取消收藏"]) {
        
        //得到参数 itemID 以及 itemTypeID
        NSMutableDictionary *para = [NSMutableDictionary dictionary];
        
        [para setObject:self.TypeIdentifier forKey:@"itemTypeId"];
        [para setObject:self.itemIdentifier forKey:@"itemId"];
        
        //得到用户ID
        NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
        
        [para setObject:userId forKey:@"userId"];
        
        
        //发送网络请求
        
        [[HRRequestManager manager]POST_PATH:PATH_CancelCollect para:para success:^(id responseObject) {
            
            NSDictionary *dict = responseObject;
            //如果后台返回数据正确，则执行代理方法，重新请求数据并刷新，否则，刷新失败
            if ([dict[@"success"] intValue] == 1) {

                [self.delegate cancelBtnForNeedOfficeItem:4];
            }else{
//                NSLog(@"取消失败，请重新操作");
            }
            
        } failure:^(NSError *error) {
            NSLog(@"网络请求发送失败");
        }];
        
    }else if ([self.appointmentBtn.titleLabel.text isEqualToString:@"约谈"]){
        
        LSSendAppointmentViewController *sendVC = [[LSSendAppointmentViewController alloc]initWithNibName:@"LSSendAppointmentViewController" bundle:nil];
        
        sendVC.paraDict = self.paraDict;
        
        
        [self.viewController.navigationController pushViewController:sendVC animated:YES];
        
    }else if ([self.btnStyleIdentifier isEqualToString:@"删除"]){
        
        if ([self.delegate respondsToSelector:@selector(deleteCellForSendYueTan)]) {
            [self.delegate deleteCellForSendYueTan];
        }
        
    }else{
        return;
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
