
//
//  LSPublishFinanceNeedsCell.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSPublishFinanceNeedsCell.h"
#import "UIViewExt.h"
#import "LSOfficeRentNewSizeView.h"

#import "LSInputTextViewController.h"
#import "LSSingelForPubilishFinaceProduct.h"


typedef void(^NetRequestParaModelBlockType)(LSPublishFinanceModel *model);
@interface LSPublishFinanceNeedsCell ()<sureDelegate,LSInputTextViewControllerDelegate>
{
    CGFloat _height;
    
    CGFloat  _replaceHeight;
}

@property (nonatomic, strong) LSOfficeRentNewSizeView *OfficeRentNewSizeView;


@property (nonatomic, copy)NetRequestParaModelBlockType block;


//@property (nonatomic, copy)NetRequestParaModelBlockType  netRequestParaModelBlock;




@property (strong, nonatomic) IBOutlet UITextField *titleTextField;

@property (strong, nonatomic) IBOutlet UITextField *keyWordTextField;

//融资用途
@property (strong, nonatomic) IBOutlet UITextField *financeUseTextField;

//@property (strong, nonatomic) IBOutlet UILabel *financeUseTextField;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *financeUseTextFieldViewHeight;

@property (strong, nonatomic) IBOutlet UITextField *financeMoneyTextfield;
@property (strong, nonatomic) IBOutlet UITextField *allmoneyTextField;

//可提供材料
@property (strong, nonatomic) IBOutlet UITextField *provideMaterialTextField;

//@property (strong, nonatomic) IBOutlet UILabel *provideMaterialTextField;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *provideMaterialTextFieldViewHeight;


//项目概述

@property (strong, nonatomic) IBOutlet UITextField *projectDescripeTextField;

//@property (strong, nonatomic) IBOutlet UILabel *projectDescripeTextField;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *projectDescripeTextFieldViewHeight;

//项目优势
@property (strong, nonatomic) IBOutlet UITextField *projectGoodTextField;

//@property (strong, nonatomic) IBOutlet UILabel *projectGoodTextField;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *projectGoodTextFieldViewHeight;

//@property (weak, nonatomic) IBOutlet UITextField *areaTF;// 地区
@property (weak, nonatomic) IBOutlet UITextField *insdustrytF;//所属行业
@property (weak, nonatomic) IBOutlet UITextField *intentionalTF;//意向资金
@property (weak, nonatomic) IBOutlet UITextField *financingModeTF;//融资方式
@property (strong, nonatomic) IBOutlet UITextField *financeThemeTF;//融资主体


//@property (strong, nonatomic) IBOutlet UILabel *remarkPlaceLabel;
//@property (strong, nonatomic) IBOutlet UITextView *remarkTF;  //备注
//@property (strong, nonatomic) IBOutlet UILabel *remarkTF;//备注

@property (strong, nonatomic) IBOutlet UITextField *remarkTF;//备注

@property (weak, nonatomic) IBOutlet UIButton *protocolBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ImageViewHeight;

@property (weak, nonatomic) IBOutlet UIView *trueImageView;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *renarkViewHeight;



//判断图片框是否已经变大
@property (assign, nonatomic) BOOL isBigger;

@end

@implementation LSPublishFinanceNeedsCell

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LSPublishFinanceNeedsCellreceiveImages" object:nil];
}


//从xib进行加载
- (void)awakeFromNib {
    // Initialization code
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveImages:) name:@"LSPublishFinanceNeedsCellreceiveImages" object:nil];
    
    
    self.isBigger = NO;
  
    
    _height = self.height;
    _replaceHeight = 0;
    
    
    LSSingelForPubilishFinaceProduct *data = [LSSingelForPubilishFinaceProduct shareSingelForPubilishFinaceProduct];
    data.remarkTF = nil;
    data.financeUseTextField = nil;
    data.provideMaterialTextField = nil;
    data.projectDescripeTextField = nil;
    data.projectGoodTextField = nil;

    
    
