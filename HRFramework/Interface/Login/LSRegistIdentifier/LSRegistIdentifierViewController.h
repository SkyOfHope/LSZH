//
//  LSRegistIdentifierViewController.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/26.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "HRBaseViewController.h"

//@protocol LSRegistIdentifierViewControllerDelegate <NSObject>
//
//-(void)sendPassWord:(NSString *)passWord WithAccount:(NSString *)acocount;
//
//@end

@interface LSRegistIdentifierViewController : HRBaseViewController

//@property (strong, nonatomic) NSMutableDictionary *dic;

@property (nonatomic,copy) NSString *passW;
@property (nonatomic,copy) NSString *account;

@end
