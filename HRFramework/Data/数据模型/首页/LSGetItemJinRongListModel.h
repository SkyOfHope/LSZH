//
//  LSGetItemJinRongListModel.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/28.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBaseModel.h"

@interface LSGetItemJinRongListModel : LSBaseModel

/**
 集合数据，属性说明如下：
 userId：发布人id
 jinrongId：标识id
 title：标题
 imgPath：图片
 unit：发行单位
 keyword：关键词
 viewCount：浏览量
 regDate：发布时间
 userTypeId：发布人类别Id
 userTypeName：发布人类别名称（园区、企业、个人等）
 **/

@property (nonatomic,copy) NSString * userId;//发布人id
@property (nonatomic,copy) NSString *jinrongId;//标识id
@property (nonatomic,copy) NSString * title;//标题
@property (nonatomic,copy) NSString * imgPath;//图片
@property (nonatomic,copy) NSString *unit;//发行单位
@property (nonatomic,copy) NSString *keyword;//关键词
@property (nonatomic,copy) NSString * viewCount;//浏览量
@property (nonatomic,copy) NSString * regDate;//发布时间
@property (nonatomic,copy) NSString * userTypeId;//发布人类别Id
@property (nonatomic,copy) NSString *userTypeName;//发布人类别名称（园区、企业、个人等）


@end
