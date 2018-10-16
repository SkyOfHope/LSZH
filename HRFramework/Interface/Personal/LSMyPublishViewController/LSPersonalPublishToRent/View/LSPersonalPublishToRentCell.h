//
//  LSPersonalPublishToRentCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/24.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSGetMyWantHouseListModel.h"

@protocol LSPersonalPublishToRentCellDElegate <NSObject>

- (void)jieshufabu:(NSInteger)indexpath;

@end

@interface LSPersonalPublishToRentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *jieshuBtn;

@property (nonatomic, assign)id <LSPersonalPublishToRentCellDElegate> delegate;
-(void)buildingWithModel:(LSGetMyWantHouseListModel *)model;


@end
