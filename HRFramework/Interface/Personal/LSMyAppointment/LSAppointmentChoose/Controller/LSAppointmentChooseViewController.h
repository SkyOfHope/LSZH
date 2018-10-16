//
//  LSAppointmentChooseViewController.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "HRBaseViewController.h"

@class LSSelectMeetItemListModel;

@interface LSAppointmentChooseViewController : HRBaseViewController

@property (nonatomic,copy) void (^sendCellModle) (LSSelectMeetItemListModel *cellmodel);

@end
