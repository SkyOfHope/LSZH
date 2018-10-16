//
//  LSCultureFinanceProductDetailHeader.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol ShareBtnDelegate <NSObject>
//
//-(void)shareBtn;
//
//@end

#import "LSGetItemJinRongModel.h"

@interface LSCultureFinanceProductDetailHeader : UIView

-(void)buildingWithModel:(LSGetItemJinRongModel *)model;

-(void)buildingWithArray:(NSMutableArray *)imgArr;

//@property (nonatomic, assign) id <ShareBtnDelegate> delegate;


@end
