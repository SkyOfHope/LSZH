//
//  LSGetCollectRentHouseList.h
//  LSZH
//
//  Created by risenb-ios5 on 16/6/1.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBaseModel.h"

@interface LSGetCollectRentHouseList : LSBaseModel

/**
 集合数据，属性说明如下：
 rentId：标识id
 title：标题
 imgPath：图片
 
 rizujin：日租金
 
 address：地理位置
 
 size：面积
 
 viewCount：浏览量
 regDate：发布时间
 collectId：收藏标识id
 
 **/

@property (nonatomic,copy) NSString *rentId;//标识id
@property (nonatomic,copy) NSString *title;//标题
@property (nonatomic,copy) NSString *imgPath;//图片
//@property (nonatomic,copy) NSString *rizujinStart;//日租金
@property (nonatomic,copy) NSString *rizujin;//日租金
//@property (nonatomic,copy) NSString *rizujinEnd;//日租金
@property (nonatomic,copy) NSString *address;//地理位置
@property (nonatomic,copy) NSString *size;//面积
//@property (nonatomic,copy) NSString *sizeStart;//面积
//@property (nonatomic,copy) NSString *sizeEnd;//面积
@property (nonatomic,copy) NSString *viewCount;//浏览量
@property (nonatomic,copy) NSString *regDate;//发布时间
@property (nonatomic,copy) NSString *collectId;//收藏标识id




@end
