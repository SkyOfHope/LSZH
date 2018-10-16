//
//  LSAppointmentDetailCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/21.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSFaQiDetailModel.h"

@protocol LSAppointmentDetailCellDelegate <NSObject>

-(void)pushToDetailViewController:(LSFaQiDetailModel*)model;

@end


@interface LSAppointmentDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *chanpinLab;
@property (weak, nonatomic) IBOutlet UILabel *faxingdanweiLab;
@property (weak, nonatomic) IBOutlet UILabel *danweiLab;


@property (weak, nonatomic) IBOutlet UILabel *keywordsLab;
@property (weak, nonatomic) IBOutlet UILabel *yuanquLab;
@property (weak, nonatomic) IBOutlet UILabel *faqishijianLab;
@property (weak, nonatomic) IBOutlet UILabel *yuetanneirongLab;

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
//imgV因为缩放改变使用上层btn

@property (weak, nonatomic) IBOutlet UIButton *imgVBtn;


@property (weak, nonatomic) IBOutlet UILabel *xinxiLab;
@property (weak, nonatomic) IBOutlet UILabel *rongzizhutiLab;
@property (weak, nonatomic) IBOutlet UILabel *guanjianciLab;
@property (weak, nonatomic) IBOutlet UILabel *gerenLab;
@property (weak, nonatomic) IBOutlet UILabel *shijianLab;


@property (weak, nonatomic) IBOutlet UILabel *guanjianciLabel;
@property (weak, nonatomic) IBOutlet UILabel *keyWordsLabel;




- (void)buildFaQiDetailWithFaQiDetailModel:(LSFaQiDetailModel *)model;



@property (strong,nonatomic) id<LSAppointmentDetailCellDelegate>delegate;





@end
