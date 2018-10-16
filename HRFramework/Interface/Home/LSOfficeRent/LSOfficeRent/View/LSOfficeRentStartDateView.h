//
//  LSOfficeRentStartDateView.h
//  LSZH
//
//  Created by risenb-ios5 on 16/6/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  LSOfficeRentStartDateViewDelegate<NSObject>

-(void)sendDateStr:(NSString*)dateStr;

//-(void)sendDateStr:(NSString *)startDateStr WithEndDataStr:(NSString *)endDataStr;

@end



@interface LSOfficeRentStartDateView : UIView

@property (nonatomic, assign) BOOL isHide;

@property (weak, nonatomic) IBOutlet UIView *pickView;

@property (weak, nonatomic) IBOutlet UIView *changeView;

@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@property (weak, nonatomic) IBOutlet UIButton *endBtn;


@property (assign, nonatomic) BOOL status;

@property (weak,nonatomic) id<LSOfficeRentStartDateViewDelegate> delegate;

-(void)hideContrl;

- (void)hideViewWithStatusType:(BOOL)statusType;




@end
