//
//  LSrentModel.h
//  LSZH
//
//  Created by xun.liu on 16/6/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSrentModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *areaMin;
@property (nonatomic, copy) NSString *areaMax;
@property (nonatomic, copy) NSString *rentMin;
@property (nonatomic, copy) NSString *rentMax;
@property (nonatomic, copy) NSString *peitaoSheshi;
@property (nonatomic, copy) NSString *jiaotong;
@property (nonatomic, copy) NSString *qizuDate;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *tips;

@property (assign, nonatomic) BOOL protocolBtn;


@end
