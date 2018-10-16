//
//  LSCultureFinanceDetailHeaderView.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/23.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSGetItemFinancingModel.h"

#import "LSGetItemImgModel.h"

@protocol LSCultureFinanceDetailHeaderViewDelegate <NSObject>

-(void)updateDataWithHeight:(CGFloat)height;

@end

@interface LSCultureFinanceDetailHeaderView : UIView

-(void)buildingWithModel:(LSGetItemFinancingModel *)model;

-(void)buildingWithArray:(NSMutableArray *)imgArr;

@property (nonatomic, strong) id<LSCultureFinanceDetailHeaderViewDelegate>delegate;



@end
