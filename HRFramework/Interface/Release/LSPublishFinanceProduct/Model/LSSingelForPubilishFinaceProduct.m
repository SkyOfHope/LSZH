//
//  LSSingelForPubilishFinaceProduct.m
//  LSZH
//
//  Created by risenb-ios5 on 16/7/21.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSSingelForPubilishFinaceProduct.h"

@implementation LSSingelForPubilishFinaceProduct


+(instancetype)shareSingelForPubilishFinaceProduct{
    
    static LSSingelForPubilishFinaceProduct *single = nil;
    static dispatch_once_t identifier;
    
    
    dispatch_once(&identifier, ^{
        
        single = [[LSSingelForPubilishFinaceProduct alloc]init];
        
    });
    
    return single;
}



@end
