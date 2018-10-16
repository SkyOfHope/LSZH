//
//  LSHomeSearchTableViewCell.h
//  LSZH
//
//  Created by posco imac4 on 16/6/6.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSHomeSearchModel.h"
@interface LSHomeSearchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;

-(void)buildingHomeSearchWithModel:(LSHomeSearchModel *)model;


@end
