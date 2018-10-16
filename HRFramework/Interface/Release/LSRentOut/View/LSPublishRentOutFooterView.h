//
//  LSPublishRentOutFooterView.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/20.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LStotalCompeleteModel.h"
@protocol totalcompeleteDelegate <NSObject>

- (void)totalcompelete;
- (void)addImg;

//控制弹窗
- (void) promptForCell:(NSString*)prompt;

-(void)shanchutupianChuzu:(NSInteger)index;

@end

@interface LSPublishRentOutFooterView : UIView

@property (weak, nonatomic) IBOutlet UIButton *addImgBtn;
@property (weak, nonatomic) IBOutlet UIView *uploadImg;

@property (nonatomic, assign) id<totalcompeleteDelegate> delegate;

@end
