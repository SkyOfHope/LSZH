//
//  LSCommon.m
//  LSZH
//
//  Created by risenb-ios5 on 16/6/29.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSCommon.h"

@implementation LSCommon


+ (CGFloat)getContentHeight:(NSString *)content
               defaultWidth:(CGFloat)width
                 attributes:(NSDictionary *)attributes
{
    NSString *contentString = [NSString stringWithFormat:@"%@",content];
    CGSize expectedLabelSize = CGSizeZero;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        expectedLabelSize = [contentString boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                                        options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                     attributes:attributes
                                                        context:nil].size;
    }
    
    return expectedLabelSize.height;
}
@end
