//
//  LSCultureFinanceProductDetailViewController.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "HRBaseViewController.h"




@protocol LSCultureFinanceProductDetailViewControllerDelegate <NSObject>

-(void)requestMoreDataCultureFinanceProductDetailViewController;

@end



@interface LSCultureFinanceProductDetailViewController : HRBaseViewController

@property (copy, nonatomic) NSString *Id;
@property (nonatomic, copy) NSString *itemTypeId;

@property (copy, nonatomic) NSString *userId;

//判断下方的约谈栏是否需要隐藏
@property (assign, nonatomic) NSInteger isHidden;

@property (weak, nonatomic) id<LSCultureFinanceProductDetailViewControllerDelegate> delegate;

@end
