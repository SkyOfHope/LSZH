//
//  LSGetItemFinancingModel.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/28.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBaseModel.h"

@interface LSGetItemFinancingModel : LSBaseModel

/**
 集合数据，属性说明如下：
 userId：用户ID
 title：标题
 imgPath：图片
 province：所在地区----省
 city：所在地区----市
 county：所在地区----县
 rongziZhuti：融资主体
 
 suoshuHangye：所属行业
 rongziYongtu：融资用途
 rongziMoneyStart：融资金额（区间起始）
 rongziMoneyEnd：融资金额（区间结束）
 totalMoney：总投资额
 yixiangZijin：意向资金
 rongziWay：融资方式
 tigongZiliao：可提供资料
 xiangmuGaishu：项目概述
 xiangmuYoushi：项目优势
 
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
@property (nonatomic,copy) NSString * province;//所在地区----省
@property (nonatomic,copy) NSString * city;//所在地区----市
@property (nonatomic,copy) NSString * productSummary;//所在地区----县
@property (nonatomic,copy) NSString * rongziZhuti;//融资主体
@property (nonatomic,copy) NSString * suoshuHangye;//所属行业
@property (nonatomic,copy) NSString * rongziYongtu;//融资用途
@property (nonatomic,copy) NSString * rongziMoneyStart;//融资金额（区间起始）
@property (nonatomic,copy) NSString * rongziMoneyEnd;//融资金额（区间结束）
@property (nonatomic,copy) NSString *totalMoney;//总投资额

@property (nonatomic,copy) NSString *rongziWay;//融资方式
@property (nonatomic,copy) NSString *tigongZiliao;//可提供资料
@property (nonatomic,copy) NSString * xiangmuGaishu;//项目概述
@property (nonatomic,copy) NSString * xiangmuYoushi;//项目优势


@property (nonatomic,copy) NSString *keyword;//关键词
@property (nonatomic,copy) NSString *remark;//备注
@property (nonatomic,copy) NSString * viewCount;//浏览量
@property (nonatomic,copy) NSString * regDate;//发布时间
@property (nonatomic,copy) NSString * userTypeId;//发布人类别Id
@property (nonatomic,copy) NSString *userTypeName;//发布人类别名称（园区、企业、个人等）




@end
