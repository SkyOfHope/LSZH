//
//  LSMailboxTableViewCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/20.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSGetUserMessageListModel.h"

@interface LSMailboxTableViewCell : UITableViewCell

-(void)buildingWithModle:(LSGetUserMessageListModel *)model;

@end
