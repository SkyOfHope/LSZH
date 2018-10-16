//
//  LSpublishModel.h
//  LSZH
//
//  Created by xun.liu on 16/6/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSpublishModel : NSObject

@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *productType;
@property (nonatomic, copy) NSString *issuer;
@property (nonatomic, copy) NSString *organzationType;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *instructionDetail;
@property (nonatomic, copy) NSString *applicableCustomer;
@property (nonatomic, copy) NSString *requirement;
@property (nonatomic, copy) NSString *material;
@property (nonatomic, copy) NSString *process;
@property (nonatomic, copy) NSString *keyWords;
@property (nonatomic, copy) NSString *remarks;




//协议按钮状态：决定注册信息是否完整
@property (assign,nonatomic) BOOL protocolIsSelected;

@end
