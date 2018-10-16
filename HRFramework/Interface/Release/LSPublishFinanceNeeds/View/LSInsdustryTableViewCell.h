//
//  LSInsdustryTableViewCell.h
//  LSZH
//
//  Created by xun.liu on 16/6/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSInsdustryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *titleBtn;

@property (weak, nonatomic) IBOutlet UIImageView *selectImg;

@property (nonatomic, assign) BOOL isSelected;

@end
