//
//  LStotalCompeleteModel.h
//  LSZH
//
//  Created by posco imac4 on 16/6/3.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "LSjibenxinxiModel.h"
//#import "LSjianzhuxinxiModel.h"
@interface LStotalCompeleteModel : NSObject
//@property (nonatomic, strong)LSjibenxinxiModel *jibenxinximodel;
//以下已检查
@property (nonatomic, copy) NSString *louyu;
//
@property (nonatomic, copy) NSString *louhao;
//
@property (nonatomic, copy) NSString *louceng;
//
@property (nonatomic, copy) NSString *mianji;
//
@property (nonatomic, copy) NSString *chaoxiang;
//
@property (nonatomic, copy) NSString *zhuangxiu;
//
@property (nonatomic, copy) NSString *qizu;
//
@property (nonatomic, copy) NSString *rizujin;
//
@property (nonatomic, copy) NSString *yuezujin;
//
@property (nonatomic, copy) NSString *mianzuqi;
//
@property (nonatomic, copy) NSString *sheshi;
//
@property (nonatomic, copy)NSString *diliweizhi;
//
@property (nonatomic, copy) NSString *detailAddress;

//@property (nonatomic, strong)LSjianzhuxinxiModel *jainzhuxinximodel;
//建筑类型
@property (nonatomic, copy)NSString *jianzhuleixing;
//建筑面积
@property (nonatomic, copy)NSString *jianzhumianji;
//净层高
@property (nonatomic, copy)NSString *jingcenggao;
//物业级别
@property (nonatomic, copy)NSString *wuyejibie;
//入住时间
@property (nonatomic, copy)NSString *ruzhushijian;
//开发商
@property (nonatomic, copy)NSString *kaifashang;
//设计单位
@property (nonatomic, copy)NSString *shejidanwei;
//施工单位
@property (nonatomic, copy)NSString *shigongdanwei;



//楼内配套
@property (nonatomic, copy)NSString *shejidanwei1;
//周边配套
@property (nonatomic, copy)NSString *shigongdanwei1;


//交通配套信息-已检查
@property (nonatomic, copy)NSString *jiaotongpeitao;
//备注-已检查
@property (nonatomic, copy)NSString *beizhu;


+ (LStotalCompeleteModel *)shareInstance;

@end
