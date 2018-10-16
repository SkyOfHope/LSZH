//
//  LSPublishOfficeToRentCell.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSPublishOfficeToRentCell.h"
#import "LSrentModel.h"

#import "LSOfficeRentStartDateView.h"
#import "LSOfficeRentNewSizeView.h"

#import "LSInputTextViewController.h"
#import "LSSingelForPubilishFinaceProduct.h"


@interface LSPublishOfficeToRentCell ()<sureDelegate,LSOfficeRentStartDateViewDelegate,LSInputTextViewControllerDelegate>

@property (strong, nonatomic) LSOfficeRentStartDateView *officeRentStartDateView;

@property (strong, nonatomic) LSOfficeRentNewSizeView *OfficeRentNewSizeView;
//@property (nonatomic, copy) NSString *Type;

@property (weak, nonatomic) IBOutlet UITextField *titleTF;

@property (weak, nonatomic) IBOutlet UITextField *areaTF;

@property (weak, nonatomic) IBOutlet UITextField *areaMinTF;
@property (weak, nonatomic) IBOutlet UITextField *areaMaxTF;
@property (weak, nonatomic) IBOutlet UITextField *rentMinTF;
@property (weak, nonatomic) IBOutlet UITextField *rentMaxTF;

@property (weak, nonatomic) IBOutlet UITextField *peitaoSheshiTF;

@property (weak, nonatomic) IBOutlet UITextField *jiaotongTF;
@property (weak, nonatomic) IBOutlet UITextField *qizuDate;

@property (weak, nonatomic) IBOutlet UITextField *remarkTF;
@property (weak, nonatomic) IBOutlet UITextField *tipsTF;

@property (strong, nonatomic) IBOutlet UIButton *protocolBtn;


@end


@implementation LSPublishOfficeToRentCell

- (void)awakeFromNib {
    // Initialization code
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self addGestureRecognizer:tap];
    
    
//peitaoSheshiTF;
//jiaotongTF;
//tipsTF;
    
    LSSingelForPubilishFinaceProduct *data = [LSSingelForPubilishFinaceProduct shareSingelForPubilishFinaceProduct];
    data.remarkTF = nil;
    data.peitaoSheshiTF = nil;
    data.jiaotongTF = nil;
    data.tipsTF = nil;
    
}
- (void)hideKeyBoard {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}


- (IBAction)InputTextBtnAction:(UIButton *)sender {
    
    LSInputTextViewController *InputTextVC = [[LSInputTextViewController alloc] initWithNibName:@"LSInputTextViewController" bundle:nil];
    
    InputTextVC.delegate = self;
    
    InputTextVC.labelTag = sender.tag;
    
    LSSingelForPubilishFinaceProduct *data = [LSSingelForPubilishFinaceProduct shareSingelForPubilishFinaceProduct];
    
    if (sender.tag == 301) {
        InputTextVC.str = data.peitaoSheshiTF;
    }
    if (sender.tag == 302) {
        InputTextVC.str = data.jiaotongTF;
    }
    if (sender.tag == 303) {
        InputTextVC.str = data.remarkTF;
    }
    if (sender.tag == 304) {
        InputTextVC.str = data.tipsTF;
    }

    
    
    [self.viewController.navigationController pushViewController:InputTextVC animated:YES];
}



- (IBAction)protocolBtnAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
}


- (IBAction)completeAction:(id)sender {
    //titleTF;
    //areaTF;
    //areaMinTF;
    //areaMaxTF;
    //rentMinTF;
    //rentMaxTF;
    //peitaoShesh
    //jiaotongTF;
    //qizuDate;
    //remarkTF;
    //tipsTF;
    LSrentModel *model = [[LSrentModel alloc]init];
    model.title = _titleTF.text;
    model.area = _areaTF.text;
    model.areaMin = _areaMinTF.text;
    model.areaMax = _areaMaxTF.text;
    model.rentMin = _rentMinTF.text;
    model.rentMax = _rentMaxTF.text;
    model.peitaoSheshi = _peitaoSheshiTF.text;
    model.jiaotong = _jiaotongTF.text;
    model.qizuDate = _qizuDate.text;
    model.remark = _remarkTF.text;
    model.tips = _tipsTF.text;
    
    model.protocolBtn = self.protocolBtn.selected;
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(qiuzuAction:)]) {
        [_delegate qiuzuAction:model];
    }
}


//地理位置
- (IBAction)ChooseAddressBtnAction:(UIButton *)sender {
    
    self.OfficeRentNewSizeView = [[LSOfficeRentNewSizeView alloc]initType:@"10"];
    
    self.OfficeRentNewSizeView.deledate = self;
    //    self.officeRentSizeView.delegate = self;
    
    self.OfficeRentNewSizeView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
    //    self.alertView.backgroundColor = RGBColor(0, 0, 0, .5);
    self.OfficeRentNewSizeView.layer.cornerRadius = 5;
    self.OfficeRentNewSizeView.layer.masksToBounds = YES;
    [AppDelegate.window addSubview:self.OfficeRentNewSizeView];
    
    self.OfficeRentNewSizeView.frame = SCREEN_BOUNDS;
    
    
}




//起租日期
- (IBAction)StartDateToRentAction:(UIButton *)sender {
    
    self.officeRentStartDateView = [[LSOfficeRentStartDateView alloc]init];
    
    //                self.officeRentStartDateView.statusType = YES;
    
    self.officeRentStartDateView.delegate = self;
    
    self.officeRentStartDateView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
    //    self.alertView.backgroundColor = RGBColor(0, 0, 0, .5);
    self.officeRentStartDateView.layer.cornerRadius = 5;
    self.officeRentStartDateView.layer.masksToBounds = YES;
    [AppDelegate.window addSubview:self.officeRentStartDateView];
    
    self.officeRentStartDateView.frame = SCREEN_BOUNDS;
    
    [self.officeRentStartDateView hideViewWithStatusType:YES];

    
    
}

//代理方法
-(void)sendText:(NSString *)SendText WithLabelTag:(NSInteger)LabelTag{
    
    if (LabelTag == self.peitaoSheshiTF.tag) {
        self.peitaoSheshiTF.text = SendText;
    }
    if (LabelTag == self.jiaotongTF.tag) {
        self.jiaotongTF.text = SendText;
    }
    if (LabelTag == self.remarkTF.tag) {
        self.remarkTF.text = SendText;
    }
    if (LabelTag == self.tipsTF.tag) {
        self.tipsTF.text = SendText;
    }
    
    
}

- (void)sureAction:(NSMutableArray *)selectArr WithType:(NSString *)type{
    switch ([type integerValue]) {
            
        case 10:{
            
            NSLog(@"请选所在地区%@",selectArr);
            
            NSString *temp = selectArr[0];
            
            NSLog(@"请选所在地区%@",temp);
            
            self.areaTF.text = temp;
            NSLog(@"请选所在地区%@",self.areaTF.text);
            
            break;

        }
    
        default:
            break;
            
    }
    
}


-(void)sendDateStr:(NSString*)dateStr{
    
    NSLog(@" 起租日期 %@ ", dateStr);
    self.qizuDate.text = dateStr;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
