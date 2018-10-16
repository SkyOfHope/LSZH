//
//  LSPublishOfficeToRentCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSrentModel.h"
@protocol qiuzuDelegate <NSObject>

- (void)qiuzuAction:(LSrentModel *)model;

@end

@interface LSPublishOfficeToRentCell : UITableViewCell
@property (nonatomic, assign) id<qiuzuDelegate>delegate;
@end
