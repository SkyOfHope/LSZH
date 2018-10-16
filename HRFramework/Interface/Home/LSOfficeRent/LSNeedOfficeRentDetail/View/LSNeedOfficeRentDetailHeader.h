//
//  LSNeedOfficeRentDetailHeader.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSGetItemWantHouseModel.h"

@protocol LSNeedOfficeRentDetailHeaderDelegate <NSObject>

-(void)updateData;

@end

@interface LSNeedOfficeRentDetailHeader : UIView

-(void)buildingWithModel:(LSGetItemWantHouseModel *)model;

@property (strong, nonatomic) id<LSNeedOfficeRentDetailHeaderDelegate> delegate;


@end
