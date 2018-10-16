//
//  LSCultureFinanceCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/21.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSGetItemJinRongListModel.h"
#import "LSGetItemFinancingListModel.h"

@interface LSCultureFinanceCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *rongzizhutiLabel;


-(void)buildingGetItemFinancingWithModel:(LSGetItemFinancingListModel *)model;

-(void)buildingGetItemJinRongWithModel:(LSGetItemJinRongListModel *)model;

@property (strong, nonatomic) NSMutableDictionary *cellForSendDict;
//只要非零即隐藏约谈按钮
@property (assign, nonatomic) NSInteger hiddenYuetanBtn;



@end
