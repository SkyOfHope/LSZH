//
//  LSAppointmentSelectedChooseCellTableViewCell.h
//  LSZH
//
//  Created by apple  on 16/6/30.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSSelectMeetItemListModel.h"


@protocol LSAppointmentSelectedChooseCellTableViewCellDelegate <NSObject>

//点击删除按钮之后删除发送约谈界面的cell,相当与删除数组模型并刷新
-(void)deleteSoureArrayWhichElement;

@end

@interface LSAppointmentSelectedChooseCellTableViewCell : UITableViewCell


-(void)buildingFinancingWithModel:(LSSelectMeetItemListModel *)model;

-(void)buildingJinRongWithModel:(LSSelectMeetItemListModel *)model;

-(void)buildingRentHouseWithModel:(LSSelectMeetItemListModel *)model;


@property (weak, nonatomic) id<LSAppointmentSelectedChooseCellTableViewCellDelegate> delegate;


@end

