//
//  LSPublishFinanceProductHeaderView.h
//  LSZH
//
//  Created by risenb-ios5 on 16/7/8.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSpublishModel.h"

@protocol publishDelegate <NSObject>

- (void)publishAction:(LSpublishModel *)model;
- (void)uploadImg;
-(void)reloadData;

-(void)getOffset:(CGFloat)viewY;
-(void)setOffset;



@end





@interface LSPublishFinanceProductHeaderView : UIView

@property (nonatomic, assign) id<publishDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIView *uploadImg;

@property (weak, nonatomic) IBOutlet UIButton *addImgBtn;



@end
