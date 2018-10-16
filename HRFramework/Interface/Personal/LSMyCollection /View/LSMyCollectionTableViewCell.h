//
//  LSMyCollectionTableViewCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/24.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSCancelCollectModel.h"

#import "LSGetCollectFinancingList.h"
#import "LSGetCollectJinRongList.h"
#import "LSGetCollectRentHouseList.h"
#import "LSGetCollectWantHouseList.h"


@protocol  LSMyCollectionTableViewCellDelegate <NSObject>

-(void)cancelCollectWith:(NSInteger)itemType isSuccess:(BOOL)success;

@end


@interface LSMyCollectionTableViewCell : UITableViewCell

//- (void)prepareNetRequest:(void (^)(LSPublishFinanceModel *model))block;

-(void)prepareNetRequest:(void (^)(LSCancelCollectModel *model))block;


-(void)buildingFinancingWithModel:(LSGetCollectFinancingList *)model;
-(void)buildingJinRongWithModel:(LSGetCollectJinRongList *)model;
-(void)buildingRentHouseWithModel:(LSGetCollectRentHouseList *)model;
-(void)buildingWantHouseModel:(LSGetCollectWantHouseList *)model;


@property (copy, nonatomic) NSString * TypeIdentifier;
@property (copy, nonatomic) NSString * itemIdentifier;

@property (weak, nonatomic) id<LSMyCollectionTableViewCellDelegate> delegate;


@end
