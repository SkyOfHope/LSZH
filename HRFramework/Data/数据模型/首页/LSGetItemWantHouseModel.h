//
//  LSGetItemWantHouseModel.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/30.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBaseModel.h"

@interface LSGetItemWantHouseModel : LSBaseModel

/**
 集合数据，属性说明如下：
 userId：用户ID
 title：标题
 province：所在地区----省
 city：所在地区----市
 county：所在地区----县
 address：地理位置
 size：面积
 zujin：租金
 peitaoSheshi：配套设施
 jiaotong：交通设施
 qizuDate：起租日期
 remark：备注
 viewCount：浏览量
 regDate：发布时间
 userTypeId：发布人类别id
 userTypeName：发布人类别名称（园区、企业、个人等）
 
 **/
@property (nonatomic,copy) NSString * userId;//用户ID
@property (nonatomic,copy) NSString * title;//标题
@property (nonatomic,copy) NSString * province;//所在地区----省
@property (nonatomic,copy) NSString * city;//所在地区----市
@property (nonatomic,copy) NSString * county;//所在地区----县
@property (nonatomic,copy) NSString * address;//地理位置
@property (nonatomic,copy) NSString * sizeStart;//面积
@property (nonatomic,copy) NSString * sizeEnd;//面积

@property (nonatomic,copy) NSString * rizujinStart;//租金
@property (nonatomic,copy) NSString *rizujinEnd;//租金
@property (nonatomic,copy) NSString * peitaoSheshi;//配套设施
@property (nonatomic,copy) NSString * jiaotong;//交通设施
@property (nonatomic,copy) NSString * qizuDate;//起租日期
@property (nonatomic,copy) NSString * remark;//备注
@property (nonatomic,copy) NSString * viewCount;//浏览量
@property (nonatomic,copy) NSString * regDate;//发布时间
@property (nonatomic,copy) NSString * userTypeId;//发布人类别Id
@property (nonatomic,copy) NSString * userTypeName;//发布人类别名称（园区、企业、个人等）
@property (strong, nonatomic) NSString *companyRemark;//求租企业简介



@end
