//
//  LSTestDynamicDetailTCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/23.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSGetArticleModel.h"

@interface LSTestDynamicDetailCell : UITableViewCell

-(void)buildingWithModel:(LSGetArticleModel *)model;

@end
