//
//  LSTestDynamicCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/23.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSGetSyqdtModel.h"

@interface LSTestDynamicCell : UITableViewCell

-(void)buildingWithModel:(LSGetSyqdtModel *)model;

@end
