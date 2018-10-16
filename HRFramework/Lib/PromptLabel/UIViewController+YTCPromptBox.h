//
//  UIViewController+YTCPromptBox.h
//  提示框
//
//  Created by mac on 16/6/10.
//  Copyright © 2016年 YTCProuduct. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CustomBlock) (UILabel*lable);

@interface UIViewController (YTCPromptBox)

-(void)promptBox_YTC_GeneralWithWords:(NSString*)words;

-(void)promptBox_YTC_GeneralWithWords_epinasty:(NSString*)words;


-(void)promptBox_YTC_GeneralWithWords:(NSString *)words WihtBackgroundColor:(UIColor*)backgroundcolor WithTextColor:(UIColor*)textColor WithAppearAlpha:(CGFloat)appearA WithDisappearTime:(CGFloat)disappearT WithCustomSet:(CustomBlock)customBlock;

-(UIColor*)randomColor;



@end


