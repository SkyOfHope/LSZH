//
//  LSPublishFinanceProductHeaderView.m
//  LSZH
//
//  Created by risenb-ios5 on 16/7/8.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSPublishFinanceProductHeaderView.h"

#import "UIViewExt.h"

#import "LSProductTypeView.h"

#import "LSOfficeRentNewSizeView.h"


@interface  LSPublishFinanceProductHeaderView()<sureDelegate, UITextViewDelegate>

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
@property (strong, nonatomic) IBOutlet UITextView *detailTF;
@property (strong, nonatomic) IBOutlet UILabel *detailPlaceLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *detailTFViewHeight;

//@property (weak, nonatomic) IBOutlet UITextField *detailTF;
//具体信息
@property (strong, nonatomic) IBOutlet UITextView *instructionDetailtf;
@property (strong, nonatomic) IBOutlet UILabel *instructionDetailtfLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *instructionDetailViewHeight;

//@property (weak, nonatomic) IBOutlet UITextField *instructionDetailtf;


//适用客户
@property (strong, nonatomic) IBOutlet UITextView *applicableCustomerTF;
@property (strong, nonatomic) IBOutlet UILabel *applicableCustomerTFLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *applicableCustomerTFViewHeight;


//@property (weak, nonatomic) IBOutlet UITextField *applicableCustomerTF;
//申请条件
@property (strong, nonatomic) IBOutlet UITextView *requirementTF;
@property (strong, nonatomic) IBOutlet UILabel *requirementTFLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *requirementTFViewHeight;

//@property (weak, nonatomic) IBOutlet UITextField *requirementTF;

//所需材料
@property (strong, nonatomic) IBOutlet UITextView *materialTF;
@property (strong, nonatomic) IBOutlet UILabel *materialTFLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *materialTFViewHeight;



//@property (weak, nonatomic) IBOutlet UITextField *materialTF;
//办理流程
@property (strong, nonatomic) IBOutlet UITextView *processTF;
@property (strong, nonatomic) IBOutlet UILabel *processTFLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *processTFViewLabel;


//@property (weak, nonatomic) IBOutlet UITextField *processTF;

@property (weak, nonatomic) IBOutlet UITextField *keyWordsTF;

//备注
@property (strong, nonatomic) IBOutlet UITextView *remarksTF;
@property (strong, nonatomic) IBOutlet UILabel *remarksTFLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *remarksTFViewHeight;


//500字以内
@property (strong, nonatomic) IBOutlet UILabel *leftWordLabel;


//@property (weak, nonatomic) IBOutlet UITextField *remarksTF;

//@property (weak, nonatomic) UIButton *selectBtn;
@property (strong, nonatomic) IBOutlet UIButton *protocolBtn;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ImageViewHeight;

@property (weak, nonatomic) IBOutlet UIView *trueImageView;

//判断是否已经扩大了图片框
@property (assign, nonatomic) BOOL isBigger;


@end


@implementation LSPublishFinanceProductHeaderView


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LSPublishFinanceProductCellreceiveImages" object:nil];
}

- (void)awakeFromNib {
    // Initialization code
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveImages:) name:@"LSPublishFinanceProductCellreceiveImages" object:nil];
    self.isBigger = NO;
    
    self.detailTF.delegate = self;
    self.instructionDetailtf.delegate = self;
    self.applicableCustomerTF.delegate = self;
    self.requirementTF.delegate = self;
    self.materialTF.delegate = self;
    self.processTF.delegate = self;
    self.remarksTF.delegate = self;
    
    
    _height = self.height;
    _instrucionHeight = 0;
    _replaceHeight = 0;
    
    NSLog(@" @#@##@#@#@#@#@  %lf  @#@#@#@#@##@#@#@#@ ",self.height);
    
}

