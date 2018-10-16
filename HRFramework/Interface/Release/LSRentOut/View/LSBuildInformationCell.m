//
//  LSBuildInformationCell.m
//  LSZH
//
//  Created by risenb-ios5 on 16/6/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBuildInformationCell.h"

//#import "LSBuildingTypeView.h"
//#import "LSWuYeView.h"
#import "LSOfficeRentNewSizeView.h"
#import "LSOfficeRentStartDateView.h"


@interface LSBuildInformationCell()<sureDelegate>

@property (nonatomic, strong) LSOfficeRentNewSizeView *OfficeRentNewSizeView;
//@property (strong, nonatomic) LSBuildingTypeView *buildingTypeView;
//@property (strong, nonatomic) LSWuYeView *wuYeView;
@property (strong, nonatomic) LSOfficeRentStartDateView *officeRentStartDateView;

@end


@implementation LSBuildInformationCell

- (void)awakeFromNib {
    // Initialization code
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self addGestureRecognizer:tap];
    
    
}
- (void)hideKeyBoard {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}

#pragma mark - ||========== IBActions ===========||
//建筑类型
- (IBAction)BuidingTypeBtnAction:(UIButton *)sender {
    
    
    self.OfficeRentNewSizeView = [[LSOfficeRentNewSizeView alloc]initType:@"5"];
    
    self.OfficeRentNewSizeView.deledate = self;
    //    self.officeRentSizeView.delegate = self;
    
    self.OfficeRentNewSizeView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
    //    self.alertView.backgroundColor = RGBColor(0, 0, 0, .5);
    self.OfficeRentNewSizeView.layer.cornerRadius = 5;
    self.OfficeRentNewSizeView.layer.masksToBounds = YES;
    [AppDelegate.window addSubview:self.OfficeRentNewSizeView];
    
    self.OfficeRentNewSizeView.frame = SCREEN_BOUNDS;
    
}

//物业级别
- (IBAction)WuYeBtnAction:(UIButton *)sender {
    
    NSLog(@"物业级别物业级别物业级别物业级别物业级别物业级别");
    
    self.OfficeRentNewSizeView = [[LSOfficeRentNewSizeView alloc]initType:@"6"];
    
    self.OfficeRentNewSizeView.deledate = self;
    
    //    self.officeRentSizeView.delegate = self;
    
    self.OfficeRentNewSizeView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
    //    self.alertView.backgroundColor = RGBColor(0, 0, 0, .5);
    self.OfficeRentNewSizeView.layer.cornerRadius = 5;
    self.OfficeRentNewSizeView.layer.masksToBounds = YES;
    [AppDelegate.window addSubview:self.OfficeRentNewSizeView];
    
    self.OfficeRentNewSizeView.frame = SCREEN_BOUNDS;
    
    
//    self.wuYeView = [[LSWuYeView alloc]init];
//    
//    //    self.officeRentSizeView.delegate = self;
//    
//    self.wuYeView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
//    //    self.alertView.backgroundColor = RGBColor(0, 0, 0, .5);
//    self.wuYeView.layer.cornerRadius = 5;
//    self.wuYeView.layer.masksToBounds = YES;
//    [AppDelegate.window addSubview:self.wuYeView];
//    
//    self.wuYeView.frame = SCREEN_BOUNDS;

    
}


//入住时间
- (IBAction)RuZhuShiJianBtnAcion:(UIButton *)sender {
    
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
    //jianzhuleixingTF;
    //jianzhumianjiTF;
    //jingcenggaoTF;
    //wuyejibieTF;
    //ruzhushijianTF;
    //kaifashangTF;
    //shejidanweiTF;
    //shigongdanweiTF;
    LStotalCompeleteModel *model = [LStotalCompeleteModel shareInstance];
    model.jianzhuleixing = _jianzhuleixingTF.text;
    model.jianzhumianji = _jianzhumianjiTF.text;
    model.jingcenggao = _jingcenggaoTF.text;
    model.wuyejibie = _wuyejibieTF.text;
    model.ruzhushijian = _ruzhushijianTF.text;
    model.kaifashang = _kaifashangTF.text;
    model.shejidanwei = _shejidanweiTF.text;
    model.shigongdanwei = _shigongdanweiTF.text;
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(jianzhuxinxi:)]) {
        [_delegate jianzhuxinxi:model];
    }
}


//代理方法
-(void)sendDateStr:(NSString*)dateStr{
    
    NSLog(@" 起租日期 %@ ", dateStr);
    self.ruzhushijianTF.text = dateStr;
    
}

#pragma mark -----代理方法
-(void)sureAction:(NSMutableArray *)selectArr WithType:(NSString *)type{
    
    switch ([type integerValue]) {
        case 5:{
            
            NSLog(@"建筑类型%@",selectArr);
            
            NSString *temp = selectArr[0];
            
            NSLog(@"建筑类型%@",temp);
            
            self.jianzhuleixingTF.text = temp;
            
            break;
        }
        case 6:{
            
            NSLog(@"物业级别%@",selectArr);
            
            NSString *temp = selectArr[0];
            
            NSLog(@"物业级别%@",temp);
            
            self.wuyejibieTF.text = temp;
            
            break;
        }
    
        default:
            break;
    }
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
