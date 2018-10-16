//
//  LSGetItemRentHouseListModel.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/28.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBaseModel.h"

@interface LSGetItemRentHouseListModel : LSBaseModel

/**
 集合数据，属性说明如下：
 userId：发布人id
 rentId：标识id
 title：标题
 imgPath：图片
 rizujin：日租金
 address：地理位置
 size：面积
 viewCount：浏览量
 regDate：发布时间
 userTypeId：发布人类别Id
 userTypeName：发布人类别名称（园区、企业、个人等）

 **/
@property (nonatomic,copy) NSString * userId;//用户ID
@property (nonatomic,copy) NSString * rentId;//标识id
@property (nonatomic,copy) NSString * title;//标题
@property (nonatomic,copy) NSString * imgPath;//图片
@property (nonatomic,copy) NSString * rizujin;//日租金
@property (nonatomic,copy) NSString *address;//地理位置
@property (nonatomic,copy) NSString * size;//面积
@property (nonatomic,copy) NSString * viewCount;//浏览量
@property (nonatomic,copy) NSString * regDate;//发布时间
@property (nonatomic,copy) NSString * userTypeId;//发布人类别Id
@property (nonatomic,copy) NSString *userTypeName;//发布人类别名称（园区、企业、个人等）


@end
