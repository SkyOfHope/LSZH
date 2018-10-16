//
//  LSPublishFinanceModel.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/30.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSPublishFinanceModel : NSObject


@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *keyWord;
@property (copy, nonatomic) NSString *financeUse;
@property (copy, nonatomic) NSString *financeMoney;
@property (copy, nonatomic) NSString *allmoney;
@property (copy, nonatomic) NSString *provideMaterial;
@property (copy, nonatomic) NSString *projectDescripe;
@property (copy, nonatomic) NSString *projectGood;


//areaTF
//insdustrytF
//intentionalTF
//financingModeTF
@property (copy, nonatomic) NSString *area;
@property (copy, nonatomic) NSString *insdustry;
@property (copy, nonatomic) NSString *intentional;
@property (copy, nonatomic) NSString *financingMode;


@property (copy, nonatomic) NSString *financeTheme;
@property (copy, nonatomic) NSString *remark;

//@property (copy, nonatomic) NSString *title;
//@property (copy, nonatomic) NSString *keyWord;


@end



