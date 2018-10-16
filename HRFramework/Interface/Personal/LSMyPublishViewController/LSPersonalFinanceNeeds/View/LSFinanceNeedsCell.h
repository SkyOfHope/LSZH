//
//  LSFinanceNeedsCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/24.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSGetMyFinancingListModel.h"
@protocol LSFinanceNeedsCellDElegate <NSObject>

- (void)jieshufabu:(NSInteger)indexpath;

@end


@interface LSFinanceNeedsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *jieshuBtn;

//@property (nonatomic, copy) NSString *itemId;
@property (nonatomic, assign)id <LSFinanceNeedsCellDElegate> delegate;
-(void)buildingWithModel:(LSGetMyFinancingListModel *)model;



@end
