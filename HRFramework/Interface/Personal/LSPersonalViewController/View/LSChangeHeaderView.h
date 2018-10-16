//
//  LSChangeHeaderView.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/19.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol changeIconDelegate <NSObject>

- (void) takePhotoAction;
- (void) localPhotoAction;
@end

@interface LSChangeHeaderView : UIView

@property (nonatomic, assign) BOOL isHide;
@property (nonatomic, assign) id <changeIconDelegate> delegate;

-(void)hideContrl;


@end
