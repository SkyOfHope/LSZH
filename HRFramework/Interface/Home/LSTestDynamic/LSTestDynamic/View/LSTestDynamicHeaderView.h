//
//  LSTestDynamicHeaderView.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/23.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSGetSyqdtTopModel.h"
@interface LSTestDynamicHeaderView : UIView


@property (copy,nonatomic) void(^backBlock)();

@property (assign,nonatomic) CGFloat headerHeight;

-(void)buildingWithModel:(LSGetSyqdtTopModel *)model;

@end
