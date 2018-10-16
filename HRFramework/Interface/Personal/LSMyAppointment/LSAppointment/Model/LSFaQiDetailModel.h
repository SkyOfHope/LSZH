//
//  LSFaQiDetailModel.h
//  LSZH
//
//  Created by posco imac4 on 16/6/12.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBaseModel.h"

@interface LSFaQiDetailModel : LSBaseModel
/*
 {
 ds =     {
 fujianImgPath = "http://www.wcsyq.gov.cn";
 fujianItemId = 9;
 fujianItemTypeId = 3;
 fujianRegDate = "2016/6/2 20:17:53";
 fujianTitle = "哈哈哈哈和题";
 fujianZiduan1 = 65;
 fujianZiduan2 = 66;
 fujianZiduan3 = "";
 itemId = 12;
 itemTypeId = 4;
 regDate = "2016/6/3 10:06:38";
 remark = "止";
 title = 3221;
 userTypeName = "园区";
 ziduan1 = "3-4";
 ziduan2 = "3-4";
 ziduan3 = 412;
 };
 errMsg = "";
 success = 1;
 }

 
 列表集合数据（成功时返回），属性说明如下：
 itemTypeId：项目类别Id(1文化金融；2融资；3出租；4求租)
 itemId：项目Id
 title：标题
 imgPath：图片地址
 zidu1：字段1（文化金融显示为发行单位、融资显示为融资主体、办公空间出租和求租显示为日租金）
 ziduan2：字段2（文化金融和融资显示为关键字、办公空间出租和求租显示为面积）
 ziduan3：字段3（文化金融和融资显示为空、办公空间出租和求租显示为地理位置）
 regDate：发布时间
 userTypeName：会员类别（园区、企业、个人等）
 remark：约谈内容
 fujianItemTypeId：我添加的项目的项目类型Id
 fujianItemId：我添加的项目id
 fujianTitle：我添加的项目标题
 fujianImgPath：我添加的项目图片
 fujianZidu1：我添加的项目字段1（文化金融显示为发行单位、融资显示为融资主体、办公空间出租和求租显示为日租金）
 fujianZiduan2：我添加的项目字段2（文化金融和融资显示为关键字、办公空间出租和求租显示为面积）
 fujianZiduan3：我添加的项目字段3（文化金融和融资显示为空、办公空间出租和求租显示为地理位置）
 fujianRegDate：我添加的项目发布时间
 */
@property (nonatomic, copy)NSString *itemTypeId;
@property (nonatomic, copy)NSString *itemId;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *imgPath;
@property (nonatomic, copy)NSString *ziduan1;
@property (nonatomic, copy)NSString *ziduan2;
@property (nonatomic, copy)NSString *ziduan3;
@property (nonatomic, copy)NSString *regDate;
@property (nonatomic, copy)NSString *userTypeName;
@property (nonatomic, copy)NSString *remark;
@property (nonatomic, copy)NSString *fujianItemTypeId;
@property (nonatomic, copy)NSString *fujianItemId;
@property (nonatomic, copy)NSString *fujianTitle;
@property (nonatomic, copy)NSString *fujianImgPath;
@property (nonatomic, copy)NSString *fujianZiduan1;
@property (nonatomic, copy)NSString *fujianZiduan2;
@property (nonatomic, copy)NSString *fujianZiduan3;
@property (nonatomic, copy)NSString *fujianRegDate;


@end
