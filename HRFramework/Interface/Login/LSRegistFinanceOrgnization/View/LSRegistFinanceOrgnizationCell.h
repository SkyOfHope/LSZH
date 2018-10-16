//
//  LSRegistFinanceOrgnizationCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/26.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSAdressChoicePickView.h"

@protocol LSRegistFinanceOrgnizationCellDelegate <NSObject>

- (void)showProvincePickerView;

-(void)ifSuccessPrompt:(NSString*)word;

//图片按钮代理方法
-(void)pickeImageMethod;

@end


@interface LSRegistFinanceOrgnizationCell : UITableViewCell

@property (nonatomic,strong) LSAdressChoicePickView *pickV;

@property (copy, nonatomic) void (^cellBlock)();

@property (weak, nonatomic) id<LSRegistFinanceOrgnizationCellDelegate> delegate;

@property (strong, nonatomic) NSArray *ProvinceArray;

//图片数组
@property (strong, nonatomic) UIImage *imageUpdate;

@property (strong, nonatomic) NSString *imgPathStr;

-(void)uploadImageMethod;

@end
