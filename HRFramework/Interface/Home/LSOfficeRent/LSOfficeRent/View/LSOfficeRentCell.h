//
//  LSOfficeRentCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/23.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSGetItemRentHouseListModel.h"

#import "LSGetItemRentHouseTJModel.h"



@interface LSOfficeRentCell : UITableViewCell

-(void)buildingWithModel:(LSGetItemRentHouseListModel *)model;

-(void)buildingWithGetItemRentHouseTJModel:(LSGetItemRentHouseTJModel *)modelTJ;

@property (strong, nonatomic) NSMutableDictionary *paraDict;

@property (nonatomic, strong)LSGetItemRentHouseListModel *model;


@end
