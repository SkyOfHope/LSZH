//
//  LSShouDaoYueTanModel.h
//  LSZH
//
//  Created by posco imac4 on 16/6/5.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSBaseModel.h"
@interface LSShouDaoYueTanModel : LSBaseModel
/*
 {
 headImg = "http://www.wcsyq.gov.cnhttp://www.wcsyq.gov.cn/upload/2016-06/20160603100852023.jpeg";
 maxDate = "2016/6/3 17:01:07";
 mobile = 13311242565;
 name = "";
 userId = 4;
 userTypeId = 4;
 userTypeName = "\U4e2a\U4eba";
 }

 
 userId：发送约谈用户的Id
 headImg：头像
 name：联系人姓名
 realName：真实姓名
 mobile：联系电话
 userTypeId：用户类别Id（1园区）
 userTypeName：用户类别名称
 maxDate：用户发送约谈的时间

 */

@property (nonatomic, copy)NSString *userId;
@property (nonatomic, copy)NSString *headImg;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *realName;
@property (nonatomic, copy)NSString *mobile;
@property (nonatomic, copy)NSString *userTypeId;
@property (nonatomic, copy)NSString *userTypeName;
@property (nonatomic, copy)NSString *maxDate;
//新增组织名称
@property (nonatomic, copy)NSString *organizationName;

@end
