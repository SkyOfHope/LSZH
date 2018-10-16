//
//  LSOfficeRentMoneyView.h
//  LSZH
//
//  Created by risenb-ios5 on 16/6/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSOfficeRentMoneyViewDelegate <NSObject>

- (void)sendmoney:(NSString *)start moneyend:(NSString *)moneyend;

@end


@interface LSOfficeRentMoneyView : UIView

@property (nonatomic, assign) BOOL isHide;

-(void)hideContrl;

@property (assign, nonatomic) id<LSOfficeRentMoneyViewDelegate>delegate;


@property (copy, nonatomic) void(^transmitValueWithMoney)(NSString*,NSString*);

@property (copy, nonatomic) NSString *start;
@property (copy, nonatomic) NSString *end;


@end
