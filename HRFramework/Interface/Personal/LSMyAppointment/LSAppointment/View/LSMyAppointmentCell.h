//
//  LSMyAppointmentCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/20.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSyuetanModel.h"
#import "LSSendYueTanModel.h"
@interface LSMyAppointmentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *chakanBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *ziduan1;

@property (weak, nonatomic) IBOutlet UILabel *guanjianciLab;

@property (weak, nonatomic) IBOutlet UILabel *zhutiLab;
@property (weak, nonatomic) IBOutlet UILabel *keywordsLab;
@property (weak, nonatomic) IBOutlet UILabel *xuqiuLab;

//@property (weak, nonatomic) IBOutlet UIButton *RongZiBtn;

@property (weak, nonatomic) IBOutlet UIButton *RongZiBtn;


-(void)buildingShouDaoYueTanWithModle:(LSyuetanModel *)model;
- (void)buildingfaqiYueTanWithModel:(LSSendYueTanModel *)model;
@end
