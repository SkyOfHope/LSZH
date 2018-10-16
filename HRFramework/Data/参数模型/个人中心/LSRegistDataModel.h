//
//  LSRegistDataModel.h
//  LSZH
//
//  Created by apple  on 16/6/6.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSRegistDataModel : NSObject

//通用参数 登陆部分用 userDefault 存储   注册部分用coder存储
@property (copy, nonatomic) NSString *mobile;
@property (copy, nonatomic) NSString *password;
@property (copy, nonatomic) NSString *userTypeId;

//验证码以及验证手机
@property (copy, nonatomic) NSString *testCode;
@property (copy, nonatomic) NSString *codeMobile;

//机构参数
@property (copy, nonatomic) NSString *organizationName;
@property (copy, nonatomic) NSString *licenseName;
@property (copy, nonatomic) NSString *licenseCode;
@property (copy, nonatomic) NSString *licenseImg;
@property (copy, nonatomic) NSString *principalName;
@property (copy, nonatomic) NSString *province;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *county;
@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSString *email;
@property (copy, nonatomic) NSString *remark;
//个人参数
@property (copy, nonatomic) NSString *realname;
@property (copy, nonatomic) NSString *sex;
@property (copy, nonatomic) NSString *nickname;

+(instancetype)shareSingleInstanceForRegist;

//获取文件路径
+(NSString *)filePathForRegist;

@end
