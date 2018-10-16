//
//  LSPublishFinanceProductCell.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSPublishFinanceProductCell.h"
#import "UIViewExt.h"

#import "LSProductTypeView.h"

#import "LSOfficeRentNewSizeView.h"

#import "LSInputTextViewController.h"

#include "LSSingelForPubilishFinaceProduct.h"
@interface LSPublishFinanceProductCell ()<sureDelegate,LSInputTextViewControllerDelegate, UITextViewDelegate>
{
    CGFloat  _height;
    CGFloat  _instrucionHeight;
    CGFloat  _replaceHeight;
    float _lastTextViewHeight;
}
@property (strong, nonatomic)LSProductTypeView *productTypeView;

@property (nonatomic, strong) LSOfficeRentNewSizeView *OfficeRentNewSizeView;

@property (weak, nonatomic) IBOutlet UITextField *productNameTF;//产品名称

@property (weak, nonatomic) IBOutlet UITextField *productTypeTF;//产品类型

@property (weak, nonatomic) IBOutlet UITextField *issuerTF; //发行单位

@property (weak, nonatomic) IBOutlet UITextField *organzationTypeTF;
//机构类型
@property (strong, nonatomic) IBOutlet UITextField *detailTF;
//@property (strong, nonatomic) IBOutlet UILabel *detailTF;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *detailTFViewHeight;

//@property (weak, nonatomic) IBOutlet UITextField *detailTF;
//具体信息
//@property (strong, nonatomic) IBOutlet UILabel *instructionDetailtf;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *instructionDetailViewHeight;

@property (weak, nonatomic) IBOutlet UITextField *instructionDetailtf;


//适用客户
//@property (strong, nonatomic) IBOutlet UILabel *applicableCustomerTF;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *applicableCustomerTFViewHeight;

@property (weak, nonatomic) IBOutlet UITextField *applicableCustomerTF;


//申请条件
//@property (strong, nonatomic) IBOutlet UILabel *requirementTF;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *requirementTFViewHeight;

@property (weak, nonatomic) IBOutlet UITextField *requirementTF;

//所需材料
//@property (strong, nonatomic) IBOutlet UILabel *materialTF;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *materialTFViewHeight;

@property (weak, nonatomic) IBOutlet UITextField *materialTF;
//办理流程
//@property (strong, nonatomic) IBOutlet UILabel *processTF;
//@property (strong, nonatomic) IBOutlet NSLayoutConstraint *processTFViewLabel;


@property (weak, nonatomic) IBOutlet UITextField *processTF;

@property (weak, nonatomic) IBOutlet UITextField *keyWordsTF;

//备注
//@property (strong, nonatomic) IBOutlet UILabel *remarksTF;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *remarksTFViewHeight;
@property (weak, nonatomic) IBOutlet UITextField *remarksTF;



//500字以内
@property (strong, nonatomic) IBOutlet UILabel *leftWordLabel;




//@property (weak, nonatomic) UIButton *selectBtn;
@property (strong, nonatomic) IBOutlet UIButton *protocolBtn;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ImageViewHeight;

@property (weak, nonatomic) IBOutlet UIView *trueImageView;

//判断是否已经扩大了图片框
@property (assign, nonatomic) BOOL isBigger;


@property (assign, nonatomic) CGFloat heightFortableView;

@end


@implementation LSPublishFinanceProductCell

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LSPublishFinanceProductCellreceiveImages" object:nil];
}

- (void)awakeFromNib {
    // Initialization code
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self addGestureRecognizer:tap];
    
    self.heightFortableView = self.height;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveImages:) name:@"LSPublishFinanceProductCellreceiveImages" object:nil];
    self.isBigger = NO;
    
//    self.detailTF.delegate = self;
//    self.instructionDetailtf.delegate = self;
//    self.applicableCustomerTF.delegate = self;
//    self.requirementTF.delegate = self;
//    self.materialTF.delegate = self;
//    self.processTF.delegate = self;
//    self.remarksTF.delegate = self;
    
    
    _height = self.height;
    _instrucionHeight = 0;
    _replaceHeight = 0;
    
    NSLog(@" @#@##@#@#@#@#@  %lf  @#@#@#@#@##@#@#@#@ ",self.height);
    
    LSSingelForPubilishFinaceProduct *data = [LSSingelForPubilishFinaceProduct shareSingelForPubilishFinaceProduct];
    
    data.detailTFContent = nil;
    data.instructionDetailtfContent = nil;
    data.applicableCustomerTFContent = nil;
    data.requirementTF = nil;
    data.materialTF = nil;
    data.processTF = nil;
    data.remarksTF = nil;
    
}

