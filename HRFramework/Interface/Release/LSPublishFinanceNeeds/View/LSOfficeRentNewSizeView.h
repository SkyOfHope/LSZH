//
//  LSOfficeRentNewSizeView.h
//  LSZH
//
//  Created by risenb-ios5 on 16/6/8.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SUREBTN_CLICK_NOTIFICATION @"sureBtn_Click"



@protocol sureDelegate <NSObject>

- (void)sureAction:(NSMutableArray *)selectArr WithType:(NSString *)type;

//- (void)sureAction:(NSMutableArray *)selectArr;
//- (void)handleSelectArr:(NSMutableArray *)selectedArr;

@end

@interface LSOfficeRentNewSizeView : UIView

@property (nonatomic, assign) BOOL isHide;

@property (nonatomic, assign) id<sureDelegate>deledate;

- (instancetype)initType:(NSString *)type;

-(void)hideContrl;

//-(void)configDataSource:(NSMutableArray *)dataSource isMutiSelected:(BOOL)isMutiSelected;


@end