//financeUseTextField;
//provideMaterialTextField;
//projectDescripeTextField;
//projectGoodTextField;
//remarkTF;
    
    
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
            
            self.isBigger = NO;
            self.ImageViewHeight.constant = self.ImageViewHeight.constant - 100;
            
        }
        
        self.blockForSuccess(self.isBigger);
        
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
    
    
    
    /*
     NSInteger X = selectImgArr.count;
     for (int i = 0; i<X ; i++) {
     UIImageView *showImgV = [[UIImageView alloc]initWithImage:selectImgArr[i]];
     [_uploadImg addSubview:showImgV];
     showImgV.frame = CGRectMake(60+(70*i), _addImgBtn.top, 60, 60);
     showImgV.image = selectImgArr[i];
     [self.uploadImg addSubview:showImgV];
     self.addImgBtn.frame = CGRectMake(_uploadImg.right+5, 5, 60, 60);
     }
     */
    
}

-(void)shanchutupian:(UIButton*)sender{
    
    NSLog(@"%zd",sender.tag);
    
    //    [[NSNotificationCenter defaultCenter]postNotificationName:@"shanchutupianweilefabujinrongchanpinxinxi" object:sender userInfo:nil];
    
    [self.delegate deleteImage:sender.tag];
    
}



-(void)addImgAction{
    
    if (_delegate && [_delegate respondsToSelector:@selector(uploadAction)]) {
        [_delegate uploadAction];
    }
    
}

- (void)hideKeyBoard {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}

- (void) industrySelect {

    if (_delegate && [_delegate respondsToSelector:@selector(industrySelectAction)]) {
        [_delegate industrySelectAction];
    }

}


#pragma mark - ||========== IBActions ===========||

- (IBAction)InputTextBtnAction:(UIButton *)sender {
    
    LSInputTextViewController *InputTextVC = [[LSInputTextViewController alloc] initWithNibName:@"LSInputTextViewController" bundle:nil];
    
    InputTextVC.delegate = self;
    InputTextVC.labelTag = sender.tag;
    
    LSSingelForPubilishFinaceProduct *data = [LSSingelForPubilishFinaceProduct shareSingelForPubilishFinaceProduct];
    
    if (sender.tag == 201) {
        InputTextVC.str = data.financeUseTextField;
    }
    if (sender.tag == 202) {
        InputTextVC.str = data.provideMaterialTextField;
    }
    if (sender.tag == 203) {
        InputTextVC.str = data.projectDescripeTextField;
    }
    if (sender.tag == 204) {
        InputTextVC.str = data.projectGoodTextField;
    }
    if (sender.tag == 205) {
        InputTextVC.str = data.remarkTF;
    }

    
    
    [self.viewController.navigationController pushViewController:InputTextVC animated:YES];
}


//所在地区
- (IBAction)areaBtnAction:(UIButton *)sender {
    
    self.OfficeRentNewSizeView = [[LSOfficeRentNewSizeView alloc]initType:@"9"];
    
    self.OfficeRentNewSizeView.deledate = self;
    //    self.officeRentSizeView.delegate = self;
    
    self.OfficeRentNewSizeView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
    //    self.alertView.backgroundColor = RGBColor(0, 0, 0, .5);
    self.OfficeRentNewSizeView.layer.cornerRadius = 5;
    self.OfficeRentNewSizeView.layer.masksToBounds = YES;
    [AppDelegate.window addSubview:self.OfficeRentNewSizeView];
    
    self.OfficeRentNewSizeView.frame = SCREEN_BOUNDS;
    
}

//融资主体
- (IBAction)FinanceThemeBtnAction:(UIButton *)sender {
    
    self.OfficeRentNewSizeView = [[LSOfficeRentNewSizeView alloc]initType:@"8"];
    
    self.OfficeRentNewSizeView.deledate = self;
    //    self.officeRentSizeView.delegate = self;
    
    self.OfficeRentNewSizeView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
    //    self.alertView.backgroundColor = RGBColor(0, 0, 0, .5);
    self.OfficeRentNewSizeView.layer.cornerRadius = 5;
    self.OfficeRentNewSizeView.layer.masksToBounds = YES;
    [AppDelegate.window addSubview:self.OfficeRentNewSizeView];
    
    self.OfficeRentNewSizeView.frame = SCREEN_BOUNDS;
    
}


