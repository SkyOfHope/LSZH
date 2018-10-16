//
//  LSAdressChoicePickView.h
//  LSZH
//
//  Created by risenb-ios5 on 16/6/16.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AreaObject.h"

@class LSAdressChoicePickView;
typedef void (^LSAdressChoicePickViewBlock)(LSAdressChoicePickView *view,UIButton *btn,AreaObject *locate);

@interface LSAdressChoicePickView : UIView

@property (copy, nonatomic)LSAdressChoicePickViewBlock block;

- (void)show;

@end
