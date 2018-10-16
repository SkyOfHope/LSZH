//
//  LSPersonalHeaderView.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/19.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSPersonalHeaderView.h"

#import "LSMyMailboxViewController.h"
#import "LSMyAppointmetViewController.h"

@interface LSPersonalHeaderView ()


@property (strong, nonatomic) IBOutlet UIView *btnBackView;

/*!
 * @func 选择头像block
 * @auth muyingbo
 * @time 2016-06-20
 * @brif
 */
@property (nonatomic, copy) void (^chooseHeaderImageViewBlock)();


@end

@implementation LSPersonalHeaderView



- (IBAction)headerBtnClick:(UIButton *)sender {
    if (self.chooseHeaderImageViewBlock) {
        self.chooseHeaderImageViewBlock();
    }
    
}
- (IBAction)BtnAction:(UIButton *)sender {
    
    if (sender.tag == 1) {//约谈
        
        [self.viewController.navigationController pushViewController:[[LSMyAppointmetViewController alloc] init] animated:YES];
        
    } else if (sender.tag == 2) {//信箱
        
        LSMyMailboxViewController *VC = [[LSMyMailboxViewController alloc] init];
        
        [self.viewController.navigationController pushViewController:VC animated:YES];
        
    }
    
}

/*!
 * @func 选择头像
 * @auth muyingbo
 * @time 2016-06-20
 * @brif
 */
- (void)chooseHeaderView:(void (^)())block {
    self.chooseHeaderImageViewBlock = block;
}


- (void)drawRect:(CGRect)rect {
    
    self.btnBackView.backgroundColor =  RGBA(0, 0, 0, 0.3);
    
}



@end
