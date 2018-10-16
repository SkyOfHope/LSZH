//
//  LSOfficeRentDetailCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/23.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSGetItemRentHouseModel.h"

@interface LSOfficeRentDetailCell : UITableViewCell

-(void)buildingWithModel:(LSGetItemRentHouseModel *)model;

-(void)buildingWithArray:(NSMutableArray *)imgArr;

@property (copy ,nonatomic) void(^blockForCell)();

@end
