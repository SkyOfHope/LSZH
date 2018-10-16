//
//  LSNeedOfficeRentCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/23.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSGetItemWantHouseListModel.h"
#import "LSGetCollectWantHouseList.h"
#import "LSSelectMeetItemListModel.h"
#import "LSGetItemWantHouseTJModel.h"

@protocol LSNeedOfficeRentCellDelegate <NSObject>

-(void)cancelBtnForNeedOfficeItem:(NSInteger)itemIdentifier;

//用来删除发送约谈页面的cell使用
-(void)deleteCellForSendYueTan;

@end

@interface LSNeedOfficeRentCell : UITableViewCell

//按钮属性，用来在复用时改变显示的字样
@property (strong, nonatomic) IBOutlet UIButton *appointmentBtn;

-(void)buildingGetItemWantHouseWithModle:(LSGetItemWantHouseListModel *)model;

-(void)buildingWithGetItemWantHouseTJModle:(LSGetItemWantHouseTJModel *)model;

-(void)buildingWantHouseWithModel:(LSGetCollectWantHouseList *)model;

-(void)buildingWantHouseModel:(LSSelectMeetItemListModel *)model;

@property (strong, nonatomic) NSString * TypeIdentifier;

@property (strong, nonatomic) NSString * itemIdentifier;


//发送请求参数字典

@property (strong, nonatomic) NSMutableDictionary *paraDict;

//代理对象

@property (weak, nonatomic) id<LSNeedOfficeRentCellDelegate> delegate;

//标识字样
@property (copy, nonatomic) NSString *btnStyleIdentifier;
/*如果是删除,则按钮标题为删除,并且发送代理方法*/


@end
