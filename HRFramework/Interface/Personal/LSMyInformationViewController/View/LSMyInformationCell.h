//
//  LSMyInformationCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/19.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSMyInformationCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *leftLabel;

@property (strong, nonatomic) IBOutlet UILabel *rightLabel;

@property (weak, nonatomic) IBOutlet UIImageView *arrow;

@end
