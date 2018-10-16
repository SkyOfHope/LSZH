//
//  LSPublishTimeView.h
//  LSZH
//
//  Created by risenb-ios5 on 16/6/29.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSPublishTimeViewDelegate <NSObject>

-(void)sendDateStr:(NSString *)startDateStr WithEndDataStr:(NSString *)endDataStr;

@end


@interface LSPublishTimeView : UIView

@property (nonatomic, assign) BOOL isHide;

-(void)hideContrl;

@property (assign, nonatomic) id<LSPublishTimeViewDelegate>delegate;


@end
