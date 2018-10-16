//
//  GGPickerview.h
//  scGap
//
//  Created by MAC on 16/6/21.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GetCityBlock) (NSString *province, NSString *city, NSString *district);

typedef void(^DelCityBlock) ();

@interface GGPickerview : UIView<UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIPickerView *picker;
    UIButton *button_right;
    UIButton *button_left;
    
    NSDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    
    UIView *view;
    
    NSString *selectedProvince;
}

@property (copy, nonatomic) GetCityBlock getCityBlock;

@property (copy, nonatomic) DelCityBlock delCityBlock;

- (void)getCityBlock:(GetCityBlock)getCityBlock;

- (void)delCityBlock:(DelCityBlock)delCityBlock;

@end
