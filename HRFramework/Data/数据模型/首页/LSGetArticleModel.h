//
//  LSGetArticleModel.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/28.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBaseModel.h"

@interface LSGetArticleModel : LSBaseModel

/**
 集合数据，属性说明如下：
 title：标题
 viewCount：浏览量
 regDate：发布时间
 content：内容
 **/

@property (nonatomic,copy) NSString * title;//文章标题
@property (nonatomic,copy) NSString *viewCount;//浏览量
@property (nonatomic,copy) NSString * regDate;//发布时间
@property (nonatomic,copy) NSString * content;//内容

@end
