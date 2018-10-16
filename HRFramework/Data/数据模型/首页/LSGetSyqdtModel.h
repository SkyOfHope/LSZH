//
//  LSGetSyqdtModel.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/27.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBaseModel.h"

@interface LSGetSyqdtModel : LSBaseModel

/**
 列表集合数据，属性说明如下：
 articleId：标识id
 title：文章标题
 imgPath：图片地址
 publishdate：发布时间
 **/

@property (nonatomic,copy) NSString * articleId;//标识id
@property (nonatomic,copy) NSString * title;//文章标题
@property (nonatomic,copy) NSString * publishdate;//发布时间
@property (nonatomic,copy) NSString * imgPath;//图片地址

@property (nonatomic,copy) NSString * viewCount;//浏览量
@end
