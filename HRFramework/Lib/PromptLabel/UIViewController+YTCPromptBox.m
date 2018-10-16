//
//  UIViewController+YTCPromptBox.m
//  提示框
//
//  Created by mac on 16/6/10.
//  Copyright © 2016年 YTCProuduct. All rights reserved.
//

#import "UIViewController+YTCPromptBox.h"

#define  halfScreenWidth [UIScreen mainScreen].bounds.size.width/2
#define halfScreenHeight [UIScreen mainScreen].bounds.size.height/2


typedef void (^CustomBlock) (UILabel*lable);

@implementation UIViewController (YTCPromptBox)

//接口一 : 显示一个测试用的label 只能 自定义添加 文字显示 位置 偏下
-(void)promptBox_YTC_GeneralWithWords:(NSString*)words{
    
    UILabel *promptLabel = [self commonLabel];
    
    if (words.length < 15) {
        promptLabel.font = [UIFont systemFontOfSize:15];
    }
    
    promptLabel.font = [UIFont systemFontOfSize:13];
    
    promptLabel.numberOfLines = 2;
    
    promptLabel.backgroundColor = [UIColor blackColor];
    
    promptLabel.textColor = [UIColor whiteColor];
    
    promptLabel.text = words;
    
    [[UIApplication sharedApplication].keyWindow addSubview:promptLabel];
    
    [self animationForLabel:promptLabel andAppearTime:1.5 andAppearAlpha:0.8 andDisappearTime:2 andDisappearA:0 andIsRemove:YES];
}

//接口一.一 : 显示一个测试用的label 只能 自定义添加 文字显示 位置 偏上
-(void)promptBox_YTC_GeneralWithWords_epinasty:(NSString*)words{

    UILabel *promptLabel = [self commonLabel];
    
    promptLabel.numberOfLines = 2;
    
    promptLabel.backgroundColor = [UIColor blackColor];
    
    promptLabel.textColor = [UIColor whiteColor];
    
    promptLabel.text = words;
    
    
    
    if (words.length < 15) {
        promptLabel.font = [UIFont systemFontOfSize:15];
    }
    
    promptLabel.font = [UIFont systemFontOfSize:13];
    
    //epinasty设置

    CGRect tempRect = promptLabel.frame;
    tempRect.origin.y = 200;
    
    promptLabel.frame = tempRect;

    [[UIApplication sharedApplication].keyWindow addSubview:promptLabel];
    
    [self animationForLabel:promptLabel andAppearTime:1.5 andAppearAlpha:0.8 andDisappearTime:2 andDisappearA:0 andIsRemove:YES];

}

//接口二 : 创建一个label 直接自定义部分属性 block添加改变更多属性

-(void)promptBox_YTC_GeneralWithWords:(NSString *)words WihtBackgroundColor:(UIColor*)backgroundcolor WithTextColor:(UIColor*)textColor WithAppearAlpha:(CGFloat)appearA WithDisappearTime:(CGFloat)disappearT WithCustomSet:(CustomBlock)customBlock{
    
    UILabel *promptLabel = [self commonLabel];
    
    promptLabel.text = words;
    
    if (backgroundcolor != nil && textColor != nil) {
        promptLabel.backgroundColor =backgroundcolor;
        promptLabel.textColor = textColor;
    }else{
        promptLabel.backgroundColor = [self randomColor];
        promptLabel.textColor = [self randomColor];
    }


        [self animationForLabel:promptLabel andAppearTime:1 andAppearAlpha:appearA andDisappearTime:disappearT andDisappearA:0 andIsRemove:YES];

    if (customBlock != nil) {
        customBlock(promptLabel);
    }else{
        NSLog(@"参数错误");
    }
    [self.view addSubview:promptLabel];
    
}

//创建一般label
-(UILabel *)commonLabel{
    
    UILabel *promptLabel = [[UILabel alloc]init];
    
    CGFloat width = halfScreenWidth * 1.4;
    CGFloat height = width * 0.2;
    
    promptLabel.alpha = 0;
    
    promptLabel.frame = CGRectMake(halfScreenWidth - width/2 , halfScreenHeight * 1.4, width, height);
    
    promptLabel.layer.cornerRadius = height / 2;
    promptLabel.layer.masksToBounds = YES;
    
    promptLabel.textAlignment = 1;

    return promptLabel;
}

//显示动画控制 专门用于调试使用 其他需要手动配置
-(void)animationForLabel:(UILabel*)promptLabel  andAppearTime:(CGFloat)appearT andAppearAlpha:(CGFloat)appearA andDisappearTime:(CGFloat)disappearT andDisappearA:(CGFloat)disappearA andIsRemove:(BOOL)isRemove{
    
    if (appearA > 1 || appearA <= 0 || disappearT <= 0) {
        appearA = 0.7;
        disappearT = 3;
    }

    [UIView animateWithDuration:appearT animations:^{
        promptLabel.alpha = appearA;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:disappearT animations:^{
            promptLabel.alpha = disappearA;
        } completion:^(BOOL finished) {
            if (finished) {
                [promptLabel removeFromSuperview];
            }
        }];
    }];
}

//返回随机色
-(UIColor*)randomColor{
    
    UIColor *random =  [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0  blue:arc4random_uniform(256)/255.0  alpha:1];
    
    return random;
}







@end
