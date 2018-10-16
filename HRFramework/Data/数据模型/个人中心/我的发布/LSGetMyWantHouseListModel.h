//
//  LSGetMyWantHouseListModel.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/31.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBaseModel.h"

@interface LSGetMyWantHouseListModel : LSBaseModel

/**
 集合数据，属性说明如下：
 wantId：标识id
 title：标题
 rizujinStart：日租金起始值
 rizujinEnd：日租金结束值
 address：地理位置
 sizeStart：面积起始值
 sizeEnd：面积结束值
 viewCount：浏览量
 regDate：发布时间
 
 **/

@property (nonatomic,copy) NSString *wantId;//标识id
@property (nonatomic,copy) NSString *title;//标题
@property (nonatomic,copy) NSString *rizujinStart;//日租金起始值
@property (nonatomic,copy) NSString *rizujinEnd;//日租金结束值
@property (nonatomic,copy) NSString *address;//地理位置
@property (nonatomic,copy) NSString *sizeStart;//面积起始值
@property (nonatomic,copy) NSString *sizeEnd;//面积结束值
@property (nonatomic,copy) NSString *viewCount;//浏览量
@property (nonatomic,copy) NSString *regDate;//发布时间



@end
