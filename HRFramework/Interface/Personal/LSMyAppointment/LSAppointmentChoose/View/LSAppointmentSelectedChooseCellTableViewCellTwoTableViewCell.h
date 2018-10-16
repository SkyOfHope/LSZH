//
//  LSAppointmentSelectedChooseCellTableViewCellTwoTableViewCell.h
//  LSZH
//
//  Created by apple  on 16/7/30.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSSelectMeetItemListModel.h"


@protocol LSAppointmentSelectedChooseCellTwoTableViewCellDelegate <NSObject>

//点击删除按钮之后删除发送约谈界面的cell,相当与删除数组模型并刷新
-(void)deleteSoureArrayWhichElement;

@end


@interface LSAppointmentSelectedChooseCellTableViewCellTwoTableViewCell : UITableViewCell

@property (weak, nonatomic) id<LSAppointmentSelectedChooseCellTwoTableViewCellDelegate> delegate;


@property (strong, nonatomic) LSSelectMeetItemListModel *model;


@end