//所属行业
- (IBAction)ChooseHangYeBtnAction:(UIButton *)sender {
    
    self.OfficeRentNewSizeView = [[LSOfficeRentNewSizeView alloc]initType:@"1"];
    self.OfficeRentNewSizeView.deledate = self;
    
    //    self.officeRentSizeView.delegate = self;
    
    self.OfficeRentNewSizeView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
    //    self.alertView.backgroundColor = RGBColor(0, 0, 0, .5);
    self.OfficeRentNewSizeView.layer.cornerRadius = 5;
    self.OfficeRentNewSizeView.layer.masksToBounds = YES;
    [AppDelegate.window addSubview:self.OfficeRentNewSizeView];
    
    self.OfficeRentNewSizeView.frame = SCREEN_BOUNDS;
    
    
    
}


//意向资金
- (IBAction)FinanceMoneyBtnAction:(UIButton *)sender {
    
    NSLog(@"意向资金意向资金意向资金意向资金意向资金");
    
    self.OfficeRentNewSizeView = [[LSOfficeRentNewSizeView alloc]initType:@"2"];
   
    self.OfficeRentNewSizeView.deledate = self;
    
    //    self.officeRentSizeView.delegate = self;
    
    self.OfficeRentNewSizeView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
    //    self.alertView.backgroundColor = RGBColor(0, 0, 0, .5);
    self.OfficeRentNewSizeView.layer.cornerRadius = 5;
    self.OfficeRentNewSizeView.layer.masksToBounds = YES;
    [AppDelegate.window addSubview:self.OfficeRentNewSizeView];
    
    self.OfficeRentNewSizeView.frame = SCREEN_BOUNDS;
    
    
}

//融资方式
- (IBAction)FinanceWayBtnAction:(UIButton *)sender {
    
    self.OfficeRentNewSizeView = [[LSOfficeRentNewSizeView alloc]initType:@"3"];
    
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


- (IBAction)completeBtnAction:(UIButton *)sender {
    
    NSLog(@"完成数据请求");
    
    LSPublishFinanceModel *model = [[LSPublishFinanceModel alloc] init];
    
//&& self.areaTF.text.length > 0 
    if (self.titleTextField.text.length > 0 && self.keyWordTextField.text.length > 0 && self.financeMoneyTextfield.text.length > 0 && self.allmoneyTextField.text.length > 0 && self.provideMaterialTextField.text.length > 0 && self.projectDescripeTextField.text.length > 0 && self.projectGoodTextField.text.length > 0 && self.insdustrytF.text.length > 0 && self.financingModeTF.text.length > 0 && self.financeUseTextField.text.length > 0  && self.financeThemeTF.text.length > 0  && self.remarkTF.text.length > 0) {

        if (self.protocolBtn.selected) {
            
            model.title = self.titleTextField.text;
            model.keyWord = self.keyWordTextField.text;
            model.financeUse = self.financeUseTextField.text;
            model.financeMoney = self.financeMoneyTextfield.text;
            model.allmoney = self.allmoneyTextField.text;
            model.provideMaterial = self.provideMaterialTextField.text;
            model.projectDescripe = self.projectDescripeTextField.text;
            model.projectGood = self.projectGoodTextField.text;
            
            
//            model.area = self.areaTF.text;
            model.insdustry = self.insdustrytF.text;
            model.financingMode = self.financingModeTF.text;
//<<<<<<< .mine
            model.financeTheme = self.financeThemeTF.text;
            model.remark = self.remarkTF.text;
            
            self.block(model);
            
            
//>>>>>>> .r808
        }else{
            if ([self.delegate respondsToSelector:@selector(promptForCell:)]) {
                [self.delegate promptForCell:@"请勾选 保证上述信息真实有效"];
            }
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(promptForCell:)]) {
            [self.delegate promptForCell:@"请填写所有数据"];
        }else{
            return;
        }
    }

    //    Model *m = [[Model alloc] init];

    
}


//上传图片
- (IBAction)uploadImgAction:(id)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(uploadAction)]) {
        [_delegate uploadAction];
    }
    
}


- (void)prepareNetRequest:(void (^)(LSPublishFinanceModel *model))block {
    self.block = block;
    
}


#pragma mark --- 代理方法