- (void)receiveImages:(NSNotification *)notifycation
{
    id result = notifycation.object;
    NSLog(@"object = %@", result);
    
    //先移除之前的所有控件
    for (UIView *smallView in self.trueImageView.subviews) {
        
        [smallView removeFromSuperview];
        
    }
    
    CGFloat widthForImage = (self.trueImageView.frame.size.width - 20);
    
    //增加显示图片的View的高度
    //在九宫格布局
    if ([result isKindOfClass:[NSArray class]]) {
        NSArray *selectImgArr = (NSArray *)result;
        
        //增加显示图片的View的高度
        
        if (selectImgArr.count >= 4 && self.isBigger == NO) {
            
            self.isBigger = YES;
            
            self.ImageViewHeight.constant = self.ImageViewHeight.constant + 70;
        }
        
        //九宫格布局
        
        for (int i = 0; i < selectImgArr.count; i ++) {
            
            NSInteger row = i / 4;
            NSInteger col = i % 4;
            
            
            UIImageView *showImgV = [[UIImageView alloc]initWithImage:selectImgArr[i]];
            [self.trueImageView addSubview:showImgV];
            showImgV.frame = CGRectMake(10+(70*col), 5 + 65 * row , 60, 60);
            showImgV.image = selectImgArr[i];
            
            //添加多一个按钮
            
            if (i == selectImgArr.count - 1) {
                
                if (i == 3) {
                    
                    UIButton *lastBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 5 + 65 * 1 , 60, 60)];
                    [self.trueImageView addSubview:lastBtn];
                    [lastBtn setBackgroundImage:[UIImage imageNamed:@"上传照片"] forState:UIControlStateNormal];
                    //添加方法
                    [lastBtn addTarget:self action:@selector(addImgAction) forControlEvents:UIControlEventTouchUpInside];
                    
                }else{
                    
                    UIButton *lastBtn = [[UIButton alloc]initWithFrame:CGRectMake(10+(70* (col + 1)), 5 + 65 * row , 60, 60)];
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

-(void)addImgAction{
    
    if (_delegate && [_delegate respondsToSelector:@selector(uploadImg)]) {
        [_delegate uploadImg];
    }
    
}


- (void)hideKeyBoard {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}


#pragma mark ---- 代理方法
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


#pragma mark=============UITextViewDelegate==================
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    CGFloat height = textView.frame.origin.y;
    
    
    
    [self.delegate getOffset:height];
    
    if (textView == self.detailTF) {
        self.detailPlaceLabel.hidden = YES;
    }
    if (textView == self.instructionDetailtf) {
        self.instructionDetailtfLabel.hidden = YES;
    }
    if (textView == self.applicableCustomerTF) {
        self.applicableCustomerTFLabel.hidden = YES;
    }
    if (textView == self.requirementTF) {
        self.requirementTFLabel.hidden = YES;
    }
    if (textView == self.materialTF) {
        self.materialTFLabel.hidden = YES;
    }
    if (textView == self.processTF) {
        self.processTFLabel.hidden = YES;
    }
    if (textView == self.remarksTF) {
        self.remarksTFLabel.hidden = YES;
    }
    
}

-(void)textViewDidChange:(UITextView *)textView
{
    
    if (textView == self.detailTF) {
        
        NSDictionary *attribute = @{NSFontAttributeName:self.detailTF.font};
        CGRect frame = self.detailTF.frame;
        CGFloat H = [LSCommon getContentHeight:[NSString stringWithFormat:@"%@ ",self.detailTF.text] defaultWidth:SCREEN_WIDTH - 40 attributes:attribute];
        CGSize size = CGSizeMake(self.detailTF.width, H);
        
        frame.size.height = size.height > 1 ? size.height + 20 : 64;
        self.detailTF.frame = frame;
        
        self.detailTFViewHeight.constant = size.height + 51;
        if (_lastTextViewHeight != size.height && _lastTextViewHeight != 0) {
            [_delegate reloadData];
        }
        _lastTextViewHeight = size.height;
        _replaceHeight = self.height;
        
        
        //        NSDictionary *attribute = @{NSFontAttributeName:self.detailTF.font};
        //        CGRect frame = self.detailTF.frame;
        //        CGFloat H = [LSCommon getContentHeight:self.detailTF.text defaultWidth:SCREEN_WIDTH - 20 attributes:attribute];
        //        CGSize size = CGSizeMake(self.detailTF.width, H);
        //
        //        frame.size.height = size.height > 1 ? size.height + 20 : 64;
        //        self.detailTF.frame = frame;
        //
        //
        //        self.detailTFViewHeight.constant = size.height + 51;
        //
        //        _replaceHeight = self.height;
        
        //        _instrucionHeight = self.height;
        
        
    }else if (textView == self.instructionDetailtf){
        
        
        NSDictionary *attribute = @{NSFontAttributeName:self.instructionDetailtf.font};
        CGRect frame = self.instructionDetailtf.frame;
        CGFloat H = [LSCommon getContentHeight:[NSString stringWithFormat:@"%@ ",self.instructionDetailtf.text] defaultWidth:SCREEN_WIDTH - 30 attributes:attribute];
        CGSize size = CGSizeMake(self.instructionDetailtf.width, H);
        
        frame.size.height = size.height > 1 ? size.height + 20 : 64;
        self.instructionDetailtf.frame = frame;
        
        self.instructionDetailViewHeight.constant = size.height + 51;
        if (_lastTextViewHeight != size.height && _lastTextViewHeight != 0) {
            [_delegate reloadData];
        }
        _lastTextViewHeight = size.height;
        
        //        _replaceHeight = self.height;
        
    }else if (textView == self.applicableCustomerTF){
        
        NSDictionary *attribute = @{NSFontAttributeName:self.applicableCustomerTF.font};
        CGRect frame = self.applicableCustomerTF.frame;
        CGFloat H = [LSCommon getContentHeight:[NSString stringWithFormat:@"%@ ",self.applicableCustomerTF.text] defaultWidth:SCREEN_WIDTH - 20 attributes:attribute];
        CGSize size = CGSizeMake(self.applicableCustomerTF.width, H);
        
        frame.size.height = size.height > 1 ? size.height + 20 : 64;
        self.applicableCustomerTF.frame = frame;
        
        self.applicableCustomerTFViewHeight.constant = size.height + 51;
        if (_lastTextViewHeight != size.height && _lastTextViewHeight != 0) {
            [_delegate reloadData];
        }
        _lastTextViewHeight = size.height;
        
        //        _replaceHeight = self.height;
        
    }else if (textView == self.requirementTF){
        
        NSDictionary *attribute = @{NSFontAttributeName:self.requirementTF.font};
        CGRect frame = self.requirementTF.frame;
        CGFloat H = [LSCommon getContentHeight:[NSString stringWithFormat:@"%@ ",self.requirementTF.text] defaultWidth:SCREEN_WIDTH - 20 attributes:attribute];
        CGSize size = CGSizeMake(self.requirementTF.width, H);
        
        frame.size.height = size.height > 1 ? size.height + 20 : 64;
        self.requirementTF.frame = frame;
        
        self.requirementTFViewHeight.constant = size.height + 51;
        if (_lastTextViewHeight != size.height && _lastTextViewHeight != 0) {
            [_delegate reloadData];
        }
        _lastTextViewHeight = size.height;
        
        //        _replaceHeight = self.height;
        
    }else if (textView == self.materialTF){
        
        NSDictionary *attribute = @{NSFontAttributeName:self.materialTF.font};
        CGRect frame = self.materialTF.frame;
        CGFloat H = [LSCommon getContentHeight:[NSString stringWithFormat:@"%@ ",self.materialTF.text] defaultWidth:SCREEN_WIDTH - 20 attributes:attribute];
        CGSize size = CGSizeMake(self.materialTF.width, H);
        
        frame.size.height = size.height > 1 ? size.height + 20 : 64;
        self.materialTF.frame = frame;
        
        self.materialTFViewHeight.constant = size.height + 51;
        if (_lastTextViewHeight != size.height && _lastTextViewHeight != 0) {
            [_delegate reloadData];
        }
        _lastTextViewHeight = size.height;
        
        //        _replaceHeight = self.height;
        
    }else if (textView == self.processTF){
        
        NSDictionary *attribute = @{NSFontAttributeName:self.processTF.font};
        CGRect frame = self.processTF.frame;
        CGFloat H = [LSCommon getContentHeight:[NSString stringWithFormat:@"%@ ",self.processTF.text] defaultWidth:SCREEN_WIDTH - 20 attributes:attribute];
        CGSize size = CGSizeMake(self.processTF.width, H);
        
        frame.size.height = size.height > 1 ? size.height + 20 : 64;
        self.processTF.frame = frame;
        
        self.processTFViewLabel.constant = size.height + 51;
        if (_lastTextViewHeight != size.height && _lastTextViewHeight != 0) {
            [_delegate reloadData];
        }
        _lastTextViewHeight = size.height;
        
        //        _replaceHeight = self.height;
        
    }else if (textView == self.remarksTF){
        
        NSDictionary *attribute = @{NSFontAttributeName:self.remarksTF.font};
        CGRect frame = self.remarksTF.frame;
        CGFloat H = [LSCommon getContentHeight:[NSString stringWithFormat:@"%@ ",self.remarksTF.text] defaultWidth:SCREEN_WIDTH - 20 attributes:attribute];
        CGSize size = CGSizeMake(self.remarksTF.width, H);
        
        frame.size.height = size.height > 1 ? size.height + 20 : 64;
        self.remarksTF.frame = frame;
        
        self.remarksTFViewHeight.constant = size.height + 51;
        if (_lastTextViewHeight != size.height && _lastTextViewHeight != 0) {
            [_delegate reloadData];
        }
        _lastTextViewHeight = size.height;
        
        //        _replaceHeight = self.height;
        
    }
    
    
    
    
    
    
}




-(void)textViewDidEndEditing:(UITextView *)textView{
    
    _lastTextViewHeight = 0;
    [_delegate reloadData];
    
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


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    
    if(textView.text.length >= 500){
        
        return NO;
    }else{
        
        return YES;
    }
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
