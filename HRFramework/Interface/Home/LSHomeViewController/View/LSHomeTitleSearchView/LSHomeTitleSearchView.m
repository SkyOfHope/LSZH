//
//  LSHomeTitleSearchView.m
//  LSZH
//
//  Created by 穆英波 on 16/6/7.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSHomeTitleSearchView.h"

@interface LSHomeTitleSearchView () <UITextFieldDelegate>

/*~!
 *  Func 白背景
 *  Auth muyingbo
 *  Time 2016-06-07
 *  Brif
 */
@property (nonatomic, weak) IBOutlet UIView *searchBackView;

/*~!
 *  Func 搜索block
 *  Auth muyingbo
 *  Time 2016-06-07
 *  Brif
 */
@property (nonatomic, copy) void (^textfieldTapBlock)();

@end

@implementation LSHomeTitleSearchView


#pragma mark - ---------- Public Methods ----------

#pragma mark Override Super
- (void)layoutSubviews {
    [self setupSearchBackView];
}


#pragma mark Self Declare

/*~!
 *  Func 点击搜索按钮
 *  Auth muyingbo
 *  Time 2016-06-01
 *  Brif
 */
- (void)seacrch:(void (^)())block {
    self.textfieldTapBlock = block;
}

#pragma mark - ---------- Private Methods ----------
#pragma mark IBActions


#pragma mark Others
// 白背景圆角
- (void)setupSearchBackView {
    self.searchBackView.layer.cornerRadius = 5;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushAction)];
    [self.searchBackView addGestureRecognizer:tap];
}

- (void) pushAction {
    if (self.textfieldTapBlock) {
            self.textfieldTapBlock();
//            [textField resignFirstResponder];
        }
}

//#pragma mark - ---------- Protocol Methods ---------- 
//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    if (self.textfieldTapBlock) {
//        
//        self.textfieldTapBlock();
//        [textField resignFirstResponder];
//    }
//    return YES;
//}

@end
