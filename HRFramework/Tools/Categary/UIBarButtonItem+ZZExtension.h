//
//  UIBarButtonItem+ZZExtension.h
//  WeiBoKeJian
//
//  Created by mac on 15/12/4.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZZExtension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

@end
