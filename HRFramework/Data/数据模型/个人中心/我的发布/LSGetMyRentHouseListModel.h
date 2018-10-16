//
//  LSGetMyRentHouseListModel.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/31.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBaseModel.h"

@interface LSGetMyRentHouseListModel : LSBaseModel

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
 
 
 Row = 1;
 address = 12;
 regDate = "2016/6/8 16:38:55";
 rizujinEnd = 12;
 rizujinStart = 21;
 sizeEnd = 12;
 sizeStart = 12;
 title = 13;
 viewCount = 2;
 wantId = 19;

 **/

@property (nonatomic,copy) NSString *rentId;//标识id
@property (nonatomic,copy) NSString *title;//标题
@property (nonatomic,copy) NSString *imgPath;//图片
//@property (nonatomic,copy) NSString *rizujinStart;//日租金
@property (nonatomic,copy) NSString *rizujin;//日租金rizujinEnd
@property (nonatomic,copy) NSString *address;//地理位置
//@property (nonatomic,copy) NSString *sizeStart;//面积
@property (nonatomic,copy) NSString *size;//面积sizeEnd
@property (nonatomic,copy) NSString *viewCount;//浏览量
@property (nonatomic,copy) NSString *regDate;//发布时间


@end