-(void)sendText:(NSString *)SendText WithLabelTag:(NSInteger)LabelTag{
    
    if (LabelTag == self.financeUseTextField.tag) {
        self.financeUseTextField.text = SendText;
    }
    if (LabelTag == self.provideMaterialTextField.tag) {
        self.provideMaterialTextField.text = SendText;
    }
    if (LabelTag == self.projectDescripeTextField.tag) {
        self.projectDescripeTextField.text = SendText;
    }
    if (LabelTag == self.projectGoodTextField.tag) {
        self.projectGoodTextField.text = SendText;
    }
    if (LabelTag == self.remarkTF.tag) {
        self.remarkTF.text = SendText;
    }
    
    
    
}

- (void)sureAction:(NSMutableArray *)selectArr WithType:(NSString *)type{
//    self.suoshuhangye.text = @"已选择";
    
    
    switch ([type integerValue]) {
        case 1:{
            
            NSLog(@"%@",selectArr);
            
            NSMutableString *temp = [NSMutableString string];
            for (NSString *str in selectArr) {
                [temp appendFormat:@"%@",str];
            }
            
            self.insdustrytF.text = temp;
            break;
        }
        case 2:{
            
            NSLog(@"请选择意向资金%@",selectArr);
            
            NSString *temp = selectArr[0];
            
            NSLog(@"请选择意向资金%@",temp);
            
            self.intentionalTF.text = temp;
            
            break;
        }
        case 3:{
            
            NSLog(@"请选择融资方式%@",selectArr);
            
            NSString *temp = selectArr[0];
            
            NSLog(@"请选择融资方式%@",temp);
            
            self.financingModeTF.text = temp;
            
            break;
        }
        case 8:{
            
            NSLog(@"请选择融资方式%@",selectArr);
            
            NSString *temp = selectArr[0];
            
            NSLog(@"请选择融资主体%@",temp);
            
            self.financeThemeTF.text = temp;
            
            break;
        }
//        case 9:{
//            
//            NSLog(@"请选所在地区%@",selectArr);
//            
//            NSString *temp = selectArr[0];
//            
//            NSLog(@"请选所在地区%@",temp);
//            
//            self.areaTF.text = temp;
//            
//            break;
//        }

        

            
        default:
            break;
    }

    
    
}


