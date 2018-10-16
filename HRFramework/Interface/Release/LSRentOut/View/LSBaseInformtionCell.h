//
//  LSBaseInformtionCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/6/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LStotalCompeleteModel.h"

@protocol jibenxinxiDelegate <NSObject>

- (void)jibenxinxi:(LStotalCompeleteModel *)model;

@end

@interface LSBaseInformtionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *louyuTF;
@property (weak, nonatomic) IBOutlet UITextField *louhaotf;
@property (weak, nonatomic) IBOutlet UITextField *loucengTF;
@property (weak, nonatomic) IBOutlet UITextField *mianjiTF;
@property (weak, nonatomic) IBOutlet UITextField *chaoxiangTF;
@property (weak, nonatomic) IBOutlet UITextField *zhuangxiuTF;
@property (weak, nonatomic) IBOutlet UITextField *qizuTF;
@property (weak, nonatomic) IBOutlet UITextField *rizujinTF;
@property (weak, nonatomic) IBOutlet UITextField *yuezujinTF;
@property (weak, nonatomic) IBOutlet UITextField *mianzuqiTF;
@property (weak, nonatomic) IBOutlet UITextField *sheshiTF;
@property (weak, nonatomic) IBOutlet UITextField *diliweizhi;

@property (weak, nonatomic) IBOutlet UITextField *detailAddress;

@property (nonatomic, assign) id <jibenxinxiDelegate> delegate;

@end
