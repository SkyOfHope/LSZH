//
//  LSGetUserMessageListModel.h
//  LSZH
//
//  Created by risenb-ios5 on 16/6/1.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBaseModel.h"

@interface LSGetUserMessageListModel : LSBaseModel

/**
 列表集合数据，属性说明如下：
 messageId：标识Id
 strContent：内容
 state：查看状态（未查看；已查看）
 regDate：发送时间
 **/

@property (nonatomic,copy) NSString *messageId;//标识Id
@property (nonatomic,copy) NSString *strContent;//内容
@property (nonatomic,copy) NSString *state;//查看状态（未查看；已查看）
@property (nonatomic,copy) NSString *rongziZhuti;//融资主体
@property (nonatomic,copy) NSString *regDate;//发送时间


@end
