//
//  LSListGroupSectionHeaderView.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/30.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSListGroupSectionHeaderViewDelegate <NSObject>

@optional
- (void)clickLSListGroupSectionHeader;

@end


@interface LSListGroupSectionHeaderView : UITableViewHeaderFooterView

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic, weak) id<LSListGroupSectionHeaderViewDelegate> delegate;

@end
