//
//  LSPublishFinanceProductCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
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

-(void)deleteImage:(NSInteger)index;

@end

@interface LSPublishFinanceProductCell : UITableViewCell
@property (nonatomic, assign) id<publishDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIView *uploadImg;

@property (weak, nonatomic) IBOutlet UIButton *addImgBtn;

@property (copy, nonatomic) void(^blockForNew)(BOOL);

@end
