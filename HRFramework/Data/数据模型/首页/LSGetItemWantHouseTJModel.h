//
//  LSGetItemWantHouseTJModel.h
//  LSZH
//
//  Created by risenb-ios5 on 16/8/26.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBaseModel.h"

@interface LSGetItemWantHouseTJModel : LSBaseModel


/**
 集合数据，属性说明如下：
 userId：发布人id
 wantId：标识id
 title：标题
 rizujinStart：日租金起始值
 rizujinEnd：日租金结束值
 city：地理位置
 sizeStart：面积起始值
 sizeEnd：面积结束值
 viewCount：浏览量
 regDate：发布时间
 userTypeId：发布人类别Id
 userTypeName：发布人类别名称（园区、企业、个人等）

**/
@property (nonatomic,copy) NSString * userId;//发布人id
@property (nonatomic,copy) NSString * wantId;//标识id
@property (nonatomic,copy) NSString * title;//标题
@property (nonatomic,copy) NSString * rizujinStart;//日租金起始值
@property (nonatomic,copy) NSString * rizujinEnd;//日租金结束值
@property (nonatomic,copy) NSString * city;//地理位置
@property (nonatomic,copy) NSString * sizeStart;//面积起始值
@property (nonatomic,copy) NSString * sizeEnd;//面积结束值
@property (nonatomic,copy) NSString * viewCount;//浏览量
@property (nonatomic,copy) NSString * regDate;//发布时间
@property (nonatomic,copy) NSString * userTypeId;//发布人类别Id
@property (nonatomic,copy) NSString * userTypeName;//发布人类别名称（园区、企业、个人等）



@end
