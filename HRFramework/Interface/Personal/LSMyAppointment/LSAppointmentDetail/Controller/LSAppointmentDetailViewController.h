//
//  LSAppointmentDetailViewController.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/21.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "HRBaseViewController.h"
#import "LSSendYueTanModel.h"
#import "LSShouDaoYueTanModel.h"
@interface LSAppointmentDetailViewController : HRBaseViewController

@property (nonatomic, strong) NSString *style;

@property (nonatomic, copy) NSString *meetId;

//使用废弃 换为使用LSShouDaoYueTanModel.h
@property (nonatomic, copy)NSString *itemTypeId;
@property (nonatomic, copy)NSString *itemId;
//替换
@property (strong, nonatomic) LSShouDaoYueTanModel *chuanruCanshuShoudaoYueTan;

@property (copy, nonatomic) void(^appointmentBlock)();

@end
