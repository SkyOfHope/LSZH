//
//  LSLeadViewController.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/31.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "HRBaseViewController.h"




@protocol  LSLeadViewControllerDelegate <NSObject>

-(void)LeadControllerChangeRootController;

@end


@interface LSLeadViewController : HRBaseViewController

@property (weak, nonatomic) id<LSLeadViewControllerDelegate> delegate;


@end
