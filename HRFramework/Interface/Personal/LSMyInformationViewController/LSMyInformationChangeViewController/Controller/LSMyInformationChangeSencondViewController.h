//
//  LSMyInformationChangeSencondViewController.h
//  LSZH
//
//  Created by apple  on 16/8/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "HRBaseViewController.h"

@protocol LSMyInformationChangeSencondViewControllerDelegate <NSObject>


-(void)reloadNewinformation;


@end



@interface LSMyInformationChangeSencondViewController : HRBaseViewController




@property (strong, nonatomic) NSString *detailtext;


@property (weak, nonatomic) id<LSMyInformationChangeSencondViewControllerDelegate> delegate;


@end
