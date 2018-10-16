//
//  LSAppointmentChooseCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSSelectMeetItemListModel.h"


@protocol LSAppointmentChooseCellDelegate <NSObject>

//点击删除按钮之后删除发送约谈界面的cell,相当与删除数组模型并刷新
-(void)deleteSoureArrayWhichElement;

@end

@interface LSAppointmentChooseCell : UITableViewCell


-(void)buildingFinancingWithModel:(LSSelectMeetItemListModel *)model;

-(void)buildingJinRongWithModel:(LSSelectMeetItemListModel *)model;

-(void)buildingRentHouseWithModel:(LSSelectMeetItemListModel *)model;

-(void)buildingWantHouseModel:(LSSelectMeetItemListModel *)model;

//标记属性,标记了右下角的按钮应该是什么状态,执行什么操作

@property (strong, nonatomic) NSString *shouleToDoWhatAction;


/*
 隐藏 / 删除 / 正常
 */

//根据传入的字符串改变按钮的状态以及所执行的操作

@property (weak, nonatomic) IBOutlet UIButton *stateBtn;


@property (weak, nonatomic) id<LSAppointmentChooseCellDelegate> delegate;


@end
