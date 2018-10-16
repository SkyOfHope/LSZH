//
//  LSSendYueTanModel.h
//  LSZH
//
//  Created by posco imac4 on 16/6/5.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSBaseModel.h"
@interface LSSendYueTanModel : LSBaseModel

//五十六、	我发起的约谈
//meetId：标识Id
//itemTypeId：项目类别ID(1文化金融；2融资；3出租；4求租；)
//itemId：项目ID
//title：项目标题
//ImgPath：图片地址
//zidu1：字段1（文化金融显示为发行单位、融资显示为融资主体、办公空间出租和求租显示为日租金）
//ziduan2：字段2（文化金融和融资显示为关键字、办公空间出租和求租显示为面积）
//ziduan3：字段3（文化金融和融资显示为空、办公空间出租和求租显示为地理位置）
//regDate：发送时间
//state：查看状态
/*
 {
 fujianItemId = 1;
 fujianItemTypeId = 0;
 imgPath = "http://www.wcsyq.gov.cn/upload/2015-12/2015122522223.jpg";
 itemId = 13;
 itemTypeId = 2;
 meetId = 17;
 regDate = "2016/6/2 17:09:15";
 state = "\U672a\U67e5\U770b";
 title = ssss;
 ziduan1 = "\U662f\U7684\U662f";
 ziduan2 = "\U9a71\U868a\U5668";
 ziduan3 = "";
 itemTypeName
 
 }
 */
@property (nonatomic, copy)NSString *meetId;
@property (nonatomic, copy)NSString *ImgPath;
@property (nonatomic, copy)NSString *state;

@property (nonatomic, copy)NSString *itemTypeId;
@property (nonatomic, copy)NSString *itemId;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *ziduan1;
@property (nonatomic, copy)NSString *ziduan2;
@property (nonatomic, copy)NSString *ziduan3;
@property (nonatomic, copy)NSString *regDate;
@property (nonatomic, copy)NSString *itemTypeName;

//添加的字段
@property (strong, nonatomic) NSString *fujianItemId;
@property (strong, nonatomic) NSString *fujianItemTypeId;

@property (nonatomic, copy)NSString *sendDate;


@end
