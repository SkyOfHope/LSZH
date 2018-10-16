//
//  LSGetMyJinRongListModle.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/31.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBaseModel.h"

@interface LSGetMyJinRongListModle : LSBaseModel

/**
 集合数据，属性说明如下：
 jinrongId：标识id
 title：标题
 imgPath：图片
 unit：发行单位
 keyword：关键词
 viewCount：浏览量
 regDate：发布时间
 
 **/

@property (nonatomic,copy) NSString *jinrongId;//标识id
@property (nonatomic,copy) NSString *title;//标题
@property (nonatomic,copy) NSString *imgPath;//图片
@property (nonatomic,copy) NSString *unit;//发行单位
@property (nonatomic,copy) NSString *keyword;//关键字
@property (nonatomic,copy) NSString *viewCount;//浏览量
@property (nonatomic,copy) NSString *regDate;//发布时间


@end
