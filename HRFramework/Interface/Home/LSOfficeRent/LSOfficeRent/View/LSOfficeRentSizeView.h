//
//  LSOfficeRentSizeView.h
//  LSZH
//
//  Created by risenb-ios5 on 16/6/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSOfficeRentSizeViewDelegate <NSObject>

-(void)SendSizeStart:(NSString *)sizeStart WithSizeEnd:(NSString *)sizeEnd;

@end

@interface LSOfficeRentSizeView : UIView

@property (nonatomic, assign) BOOL isHide;

-(void)hideContrl;

@property (nonatomic, strong) id<LSOfficeRentSizeViewDelegate>delegate;

@property (copy, nonatomic) void(^transmitValueWithSize)(NSString*,NSString*);


@property (copy, nonatomic) NSString *start;
@property (copy, nonatomic) NSString *end;

@end