/*//
#pragma mark=========UITextFieldDelegate===========

#pragma mark=============UITextViewDelegate==================
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    [self.delegate getOffset];
    
    if (textView == self.remarkTF) {
        self.remarkPlaceLabel.hidden = YES;
    }
    if (textView == self.financeUseTextField) {
        self.financeUseTextFieldLabel.hidden = YES;
    }
    if (textView == self.provideMaterialTextField) {
        self.provideMaterialTextFieldLabel.hidden = YES;
    }
    if (textView == self.projectDescripeTextField) {
        self.projectDescripeTextFieldLabel.hidden = YES;
    }
    if (textView == self.projectGoodTextField) {
        self.projectGoodTextFieldLabel.hidden = YES;
    }

    
    
}

-(void)textViewDidChange:(UITextView *)textView
{
    
    if (textView == self.financeUseTextField){
        
        
        NSDictionary *attribute = @{NSFontAttributeName:self.financeUseTextField.font};
        CGRect frame = self.financeUseTextField.frame;
        CGFloat H = [LSCommon getContentHeight:self.financeUseTextField.text defaultWidth:SCREEN_WIDTH - 30 attributes:attribute];
        CGSize size = CGSizeMake(self.financeUseTextField.width, H);
        
        frame.size.height = size.height > 1 ? size.height + 20 : 64;
        self.financeUseTextField.frame = frame;
        
        self.financeUseTextFieldViewHeight.constant = size.height + 51;
        
        _replaceHeight = self.height;
        
    }else if (textView == self.provideMaterialTextField){
        
        NSDictionary *attribute = @{NSFontAttributeName:self.provideMaterialTextField.font};
        CGRect frame = self.provideMaterialTextField.frame;
        CGFloat H = [LSCommon getContentHeight:self.provideMaterialTextField.text defaultWidth:SCREEN_WIDTH - 30 attributes:attribute];
        CGSize size = CGSizeMake(self.provideMaterialTextField.width, H);
        
        frame.size.height = size.height > 1 ? size.height + 20 : 64;
        self.provideMaterialTextField.frame = frame;
        
        self.provideMaterialTextFieldViewHeight.constant = size.height + 51;
        
        _replaceHeight = self.height;
        
    }else if (textView == self.provideMaterialTextField){
        
        NSDictionary *attribute = @{NSFontAttributeName:self.provideMaterialTextField.font};
        CGRect frame = self.provideMaterialTextField.frame;
        CGFloat H = [LSCommon getContentHeight:self.provideMaterialTextField.text defaultWidth:SCREEN_WIDTH - 30 attributes:attribute];
        CGSize size = CGSizeMake(self.provideMaterialTextField.width, H);
        
        frame.size.height = size.height > 1 ? size.height + 20 : 64;
        self.provideMaterialTextField.frame = frame;
        
        self.provideMaterialTextFieldViewHeight.constant = size.height + 51;
        
        _replaceHeight = self.height;
        
    }else if (textView == self.projectGoodTextField){
        
        NSDictionary *attribute = @{NSFontAttributeName:self.projectGoodTextField.font};
        CGRect frame = self.projectGoodTextField.frame;
        CGFloat H = [LSCommon getContentHeight:self.projectGoodTextField.text defaultWidth:SCREEN_WIDTH - 30 attributes:attribute];
        CGSize size = CGSizeMake(self.projectGoodTextField.width, H);
        
        frame.size.height = size.height > 1 ? size.height + 20 : 64;
        self.projectGoodTextField.frame = frame;
        
        self.projectGoodTextFieldViewHeight.constant = size.height + 51;
        
        _replaceHeight = self.height;
        
    }else if (textView == self.remarkTF){
        
        NSDictionary *attribute = @{NSFontAttributeName:self.remarkTF.font};
        CGRect frame = self.remarkTF.frame;
        CGFloat H = [LSCommon getContentHeight:self.remarkTF.text defaultWidth:SCREEN_WIDTH - 30 attributes:attribute];
        CGSize size = CGSizeMake(self.remarkTF.width, H);
        
        frame.size.height = size.height > 1 ? size.height + 20 : 64;
        self.remarkTF.frame = frame;
        
        self.renarkViewHeight.constant = size.height + 51;
        
        _replaceHeight = self.height;
        
    }
    
//     NSDictionary *attribute = @{NSFontAttributeName:self.remarkTF.font};
//    CGRect frame = self.remarkTF.frame;
//    CGFloat H = [LSCommon getContentHeight:self.remarkTF.text defaultWidth:self.remarkTF.width attributes:attribute];
//    CGSize size = CGSizeMake(self.remarkTF.width, H);
//
//    frame.size.height = size.height > 1 ? size.height + 21 : 64;
//    self.remarkTF.frame = frame;
//    self.renarkViewHeight.constant = self.renarkViewHeight.constant-32+frame.size.height;
//    self.height = _height-32+self.remarkTF.height;

    [_delegate reloadData];
    
}




-(void)textViewDidEndEditing:(UITextView *)textView{

    
    [self.delegate setOffset];
    
}

//WithHeight:(CGFloat)cellHeight
-(void)TextViewHeight:(NSLayoutConstraint *)TextViewHeight  WithTextView:(UITextView *)textView {
    
    NSDictionary *attribute = @{NSFontAttributeName:textView.font};
    CGRect frame = textView.frame;
    CGFloat H = [LSCommon getContentHeight:textView.text defaultWidth:textView.width attributes:attribute];
    CGSize size = CGSizeMake(textView.width, H);
    
    frame.size.height = size.height > 1 ? size.height + 21 : 64;
    textView.frame = frame;
    TextViewHeight.constant = TextViewHeight.constant - 33+frame.size.height;
    self.height = _height - 33 + textView.height;
    
    //    _instrucionHeight = _instrucionHeight + TextViewHeight.constant;
    _replaceHeight = _replaceHeight + TextViewHeight.constant;
    
    
    
}

//-(void)textViewDidChangeSelection:(UITextView *)textView{
//
//    NSInteger wordCount = 500 - textView.text.length;
//
//    self.leftWordLabel.text = [NSString stringWithFormat:@"%zd/500",wordCount];
//
//}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    //    if ([text isEqualToString:@"/n"]) {
    //        return 0;
    //    }
    
    //    if (range.location >= 500)
    if(textView.text.length >= 500){
        
        return NO;
    }else{
        
        return YES;
    }
    
}
 //*/



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
