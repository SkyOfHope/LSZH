//
//  LSSearchModel.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/28.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBaseModel.h"

@interface LSSearchModel : LSBaseModel

/**
 列表集合数据，属性说明如下：
 Id：标识id
 title：文章标题
 publishdate：发布时间
 **/

@property (nonatomic,copy) NSString *Id;//标识id
@property (nonatomic,copy) NSString * title;//文章标题
@property (nonatomic,copy) NSString * publishdate;//发布时间


@end
