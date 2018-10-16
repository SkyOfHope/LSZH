//
//  LSLoginViewController.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/26.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "HRBaseViewController.h"

typedef NS_ENUM(NSInteger,registType){
    
    registType_presonal,
    registType_other
    
};



@protocol LSLoginViewControllerDelegate <NSObject>


-(void)LoadPersonalControllerAfterLogin;


@end



@interface LSLoginViewController : HRBaseViewController


@property (assign, nonatomic) NSInteger ControllerIdentifier;


@property (weak, nonatomic) id<LSLoginViewControllerDelegate> delegate;


@property (copy, nonatomic) NSMutableDictionary *dict;


@property (assign, nonatomic) registType registtype;

@property (copy, nonatomic) NSString *isNow;


@end
