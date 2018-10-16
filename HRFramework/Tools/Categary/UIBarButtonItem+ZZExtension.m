//
//  UIBarButtonItem+ZZExtension.m
//  WeiBoKeJian
//
//  Created by mac on 15/12/4.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "UIBarButtonItem+ZZExtension.h"

@implementation UIBarButtonItem (ZZExtension)


+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
