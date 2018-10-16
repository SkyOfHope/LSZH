//
//  LSCultureFinanceTopCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/6/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSCultureFinanceTopCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *img;

-(void)changeSelectedState:(BOOL)isSelected;

@end
