//
//  LSPublishRentOutCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/24.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSGetMyRentHouseListModel.h"
@protocol LSPersonalPublishRentOutCellDElegate <NSObject>

- (void)jieshufabu:(NSInteger)indecpath;

@end

@interface LSPersonalPublishRentOutCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *jieshuBtn;


-(void)buildingWithModel:(LSGetMyRentHouseListModel *)model;
@property (nonatomic, assign)id <LSPersonalPublishRentOutCellDElegate> delegate;

@end



