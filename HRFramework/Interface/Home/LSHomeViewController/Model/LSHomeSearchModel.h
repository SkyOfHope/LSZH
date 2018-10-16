//
//  LSHomeSearchModel.h
//  LSZH
//
//  Created by posco imac4 on 16/6/6.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBaseModel.h"

@interface LSHomeSearchModel : LSBaseModel

@property (nonatomic, copy)NSString *Id;
@property (nonatomic, copy)NSString *itemTypeId;
@property (nonatomic, copy)NSString *publishdate;
@property (nonatomic, copy)NSString *title;
/*
 {
 Id = 55;
 itemTypeId = 5;
 publishdate = "2009/12/8 17:03:56";
 title = "\U68a6\U516c\U56ed\U6751\U843d\U6caa\U5317\U4eac \U671d\U9633\U5c06\U5174\U5efa12\U5ea7\U4e3b\U9898\U5267\U573a";
 }
 */
@end
