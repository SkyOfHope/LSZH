//
//  LSBaseInformtionCell.m
//  LSZH
//
//  Created by risenb-ios5 on 16/6/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBaseInformtionCell.h"

#import "LSOfficeRentStartDateView.h"
#import "LSOfficeRentNewSizeView.h"


@interface LSBaseInformtionCell()<sureDelegate>

@property (strong, nonatomic) LSOfficeRentStartDateView *officeRentStartDateView;
@property (strong, nonatomic) LSOfficeRentNewSizeView *OfficeRentNewSizeView;


@end

@implementation LSBaseInformtionCell


- (void)awakeFromNib {
    // Initialization code
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self addGestureRecognizer:tap];
    
    
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


- (IBAction)compeleteAction:(id)sender {
    //louyuTF;
    //louhaotf;
    //loucengTF;
    //mianjiTF;
    //chaoxiangTF
    //zhuangxiuTF
    //qizuTF;
    //rizujinTF;
    //yuezujinTF;
    //mianzuqiTF;
    //sheshiTF;
    
    LStotalCompeleteModel *model = [LStotalCompeleteModel shareInstance];
    model.louyu = _louyuTF.text;
    model.diliweizhi = _diliweizhi.text;
    model.louhao = _louhaotf.text;
    model.louceng = _loucengTF.text;
    model.mianji = _mianjiTF.text;
    model.chaoxiang = _chaoxiangTF.text;
    model.zhuangxiu = _zhuangxiuTF.text;
    model.qizu = _qizuTF.text;
    model.rizujin = _rizujinTF.text;
    model.yuezujin = _yuezujinTF.text;
    model.mianzuqi = _mianzuqiTF.text;
    model.sheshi = _sheshiTF.text;
    model.detailAddress = _detailAddress.text;
    
    if (_delegate && [_delegate respondsToSelector:@selector(jibenxinxi:)]) {
        [_delegate jibenxinxi:model];
    }
    
}

//代理方法
-(void)sendDateStr:(NSString*)dateStr{
    
    NSLog(@" 起租日期 %@ ", dateStr);
    self.qizuTF.text = dateStr;
    
}

//代理方法
- (void)sureAction:(NSMutableArray *)selectArr WithType:(NSString *)type{
    switch ([type integerValue]) {
            
        case 10:{
            
            NSLog(@"请选所在地区%@",selectArr);
            
            NSString *temp = selectArr[0];
            
            NSLog(@"请选所在地区%@",temp);
            
            self.diliweizhi.text = temp;
            NSLog(@"请选所在地区%@",self.diliweizhi.text);
            
            break;
            
        }
            
        default:
            break;
            
    }
    
}



- (void)hideKeyBoard {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
