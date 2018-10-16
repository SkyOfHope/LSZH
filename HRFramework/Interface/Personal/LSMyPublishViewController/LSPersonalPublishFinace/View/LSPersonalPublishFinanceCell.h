//
//  LSPersonalPublishFinanceCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/24.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSGetMyJinRongListModle.h"
@protocol LSPersonalPublishFinanceCellDElegate <NSObject>

- (void)jieshufabu:(NSInteger)indexpath;

@end

@interface LSPersonalPublishFinanceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *jieshuBtn;

@property (nonatomic, assign)id <LSPersonalPublishFinanceCellDElegate> delegate;

-(void)BuildingWithModel:(LSGetMyJinRongListModle *)model;

@end
