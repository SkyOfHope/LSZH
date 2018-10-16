//
//  LSBaseRequestParam.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/30.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBaseRequestParam.h"

@implementation LSBaseRequestParam


- (id)init
{
    self = [super init];
    if (self)
    {
        _host = URLHost;
        _port = URLPort;
        _path = [self buildRequestPath];
    }
    return self;
}

- (id)initWithPath:(NSString *)path
{
    self = [super init];
    if (self)
    {
        _host = URLHost;
        _port = URLPort;
        _path = path;
    }
    return self;
}



- (LSBaseRequestParam *)initWithHost:(NSString *)host port:(NSString *)port path:(NSString *)path
{
    self = [super init];
    if (self)
    {
        _host = host;
        _port = port;
        _path = path;
    }
    return self;
}



- (NSString *)buildRequestPath
{
    return nil;
}

- (NSMutableDictionary *)buildRequestParam
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    return dic;
}

@end
