//
//  LSInputTextViewController.h
//  LSZH
//
//  Created by risenb-ios5 on 16/7/21.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "HRBaseViewController.h"

@protocol LSInputTextViewControllerDelegate <NSObject>

-(void)sendText:(NSString *)SendText WithLabelTag:(NSInteger) LabelTag;

@end


@interface LSInputTextViewController : HRBaseViewController

@property (assign, nonatomic) NSInteger labelTag;

@property (strong,nonatomic) id<LSInputTextViewControllerDelegate>delegate;

@property (nonatomic,copy) NSString *str;


@end
