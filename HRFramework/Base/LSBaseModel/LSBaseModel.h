//
//  LSBaseModel.h
//  领调云
//
//  Created by risenb on 16/5/16.
//  Copyright © 2016年 CAPF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface LSBaseModel : NSObject

- (id)initWithDictionary:(NSDictionary*)jsonDic;


//归档专用
- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

@end
