//
//  LSShareView.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/26.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSShareView : UIView

@property (nonatomic, assign) BOOL isHide;
@property (copy, nonatomic) NSString  *title;
@property (copy, nonatomic) NSString  *url;

-(void)hideContrl;


@end