- (void)receiveImages:(NSNotification *)notifycation
{
    id result = notifycation.object;
    NSLog(@"object = %@", result);
    
    //先移除之前的所有控件
    for (UIView *smallView in self.trueImageView.subviews) {
        
        [smallView removeFromSuperview];
        
    }

    
    CGFloat widthCell = (self.trueImageView.frame.size.width - 25) / 4 + 10;
    //增加显示图片的View的高度
    //在九宫格布局
    if ([result isKindOfClass:[NSArray class]]) {
        NSArray *selectImgArr = (NSArray *)result;
        
        //增加显示图片的View的高度
        
        //上下左右间距为五,一排三个

        
        if (selectImgArr.count >= 4 && self.isBigger == NO) {
            
            self.isBigger = YES;
            
            self.ImageViewHeight.constant = self.ImageViewHeight.constant + 100;

        }
        
        if (selectImgArr.count > 0 && selectImgArr.count < 4 && self.isBigger == YES) {
            
//            self.isBigger = NO;
            self.ImageViewHeight.constant = self.ImageViewHeight.constant - 100;
        }
        
        
        self.blockForNew(self.isBigger);
        
        if (selectImgArr.count == 0) {
            
            UIButton *lastBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 5  , 55, 55)];
            [self.trueImageView addSubview:lastBtn];
            [lastBtn setBackgroundImage:[UIImage imageNamed:@"上传照片"] forState:UIControlStateNormal];
            //添加方法
            [lastBtn addTarget:self action:@selector(addImgAction) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        CGFloat widthForImage = (self.trueImageView.frame.size.width - 25) / 4;
        
        //九宫格布局
        
        for (int i = 0; i < selectImgArr.count; i ++) {
            
            NSInteger row = i / 4;
            NSInteger col = i % 4;
            
            
            UIImageView *showImgV = [[UIImageView alloc]initWithImage:selectImgArr[i]];
            [self.trueImageView addSubview:showImgV];
            
            CGFloat XForImage = 5+(widthForImage+ 5 )*col;
            CGFloat YForImage = 5 + (widthForImage + 5) * row;
            
            
            showImgV.frame = CGRectMake(XForImage,  YForImage, widthForImage, widthForImage);
            showImgV.image = selectImgArr[i];
            
            //添加删除按钮
            
            CGFloat widthForShanchu = 12;
            CGFloat chaju = widthForImage - 12;
            UIButton *shanchuB = [[UIButton alloc]initWithFrame:CGRectMake(XForImage + chaju, YForImage , widthForShanchu, widthForShanchu)];
            shanchuB.tag = i;
            [self.trueImageView addSubview:shanchuB];
            shanchuB.backgroundColor = [UIColor redColor];
            [shanchuB setBackgroundImage:[UIImage imageNamed:@"删除照片"] forState:UIControlStateNormal];
            [shanchuB addTarget:self action:@selector(shanchutupian:) forControlEvents:UIControlEventTouchUpInside];
            
            
            //添加多一个按钮
            
            if (i == selectImgArr.count - 1 && selectImgArr.count != 5) {
                
                if (i == 3) {
                    
                    UIButton *lastBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 5 + widthForImage + 5 * 1 , widthForImage, widthForImage)];
                    [self.trueImageView addSubview:lastBtn];
                    [lastBtn setBackgroundImage:[UIImage imageNamed:@"上传照片"] forState:UIControlStateNormal];
                    //添加方法
                    [lastBtn addTarget:self action:@selector(addImgAction) forControlEvents:UIControlEventTouchUpInside];
                    
                }else{
                    
                    UIButton *lastBtn = [[UIButton alloc]initWithFrame:CGRectMake(5+ (widthForImage + 5) * (col + 1), 5 + (widthForImage + 5) * row , widthForImage, widthForImage)];
                    [self.trueImageView addSubview:lastBtn];
                    [lastBtn setBackgroundImage:[UIImage imageNamed:@"上传照片"] forState:UIControlStateNormal];
                    //添加方法
                    [lastBtn addTarget:self action:@selector(addImgAction) forControlEvents:UIControlEventTouchUpInside];
                    
                }
                
            }
        }
        
        self.addImgBtn.hidden = YES;
        
    }
    
    
}


-(void)shanchutupian:(UIButton*)sender{
    
    NSLog(@"%zd",sender.tag);
    
    [self.delegate deleteImage:sender.tag];
    
}


-(void)addImgAction{
    
    if (_delegate && [_delegate respondsToSelector:@selector(uploadImg)]) {
        [_delegate uploadImg];
    }
    
}


- (void)hideKeyBoard {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}


#pragma mark ---- 代理方法
-(void)sendText:(NSString *)SendText WithLabelTag:(NSInteger)LabelTag{
    
    if (LabelTag == self.detailTF.tag) {
        self.detailTF.text = SendText;
    }
    if (LabelTag == self.instructionDetailtf.tag) {
        self.instructionDetailtf.text = SendText;
    }
    if (LabelTag == self.applicableCustomerTF.tag) {
        self.applicableCustomerTF.text = SendText;
    }
    if (LabelTag == self.requirementTF.tag) {
        self.requirementTF.text = SendText;
    }
    if (LabelTag == self.materialTF.tag) {
        self.materialTF.text = SendText;
    }
    if (LabelTag == self.processTF.tag) {
        self.processTF.text = SendText;
    }
    if (LabelTag == self.remarksTF.tag) {
        self.remarksTF.text = SendText;
    }
    
    [_delegate reloadData];
    
}

