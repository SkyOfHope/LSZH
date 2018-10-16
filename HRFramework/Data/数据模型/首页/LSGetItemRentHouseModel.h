//
//  LSGetItemRentHouseModel.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/28.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBaseModel.h"

@interface LSGetItemRentHouseModel : LSBaseModel

/**
 集合数据，属性说明如下：
 userId：用户ID
 title：标题
 imgPath：图片
 province：所在地区----省
 city：所在地区----市
 county：所在地区----县
 louyu：所在楼宇
 qizuDate：起租日期
 size：面积
 rizujin：日租金
 yuezujin：月租金
 mianzuqi：免租期
 louhao：楼号
 louceng：楼层
 chaoxiang：朝向
 zhuangxiu：装修
 peitao：配套
 address：地理位置
 mapXY：地图坐标
 jianzhuType：建筑类型
 jianzhuSize：建筑面积
 jingcenggao：净层高
 wuyeJibie：物业级别
 kaifashang：开发商
 shejiDanwei：设计单位
 shigongDanwei：施工单位
 ruzhuDate：入住日期
 louneiPeitao：楼内配套
 zhoubianPeitao：周边配套
 jiaotongPeitao：交通配套
 remark：备注
 viewCount：浏览量
 regDate：发布时间
 userTypeId：发布人类别id
 userTypeName：发布人类别名称（园区、企业、个人等）

 **/
@property (nonatomic,copy) NSString * userId;//用户ID
@property (nonatomic,copy) NSString * title;//标题
@property (nonatomic,copy) NSString * imgPath;//图片
@property (nonatomic,copy) NSString * province;//所在地区----省
@property (nonatomic,copy) NSString * city;//所在地区----市
@property (nonatomic,copy) NSString * county;//所在地区----县
@property (nonatomic,copy) NSString * louyu;//所在楼宇
@property (nonatomic,copy) NSString * qizuDate;//起租日期
@property (nonatomic,copy) NSString * size;//面积
@property (nonatomic,copy) NSString * rizujin;//日租金
@property (nonatomic,copy) NSString * yuezujin;//月租金
@property (nonatomic,copy) NSString *mianzuqi;//免租期
@property (nonatomic,copy) NSString *louhao;//楼号
@property (nonatomic,copy) NSString *louceng;//楼层
@property (nonatomic,copy) NSString *chaoxiang;//朝向
@property (nonatomic,copy) NSString * zhuangxiu;//装修
@property (nonatomic,copy) NSString * peitao;//配套


@property (nonatomic,copy) NSString * address;//地理位置

//地理坐标返回两个值,一个安卓,一个ios mapXY_gaode高德 mapXY_baidu百度
@property (nonatomic,copy) NSString *mapXY_gaode;//地图坐标

@property (nonatomic,copy) NSString * jianzhuType;//建筑类型
@property (nonatomic,copy) NSString * jianzhuSize;//建筑面积
@property (nonatomic,copy) NSString * jingcenggao;//净层高
@property (nonatomic,copy) NSString * wuyeJibie;//物业级别
@property (nonatomic,copy) NSString * kaifashang;//开发商
@property (nonatomic,copy) NSString *shejiDanwei;//设计单位
@property (nonatomic,copy) NSString *shigongDanwei;//施工单位
@property (nonatomic,copy) NSString *ruzhuDate;//入住日期
@property (nonatomic,copy) NSString *louneiPeitao;//楼内配套
@property (nonatomic,copy) NSString * zhoubianPeitao;//周边配套
@property (nonatomic,copy) NSString * jiaotongPeitao;//交通配套



@property (nonatomic,copy) NSString *remark;//备注
@property (nonatomic,copy) NSString * viewCount;//浏览量
@property (nonatomic,copy) NSString * regDate;//发布时间
@property (nonatomic,copy) NSString * userTypeId;//发布人类别Id
@property (nonatomic,copy) NSString *userTypeName;//发布人类别名称（园区、企业、个人等）

@end
