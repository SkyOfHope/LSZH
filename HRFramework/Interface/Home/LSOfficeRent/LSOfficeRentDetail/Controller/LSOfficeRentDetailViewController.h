//
//  LSOfficeRentViewController.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/23.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "HRBaseViewController.h"

@protocol LSOfficeRentDetailViewControllerDelegate <NSObject>

-(void)requestMoreDataOfficeRentDetailViewController;

@end


@interface LSOfficeRentDetailViewController : HRBaseViewController

@property (strong, nonatomic) NSString *Id;
@property (nonatomic, copy) NSString *itemTypeId;

@property (strong, nonatomic) NSString *userId;

@property (assign, nonatomic) NSInteger hiddenLowView;

//返回刷新点击量
@property (copy, nonatomic) void(^RentBlock)();

@property (weak, nonatomic) id<LSOfficeRentDetailViewControllerDelegate> delegate;

@end