-(void)sureAction:(NSMutableArray *)selectArr WithType:(NSString *)type{
    
    switch ([type integerValue]) {
        case 4:{
            
            NSLog(@"请选择产品类型%@",selectArr);
            
            NSString *temp = selectArr[0];
            
            NSLog(@"请选择产品类型%@",temp);
            
            self.productTypeTF.text = temp;

            

        break;
    }
        case 7:{
            
            NSLog(@"请选机构类型%@",selectArr);
            
            NSString *temp = selectArr[0];
            
            NSLog(@"请选择机构类型%@",temp);
            
            self.organzationTypeTF.text = temp;
            
            
            
            break;
        }
            

    
        default:
            break;
    }
    
    
}


#pragma mark - ||========== IBActions ===========||
//产品类型
- (IBAction)ProductTypeBtnAction:(UIButton *)sender {
    
    self.OfficeRentNewSizeView = [[LSOfficeRentNewSizeView alloc]initType:@"4"];
    
    self.OfficeRentNewSizeView.deledate = self;
    
    //    self.officeRentSizeView.delegate = self;
    
    self.OfficeRentNewSizeView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
    //    self.alertView.backgroundColor = RGBColor(0, 0, 0, .5);
    self.OfficeRentNewSizeView.layer.cornerRadius = 5;
    self.OfficeRentNewSizeView.layer.masksToBounds = YES;
    [AppDelegate.window addSubview:self.OfficeRentNewSizeView];
    
    self.OfficeRentNewSizeView.frame = SCREEN_BOUNDS;
    
    
}

- (IBAction)organizationTypeBtnAction:(UIButton *)sender {
    
    
    self.OfficeRentNewSizeView = [[LSOfficeRentNewSizeView alloc]initType:@"7"];
    
    self.OfficeRentNewSizeView.deledate = self;
    
    //    self.officeRentSizeView.delegate = self;
    
    self.OfficeRentNewSizeView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
    //    self.alertView.backgroundColor = RGBColor(0, 0, 0, .5);
    self.OfficeRentNewSizeView.layer.cornerRadius = 5;
    self.OfficeRentNewSizeView.layer.masksToBounds = YES;
    [AppDelegate.window addSubview:self.OfficeRentNewSizeView];
    
    self.OfficeRentNewSizeView.frame = SCREEN_BOUNDS;
    
    
}

- (IBAction)protocolBtnAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;

}



- (IBAction)completeTF:(id)sender {
    
    LSpublishModel *model = [[LSpublishModel alloc]init];
    model.productName = _productNameTF.text;
    model.productType = _productTypeTF.text;
    model.issuer = _issuerTF.text;
    model.organzationType = _organzationTypeTF.text;
    model.detail = _detailTF.text;
    model.instructionDetail = _instructionDetailtf.text;
    model.applicableCustomer = _applicableCustomerTF.text;
    model.requirement = _requirementTF.text;
    model.material = _materialTF.text;
    model.process = _processTF.text;
    model.keyWords = _keyWordsTF.text;
    model.remarks = _remarksTF.text;
    
    model.protocolIsSelected = self.protocolBtn.selected;
    
    if (_delegate && [_delegate respondsToSelector:@selector(publishAction:)]) {
        [_delegate publishAction:model];
    }
}

- (IBAction)uploadImgAction:(id)sender {
    if (_delegate &&[_delegate respondsToSelector:@selector(uploadImg)]) {
        [_delegate uploadImg];
    }
    
}


- (IBAction)InputTextBtnAction:(UIButton *)sender {
    
    LSInputTextViewController *InputTextVC = [[LSInputTextViewController alloc] initWithNibName:@"LSInputTextViewController" bundle:nil];
    
    InputTextVC.delegate = self;
    InputTextVC.labelTag = sender.tag;
    
    LSSingelForPubilishFinaceProduct *data = [LSSingelForPubilishFinaceProduct shareSingelForPubilishFinaceProduct];
    
    if (sender.tag == 101) {
        InputTextVC.str = data.detailTFContent;
    }
    if (sender.tag == 102) {
        InputTextVC.str = data.instructionDetailtfContent;
    }
    if (sender.tag == 103) {
        InputTextVC.str = data.applicableCustomerTFContent;
    }
    if (sender.tag == 104) {
        InputTextVC.str = data.requirementTF;
    }
    if (sender.tag == 105) {
        InputTextVC.str = data.materialTF;
    }
    if (sender.tag == 106) {
        InputTextVC.str = data.processTF;
    }
    if (sender.tag == 107) {
        InputTextVC.str = data.remarksTF;
    }


    
    
    
    [self.viewController.navigationController pushViewController:InputTextVC animated:YES];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
