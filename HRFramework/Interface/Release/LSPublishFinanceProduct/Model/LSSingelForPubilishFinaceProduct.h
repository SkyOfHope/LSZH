//
//  LSSingelForPubilishFinaceProduct.h
//  LSZH
//
//  Created by risenb-ios5 on 16/7/21.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSSingelForPubilishFinaceProduct : NSObject


@property (nonatomic,copy) NSString *detailTFContent;
@property (nonatomic,copy) NSString *instructionDetailtfContent;
@property (nonatomic,copy) NSString *applicableCustomerTFContent;
@property (nonatomic,copy) NSString *requirementTF;
@property (nonatomic,copy) NSString *materialTF;
@property (nonatomic,copy) NSString *processTF;
@property (nonatomic,copy) NSString *remarksTF;


@property (nonatomic,copy) NSString *financeUseTextField;
@property (nonatomic,copy) NSString *provideMaterialTextField;
@property (nonatomic,copy) NSString *projectDescripeTextField;
@property (nonatomic,copy) NSString *projectGoodTextField;
@property (nonatomic,copy) NSString *remarkTF;

@property (nonatomic,copy) NSString *peitaoSheshiTF;
@property (nonatomic,copy) NSString *jiaotongTF;
@property (nonatomic,copy) NSString *tipsTF;
//@property (nonatomic,copy) NSString *remarkTF;


+(instancetype)shareSingelForPubilishFinaceProduct;


@end
