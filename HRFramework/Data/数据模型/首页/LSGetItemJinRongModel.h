//
//  LSGetItemJinRongModel.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/28.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBaseModel.h"

@interface LSGetItemJinRongModel : LSBaseModel


/**
 集合数据，属性说明如下：
 userId：用户ID
 title：标题
 imgPath：图片
 productType：产品类型
 集合数据，属性说明如下：
 userId：用户ID
 title：标题
 imgPath：图片
 productType：产品类型
 unit：发行单位
 unitType：机构类型
 
 productSummary：产品说明
 advantage：产品优势
 client：适用客户
 condition：申请条件
 information：所需资料
 flow：办理流程
 keyword：关键词
 remark：备注
 viewCount：浏览量
 regDate：发布时间
 userTypeId：发布人类别id
 userTypeName：发布人类别名称（园区、企业、个人等）
 **/
@property (nonatomic,copy) NSString * userId;//用户ID
@property (nonatomic,copy) NSString * title;//标题
@property (nonatomic,copy) NSString * imgPath;//图片
@property (nonatomic,copy) NSString * productType;//产品类型
@property (nonatomic,copy) NSString * unit;//发行单位
@property (nonatomic,copy) NSString * unitType;//机构类型

@property (nonatomic,copy) NSString * productSummary;//产品说明
@property (nonatomic,copy) NSString * advantage;//产品优势
@property (nonatomic,copy) NSString * client;//适用客户
@property (nonatomic,copy) NSString * condition;//申请条件
@property (nonatomic,copy) NSString * information;//所需资料
@property (nonatomic,copy) NSString *flow;//办理流程
@property (nonatomic,copy) NSString *keyword;//关键词
@property (nonatomic,copy) NSString *remark;//备注
@property (nonatomic,copy) NSString * viewCount;//浏览量
@property (nonatomic,copy) NSString * regDate;//发布时间
@property (nonatomic,copy) NSString * userTypeId;//发布人类别Id
@property (nonatomic,copy) NSString *userTypeName;//发布人类别名称（园区、企业、个人等）
//@property (nonatomic,copy) NSString * title;//标题




@end
