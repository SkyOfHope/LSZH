//
//  LSMyReceiveAppointmentCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSShouDaoYueTanModel;

@protocol  LSMyReceiveAppointmentListCellDelegate <NSObject>


-(void)toDetailContrillerWithModel:(LSShouDaoYueTanModel*)model;


@end


@interface LSMyReceiveAppointmentListCell : UITableViewCell

@property (strong, nonatomic) LSShouDaoYueTanModel *shoudaoyuetan;

@property (weak, nonatomic) id<LSMyReceiveAppointmentListCellDelegate> delegate;

@end
