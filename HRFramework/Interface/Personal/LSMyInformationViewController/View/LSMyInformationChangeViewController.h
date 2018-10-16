//
//  LSMyInformationChangeViewController.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/20.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "HRBaseViewController.h"


@protocol LSMyInformationChangeViewControllerDelegate <NSObject>


-(void)reloadNewinformation;

@end

@interface LSMyInformationChangeViewController : HRBaseViewController

@property (weak, nonatomic) id<LSMyInformationChangeViewControllerDelegate> delegate;

@property (strong, nonatomic) NSString *detailtext;

@property (assign, nonatomic) NSInteger changeId;
//是否隐藏警告
@property (assign, nonatomic) NSInteger hiddenWaringLabel;

@end
