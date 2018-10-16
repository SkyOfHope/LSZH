//
//  LSBaseRequestParam.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/30.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSBaseRequestParam : NSObject


@property (nonatomic,copy,readonly) NSString *host;
@property (nonatomic,copy,readonly) NSString *port;
@property (nonatomic,copy) NSString *path;

@end
