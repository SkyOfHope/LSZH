//
//  LSMyReceiveAppontmentDetailCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/6/13.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSShouDaoDetailModel.h"




@protocol LSMyReceiveAppontmentDetailCellDelegate <NSObject>

-(void)pushToDetailController:(LSShouDaoDetailModel*)model;

@end


@interface LSMyReceiveAppontmentDetailCell : UITableViewCell

@property (strong, nonatomic) id<LSMyReceiveAppontmentDetailCellDelegate> delegate;

- (void)buildShouDaoDetailWithShouDaoDetailModel:(LSShouDaoDetailModel *)model2;


@end
