//
//  LSPersonalHeaderView.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/19.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PERSONALHEADERBTN_CLICK_NOTIFICATION @"HeaderBtn_Click"
@interface LSPersonalHeaderView : UIView

@property (strong, nonatomic) IBOutlet UIButton *headerImgBtn;

@property(nonatomic,strong)UIViewController* owner;
@property (weak, nonatomic) IBOutlet UIImageView *headerIconImg;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *qiyeLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;


/*!
 * @func 选择头像
 * @auth muyingbo
 * @time 2016-06-20
 * @brif
 */
- (void)chooseHeaderView:(void (^)())block;


@end
