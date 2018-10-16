//
//  LStotalCompeleteModel.m
//  LSZH
//
//  Created by posco imac4 on 16/6/3.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LStotalCompeleteModel.h"
static LStotalCompeleteModel *single = nil;

@implementation LStotalCompeleteModel

+ (LStotalCompeleteModel *)shareInstance {
    //多线程单利
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single=[LStotalCompeleteModel alloc];
    });
    
    return single;
}

@end
