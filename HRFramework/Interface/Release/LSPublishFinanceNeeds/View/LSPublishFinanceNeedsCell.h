//
//  LSPublishFinanceNeedsCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class LSPublishFinanceModel;
#import "LSPublishFinanceModel.h"









@protocol uploadImgDelegate <NSObject>

- (void) uploadAction;
- (void) industrySelectAction;

//cell内部检查参数 控制器弹窗
- (void) promptForCell:(NSString*)prompt;


//- (void)publishAction:(LSpublishModel *)model;
//- (void)uploadImg;
-(void)reloadData;

-(void)getOffset;
-(void)setOffset;

//- (void)reloadData;

-(void)deleteImage:(NSInteger)index;

@end

@interface LSPublishFinanceNeedsCell : UITableViewCell<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *uploadImg;


@property (weak, nonatomic) IBOutlet UIButton *addImgBtn;

@property (nonatomic, assign) id<uploadImgDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITextField *suoshuhangye;

@property (copy,nonatomic) void(^blockForSuccess)(BOOL);

- (void)prepareNetRequest:(void (^)(LSPublishFinanceModel *model))block;


@end
