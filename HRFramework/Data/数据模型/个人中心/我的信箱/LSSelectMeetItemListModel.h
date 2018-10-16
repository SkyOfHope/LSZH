//
//  LSSelectMeetItemListModel.h
//  LSZH
//
//  Created by risenb-ios5 on 16/6/1.
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

 **/

@property (nonatomic,copy) NSString *itemTypeId;//标识Id
@property (nonatomic,copy) NSString *itemId;//内容
@property (nonatomic,copy) NSString *title;//查看状态（未查看；已查看）
@property (nonatomic,copy) NSString *imgPath;//融资主体
@property (nonatomic,copy) NSString *zidu1;//发送时间
@property (nonatomic,copy) NSString *ziduan2;//查看状态（未查看；已查看）
@property (nonatomic,copy) NSString *ziduan3;//融资主体
@property (nonatomic,copy) NSString *regDate;//发送时间

@end
