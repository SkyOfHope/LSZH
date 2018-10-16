//
//  LSRegistDataModel.m
//  LSZH
//
//  Created by apple  on 16/6/6.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSRegistDataModel.h"

@interface LSRegistDataModel ()<NSCoding>

@end



@implementation LSRegistDataModel

+(instancetype)shareSingleInstanceForRegist{
    
    static dispatch_once_t identifier ;
    static LSRegistDataModel *single = nil;

    dispatch_once(&identifier, ^{
        
        single = [[LSRegistDataModel alloc]init];
        
    });
    return single;
}


+(NSString *)filePathForRegist{
    
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path=[docPath stringByAppendingPathComponent:@"RegistData"];
    NSLog(@"path=%@",path);

    return path;
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    
    
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.userTypeId forKey:@"userTypeId"];
    [aCoder encodeObject:self.testCode forKey:@"testCode"];
    [aCoder encodeObject:self.codeMobile forKey:@"codeMobile"];
    //个人
    [aCoder encodeObject:self.realname forKey:@"realname"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    
    //机构
    [aCoder encodeObject:self.organizationName forKey:@"organizationName"];
    [aCoder encodeObject:self.licenseName forKey:@"licenseName"];
    [aCoder encodeObject:self.licenseCode forKey:@"licenseCode"];
//    [aCoder encodeObject:self.licenseImg forKey:@"licenseImg"];
    [aCoder encodeObject:self.principalName forKey:@"principalName"];
    [aCoder encodeObject:self.province forKey:@"province"];
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.county forKey:@"county"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.remark forKey:@"remark"];
    
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.userTypeId = [aDecoder decodeObjectForKey:@"userTypeId"];
        self.testCode = [aDecoder decodeObjectForKey:@"testCode"];
        self.testCode = [aDecoder decodeObjectForKey:@"codeMobile"];
        
        self.realname = [aDecoder decodeObjectForKey:@"realname"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        
        self.organizationName = [aDecoder decodeObjectForKey:@"organizationName"];
        self.licenseName = [aDecoder decodeObjectForKey:@"licenseName"];
        self.licenseCode = [aDecoder decodeObjectForKey:@"licenseCode"];
        self.licenseImg = [aDecoder decodeObjectForKey:@"licenseImg"];
        self.principalName = [aDecoder decodeObjectForKey:@"principalName"];
        self.province = [aDecoder decodeObjectForKey:@"province"];
        self.city = [aDecoder decodeObjectForKey:@"city"];
        self.county = [aDecoder decodeObjectForKey:@"county"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.remark = [aDecoder decodeObjectForKey:@"remark"];
        
    }
    
    return self;
}



@end
