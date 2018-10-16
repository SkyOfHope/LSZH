//
//  LSShouDaoDetailModel.h
//  LSZH
//
//  Created by posco imac4 on 16/6/13.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBaseModel.h"

@interface LSShouDaoDetailModel : LSBaseModel
/*
 {
 ds =     {
 fujianItemId = 10;
 fujianItemTypeId = 2;
 fujianRegDate = "2016/6/2 12:11:13";
 fujianTitle = "理解力";
 fujianZiduan1 = "下雨";
 fujianZiduan2 = fghfg;
 fujianZiduan3 = "";
 headImg = "http://www.wcsyq.gov.cnhttp://www.wcsyq.gov.cn/upload/2016-06/20160612162853672.jpeg";
 mobile = 13311242565;
 name = "";
 organizationName = "";
 remark = "目止止昌是是";
 sendDate = "2016/6/7 11:19:05";
 userTypeName = "个人";
 };
 errMsg = "";
 success = 1;
 }
 
 
 列表集合数据（成功时返回），属性说明如下：
 headImg：用户头像
 organizationName：机构名称
 name：联系人姓名
 mobile：联系电话
 sendDate：发送时间
 userTypeName：用户类别名称
 remark：约谈内容
 fujianItemTypeId：我添加的项目的项目类型id
 fujianItemId：我添加的项目id
 fujianTitle：我添加的项目标题
 fujianImgPath：我添加的项目图片
 fujianZidu1：我添加的项目字段1（文化金融显示为发行单位、融资显示为融资主体、办公空间出租和求租显示为日租金）
 fujianZiduan2：我添加的项目字段2（文化金融和融资显示为关键字、办公空间出租和求租显示为面积）
 fujianZiduan3：我添加的项目字段3（文化金融和融资显示为空、办公空间出租和求租显示为地理位置）
 fujianRegDate：我添加的项目发布时间
 */

@property (nonatomic, copy)NSString *headImg;
@property (nonatomic, copy)NSString *organizationName;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *mobile;
@property (nonatomic, copy)NSString *sendDate;
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


@property (nonatomic, copy)NSString *fujianItemTypeName;




@end
