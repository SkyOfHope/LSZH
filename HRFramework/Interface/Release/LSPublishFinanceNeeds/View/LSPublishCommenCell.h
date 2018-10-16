//
//  LSPublishCommenCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/6/8.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface LSPublishCommenCell : UITableViewCell

@property (nonatomic, assign) BOOL isSelected;

@property (strong, nonatomic) IBOutlet UIImageView *img;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;



-(void)changeSelectedState:(BOOL)isSelected;


@end
