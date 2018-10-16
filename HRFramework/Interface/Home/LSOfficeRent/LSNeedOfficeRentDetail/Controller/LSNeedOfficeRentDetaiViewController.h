//
//  LSNeedOfficeRentDetaiViewController.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "HRBaseViewController.h"

@protocol LSNeedOfficeRentDetaiViewControllerDelegate <NSObject>

-(void)requestMoreDataNeedOfficeRentDetaiViewController;

@end



@interface LSNeedOfficeRentDetaiViewController : HRBaseViewController


//接受前面页面传入的参数，并将参数传递给 发送 页面使用
@property (copy, nonatomic) NSString *Id;
@property (nonatomic, copy) NSString *itemTypeId;

@property (strong, nonatomic) NSString *userId;


@property (assign, nonatomic) NSInteger hiddenLowView;

@property (copy, nonatomic) void(^needRentBlock)();

@property (weak, nonatomic) id<LSNeedOfficeRentDetaiViewControllerDelegate> delegate;

@end
