//
//  LSMyReceiveAppointmentListViewController.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "HRBaseViewController.h"

@interface LSMyReceiveAppointmentListViewController : HRBaseViewController

@property (nonatomic, copy)NSString *itemTypeId;
@property (nonatomic, copy)NSString *itemId;
//@property (nonatomic, copy)NSString *meetID;

@property (copy, nonatomic) void(^reloadRedPointBlock)();

@end
