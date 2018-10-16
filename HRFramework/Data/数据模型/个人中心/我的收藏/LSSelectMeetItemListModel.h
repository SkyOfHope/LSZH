//
//  LSSelectMeetItemListModel.h
//  LSZH
//
//  Created by risenb-ios5 on 16/6/3.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBaseModel.h"

@interface LSSelectMeetItemListModel : LSBaseModel

/**
 列表集合数据，属性说明如下：
 itemTypeId：项目类别ID(1文化金融；2融资；3出租；4求租)
 itemId：项目ID
 title：标题
 imgPath：图片地址
 zidu1：字段1（文化金融显示为发行单位、融资显示为融资主体、办公空间出租和求租显示为日租金）
 ziduan2：字段2（文化金融和融资显示为关键字、办公空间出租和求租显示为面积）
 ziduan3：字段3（文化金融和融资显示为空、办公空间出租和求租显示为地理位置）
 regDate：发布时间
 
 itemTypeName:项目类型
 
 **/


@property (nonatomic,copy) NSString *itemTypeName;

@property (nonatomic,copy) NSString *itemTypeId;//标识id
@property (nonatomic,copy) NSString *itemId;//项目ID
@property (nonatomic,copy) NSString *title;//标题
@property (nonatomic,copy) NSString *imgPath;//图片地址
@property (nonatomic,copy) NSString *ziduan1;//日租金结束值
@property (nonatomic,copy) NSString *ziduan2;//地理位置

@property (nonatomic,copy) NSString *ziduan3;//面积起始值

@property (nonatomic,copy) NSString *regDate;//发布时间

@end
