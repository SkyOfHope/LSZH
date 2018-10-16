//
//  LSyuetanModel.h
//  LSZH
//
//  Created by posco imac4 on 16/6/5.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSBaseModel.h"

@interface LSyuetanModel : LSBaseModel
//                              isWeiDu = 1;
//                              itemId = 12;
//                              itemTypeId = 4;
//                              maxDate = "2016/6/3 17:01:07";
//                              regDate = "2016/6/3 10:06:38";
//                              title = 3221;
//                              userTypeName = "\U56ed\U533a";
//                              ziduan1 = "3-4";
//                              ziduan2 = "3-4";
//                              ziduan3 = 412;
//                          }
/*


 
 
 五十八、	我收到的约谈
 itemTypeId：项目类别Id(1文化金融；2融资；3出租；4求租)
 itemId：项目标识Id
 title：项目标题
 zidu1：字段1（文化金融显示为发行单位、融资显示为融资主体、办公空间出租和求租显示为日租金）
 ziduan2：字段2（文化金融和融资显示为关键字、办公空间出租和求租显示为面积）
 ziduan3：字段3（文化金融和融资显示为空、办公空间出租和求租显示为地理位置）
 regDate：项目发布时间
 maxDate：最后一个用户发起约谈的时间
 isWeiDu：是由有未读约谈
 userTypeName：发送者会员类型（园区；企业；个人等）

 */

@property (nonatomic, copy)NSString *isWeiDu;
@property (nonatomic, copy)NSString *itemId;
@property (nonatomic, copy)NSString *itemTypeId;
@property (nonatomic, copy)NSString *maxDate;
@property (nonatomic, copy)NSString *regDate;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *userTypeName;
@property (nonatomic, copy)NSString *ziduan1;
@property (nonatomic, copy)NSString *ziduan2;
@property (nonatomic, copy)NSString *ziduan3;
@property (nonatomic, copy)NSString *itemTypeName;


@property (nonatomic, copy)NSString *sendDate;


@end
