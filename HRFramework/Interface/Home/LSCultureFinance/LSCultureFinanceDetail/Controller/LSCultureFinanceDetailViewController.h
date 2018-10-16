//
//  LSCultureFinanceDetailViewController.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/23.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "HRBaseViewController.h"

@protocol LSCultureFinanceDetailViewControllerDelegate <NSObject>


-(void)requestMoreData;

@end

@interface LSCultureFinanceDetailViewController : HRBaseViewController

@property (copy, nonatomic) NSString *Id;
@property (nonatomic, copy) NSString *itemTypeId;
@property (strong, nonatomic) NSString *userId;

@property (assign, nonatomic) NSInteger isHidden;

//返回后列表页刷新,获取浏览量


@property (weak, nonatomic) id<LSCultureFinanceDetailViewControllerDelegate> delegate;

@end
