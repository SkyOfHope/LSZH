//
//  LSMyInformationChangeAddressViewController.h
//  LSZH
//
//  Created by risenb-ios5 on 16/8/11.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "HRBaseViewController.h"




@protocol LSMyInformationChangeAddressViewControllerDelegate <NSObject>


-(void)reloadNewinformation;

@end

@interface LSMyInformationChangeAddressViewController : HRBaseViewController

@property (copy, nonatomic) NSString *detailtext;

@property (copy, nonatomic) NSString *passProvince;
@property (copy, nonatomic) NSString *passCity;
@property (copy, nonatomic) NSString *passArea;
@property (strong, nonatomic) NSArray *passAddress;



@property (weak, nonatomic) id<LSMyInformationChangeAddressViewControllerDelegate> delegate;

@end
