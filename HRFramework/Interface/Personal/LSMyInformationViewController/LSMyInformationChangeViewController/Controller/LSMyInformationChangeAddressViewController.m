//
//  LSMyInformationChangeAddressViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/8/11.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSMyInformationChangeAddressViewController.h"

#import "LSAdressChoicePickView.h"
#import "GGPickerview.h"

@interface LSMyInformationChangeAddressViewController ()

@property (strong ,nonatomic) NSMutableArray *totalData;


@property (weak, nonatomic) IBOutlet UITextField *detialAddress;


@property (weak, nonatomic) IBOutlet UIButton *changeButton;


@property (weak, nonatomic) IBOutlet UITextField *province;

@property (weak, nonatomic) IBOutlet UITextField *city;

@property (weak, nonatomic) IBOutlet UITextField *area;



@end

@implementation LSMyInformationChangeAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.changeButton addTarget:self action:@selector(changeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.changeButton.layer.cornerRadius = 20;
    self.changeButton.layer.masksToBounds = YES;
    
    self.totalData = [NSMutableArray array];
    
    
    self.province.text = _passAddress[0];
    self.city.text = _passAddress[1];
//    self.area.text = _passAddress[2];
    NSString *str = [_passAddress[2] substringWithRange:NSMakeRange(0, [_passAddress[2] length] - 1)];
    self.area.text = str;
    
    self.detialAddress.text = _passAddress[3];
    
//    self.detialAddress.text = self.passAddress;
    
}

-(void)changeButtonAction{
    
    if (self.detialAddress.text.length > 0 && self.totalData.count == 3) {
        
//        NSString *totalInformation = [NSString stringWithFormat:@"%@%@",self.totalData,self.detialAddress.text];
        
        [self requestWithInformation:nil];

    }else{
        
        [self tipLabelAnimationWith:@"请填入所有数据"];
        
    }

}


-(void)requestWithInformation:(NSString*)totalInformation{
    
    
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    
    //创建参数字典
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithObject:userId forKey:@"userId"];
    
    //其他参数
    [para setObject:self.detialAddress.text forKey:@"address"];//county
    [para setObject:self.totalData[0] forKey:@"province"];
    [para setObject:self.totalData[1] forKey:@"city"];
    [para setObject:self.totalData[2] forKey:@"county"];
    
    
    //网络修改数据
    [[HRRequestManager manager]POST_PATH:PATH_UpdateUser para:para success:^(id responseObject) {

        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            
            NSLog(@"修改成功");
            
            //如果修改成功,则自动跳转到首页,并且是不登陆状态
            //如果是以下项目修改会有提示不可登录
            
                //提示成功
                [self promptBox_YTC_GeneralWithWords_epinasty:@"修改成功"];
                //可以登录,返回刷新即可
                [self.delegate reloadNewinformation];
                
                [self.navigationController popViewControllerAnimated:YES];
            
            
        }else{
            [self promptBox_YTC_GeneralWithWords_epinasty:@"修改失败"];
        }
        
    } failure:^(NSError *error) {
        
    }];

    
}





- (IBAction)adressChoiceBtnAction:(UIButton *)sender {
    
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    GGPickerview *pickerView = [[GGPickerview alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-260, SCREEN_WIDTH, 260)];
    
     weakSelf(weakSelf);
    
    [pickerView getCityBlock:^(NSString *province, NSString *city, NSString *district) {
        NSLog(@"%@", province);
        
        [weakSelf.totalData addObject:province];
        [weakSelf.totalData addObject:city];
        [weakSelf.totalData addObject:district];
        
        NSLog(@"%@",self.totalData);
        
        self.province.text = province;
        self.city.text = city;
//        self.area.text = district;
        NSString *str = [district substringWithRange:NSMakeRange(0, [district length] - 1)];
        self.area.text = str;
        
        [view removeFromSuperview];
        [pickerView removeFromSuperview];
    }];
    [pickerView delCityBlock:^{
        [view removeFromSuperview];
        [pickerView removeFromSuperview];
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:pickerView];

    
    
    
    
    /*
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    GGPickerview *pickerView = [[GGPickerview alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-260, SCREEN_WIDTH, 260)];
    weakSelf(weakSelf);
    
    [pickerView getCityBlock:^(NSString *province, NSString *city, NSString *district) {
        NSLog(@"%@", province);
//        weakSelf.totalData = [NSString stringWithFormat:@"%@%@%@",province,city,district];

        
        [weakSelf.totalData addObject:province];
        [weakSelf.totalData addObject:city];
        [weakSelf.totalData addObject:district];
        
        NSLog(@"%@",self.totalData);
        
        self.province.text = province;
        self.city.text = city;
        self.area.text = district;
        
        [view removeFromSuperview];
        [pickerView removeFromSuperview];
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:pickerView];
    
    
    //*/
    
}

//提示框

-(void)tipLabelAnimationWith:(NSString*)tip{
    
    UILabel *promptLabel = [[UILabel alloc]init];
    
    CGFloat width = SCREEN_WIDTH / 2 * 1.4;
    CGFloat height = width * 0.2;
    
    promptLabel.alpha = 0;
    
    promptLabel.frame = CGRectMake(SCREEN_WIDTH / 2 - width/2 , SCREEN_WIDTH / 2 * 1.4 + 200, width, height);
    promptLabel.backgroundColor = [UIColor blackColor];
    promptLabel.textColor = [UIColor whiteColor];
    promptLabel.layer.cornerRadius = height / 2;
    promptLabel.layer.masksToBounds = YES;
    
    promptLabel.textAlignment = 1;
    
    promptLabel.layer.cornerRadius = 25;
    promptLabel.layer.masksToBounds = YES;
    
    promptLabel.text = tip;
    
    [self.view addSubview:promptLabel];
    
    [UIView animateWithDuration:1.5 animations:^{
        promptLabel.alpha = 0.8;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1 animations:^{
            promptLabel.alpha = 0;
        } completion:nil];
        
    }];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
