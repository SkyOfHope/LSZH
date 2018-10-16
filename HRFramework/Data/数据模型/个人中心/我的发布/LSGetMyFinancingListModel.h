//
//  LSGetMyFinancingListModel.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/31.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBaseModel.h"

@interface LSGetMyFinancingListModel : LSBaseModel

/**
 集合数据，属性说明如下：
 financingId：标识id
 title：标题
 imgPath：图片
 rongziZhuti：融资主体
 keyword：关键字
 viewCount：浏览量
 regDate：发布时间
 **/

@property (nonatomic,copy) NSString *financingId;//标识id
@property (nonatomic,copy) NSString *title;//标题
@property (nonatomic,copy) NSString *imgPath;//图片
@property (nonatomic,copy) NSString *rongziZhuti;//融资主体
@property (nonatomic,copy) NSString *keyword;//关键字
@property (nonatomic,copy) NSString *viewCount;//浏览量
@property (nonatomic,copy) NSString *regDate;//发布时间



@end
