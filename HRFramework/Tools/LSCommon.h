//
//  LSCommon.h
//  LSZH
//
//  Created by risenb-ios5 on 16/6/29.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSCommon : NSObject

+ (CGFloat)getContentHeight:(NSString *)content
               defaultWidth:(CGFloat)width
                 attributes:(NSDictionary *)attributes;

@end
