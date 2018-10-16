//
//  LSRegistPersonalViewController.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/26.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "HRBaseViewController.h"

//通知登录界面跳转首页
#define SKIPHOME @"SKIPHome_Action"



@interface LSRegistPersonalViewController : HRBaseViewController


@property (nonatomic, copy) NSString *passWord;
@property (nonatomic, copy) NSString *accountNum;

//@property (strong, nonatomic) NSMutableDictionary *getData;

@end
