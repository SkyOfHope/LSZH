//
//  LSRegistViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/31.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSRegistViewController.h"

#import "LSRegistIdentifierViewController.h"

#import "LSRegistDataModel.h"

#import "HRRegular.h"

#import "LSRegistProtocolViewController.h"
#import "LSRegistProtocolController.h"

@interface LSRegistViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *agreeBtn;

- (IBAction)LoginBtn:(id)sender;



@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *testCode;
@property (strong, nonatomic) IBOutlet UITextField *keyWord;
@property (strong, nonatomic) IBOutlet UITextField *sureKeyWord;
@property (strong, nonatomic) NSMutableDictionary *data;

//注册协议添加点击事件
@property (weak, nonatomic) IBOutlet UILabel *registProtocol;


- (IBAction)dismissBtn:(id)sender;


//验证码 对比数据
@property (strong, nonatomic) NSMutableDictionary *codeFromServer;

//倒计时相关

@property (weak, nonatomic) IBOutlet UIButton *countButton;

- (IBAction)countDownBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;

@property (assign, nonatomic) NSInteger seconds;

@property (strong, nonatomic) NSTimer *clockTimer;

@end

@implementation LSRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.data = [NSMutableDictionary dictionary];
    self.testCode.keyboardType = UIKeyboardTypeNumberPad;
    //添加点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(protocolController)];
    
    [self.registProtocol addGestureRecognizer:tap];
    
    self.phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    
    //设置label显示

    UIColor *textColor = [UIColor colorWithRed:108/255.0 green:178/255.0 blue:237/255.0 alpha:1];


    
    if (self.registProtocol.text.length >=21) {
        //防止崩溃,下面的长度一定要小于等于上面的判断长度
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:self.registProtocol.text];
        [attribute addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(2, 21)];
        self.registProtocol.attributedText = attribute;
    }
    
    //短信label的文字颜色
    self.countDownLabel.textColor = [UIColor colorWithRed:108/255.0 green:178/255.0 blue:237/255.0 alpha:1];
    
    [self configUI];
}

- (void)configUI {
    
    [self configLeftBarButton];
    
}
- (void)configLeftBarButton {
    [self navigationLeftBarButtonImageNames:@[@"返回"] click:^(NSInteger buttonTag) {
        NSLog(@"dahjkda");
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
}


//协议点击事件
-(void)protocolController{
    
//    LSRegistProtocolViewController *protcol = [[LSRegistProtocolViewController alloc]initWithNibName:@"LSRegistProtocolViewController" bundle:nil];
    
    LSRegistProtocolController *protcol = [[LSRegistProtocolController alloc] initWithNibName:@"LSRegistProtocolController" bundle:nil];
    [self presentViewController:protcol animated:YES completion:nil];
    
    

}

- (IBAction)agreeBtnAction:(UIButton *)sender {
    
    sender.selected  =! sender.selected;
    
}

//判断输入的数据是否正确
-(BOOL)isRightFormat{
    
        CGFloat keywordL = self.keyWord.text.length;
        CGFloat surekeywordL = self.sureKeyWord.text.length;
    
    if ([HRRegular checkTelephoneNumber:self.phoneNumber.text]) {
        if ([self.testCode.text isEqualToString:self.codeFromServer[@"code"]]) {
            if (keywordL >0 && surekeywordL >0) {
                if ([self.keyWord.text isEqualToString:self.sureKeyWord.text]) {
                    if (self.agreeBtn.selected) {
                        
                        return YES;
                        
                    }else{
                        [self promptBox_YTC_GeneralWithWords:@"请阅读并接受用户注册协议"];
                        return NO;
                    }
                }else{
                    [self promptBox_YTC_GeneralWithWords:@"两次密码不一致"];
                    return NO;
                }
            }else{
                [self promptBox_YTC_GeneralWithWords:@"请输入密码"];
                return NO;
            }
        }else{
            [self promptBox_YTC_GeneralWithWords:@"请输入正确的验证码"];
            return NO;
        }
    }else{
        [self promptBox_YTC_GeneralWithWords:@"请输入正确的手机号码"];
        return NO;
    }
    
 }

- (IBAction)registBtnAction:(UIButton *)sender {
    

    if ([self isRightFormat]) {
    
        [self.data setObject:self.phoneNumber.text forKey:@"mobile"];
        [self.data setObject:@"0" forKey:@"isVerify"];
        [self.data setObject:self.keyWord.text forKey:@"password"];
//
        LSRegistIdentifierViewController *registIdentifierVC = [[LSRegistIdentifierViewController alloc] initWithNibName:@"LSRegistIdentifierViewController" bundle:nil];
        
        registIdentifierVC.passW = self.keyWord.text;
        registIdentifierVC.account = self.phoneNumber.text;
        
        
        
        
//        //获取 数据模型添加字段
        LSRegistDataModel *totalData = [LSRegistDataModel shareSingleInstanceForRegist];
        NSString *filepath = [LSRegistDataModel filePathForRegist];
        
        totalData.mobile = self.phoneNumber.text;
        totalData.password = self.keyWord.text;
       
        [NSKeyedArchiver archiveRootObject:totalData toFile:filepath];
    
    [self promptBox_YTC_GeneralWithWords_epinasty:@"信息正确"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [self presentViewController:registIdentifierVC animated:YES completion:^{
        }];
        
    });
    
    
    }else{
//
    }

    
    //测试用语句 打开 则不用输入信息就可进入下一界面
//     [self presentViewController:[[LSRegistIdentifierViewController alloc]init] animated:YES completion:nil];
    
}


//发送验证码
- (IBAction)countDownBtn:(UIButton *)sender {
    
    //先判断手机号是否已经注册
    
    if (self.phoneNumber.text.length > 0 && [HRRegular checkTelephoneNumber:self.phoneNumber.text]) {
    
        NSDictionary *isRegistPara = [NSDictionary dictionaryWithObject:self.phoneNumber.text forKey:@"mobile"];
        
    [[HRRequestManager manager]POST_PATH:PATH_VerifyMobile para:isRegistPara success:^(id responseObject) {
        
        NSDictionary *dsDict = responseObject[@"ds"];
        
        NSString *isExist = dsDict[@"isExist"];
        //返回1已经注册 返回0 没有注册
        if ([isExist isEqualToString:@"1"]) {
            //已经注册
            [self promptBox_YTC_GeneralWithWords_epinasty:@"您的手机号已经注册,请直接登录!"];
            
        }else{
            //没有注册,发送网络请求
                [self requestGetCode];
                
                sender.userInteractionEnabled = NO;
                
                self.seconds = 60;
                
                self.clockTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(subOne) userInfo:nil repeats:YES];

        }
    } failure:^(NSError *error) {
        
        [self promptBox_YTC_GeneralWithWords:@"网络请求失败"];
        
    }];

    }else{
        [self promptBox_YTC_GeneralWithWords_epinasty:@"请输入正确的手机号码"];
    }


}
//读秒方法
-(void)subOne{
    
    self.seconds -- ;
    
    if (self.seconds > 0) {
        NSString *title = [NSString stringWithFormat:@"%zd秒后重新发送",self.seconds];
        self.countDownLabel.text = title;
    }else{
        self.countButton.userInteractionEnabled = YES;
        self.countDownLabel.text = @"发送验证码";
        [self.clockTimer invalidate];
        self.clockTimer = nil;
    }
}



#pragma mark - ||==========数据请求===========||
-(void)requestGetCode{
    
    if (self.phoneNumber.text.length > 0) {
        
        NSMutableDictionary *para = [NSMutableDictionary dictionary];
        [para setObject:self.phoneNumber.text forKey:@"mobile"];
        [para setObject:@"0" forKey:@"isVerify"];
        
        [[HRRequestManager manager] GET_PATH:PATH_GetCode para:para success:^(id responseObject) {
            
//            NSDictionary *getCode = [responseObject objectForKey:@"ds"];
            
            NSDictionary *totalDict = responseObject;
            
            NSString *success = [totalDict objectForKey:@"success"];
            
            if ([success isEqualToString:@"1"]) {
                NSLog(@"发送成功");
                
                //取出返回的验证码 和 手机号
                
                NSDictionary *codeDict = [totalDict objectForKey:@"ds"];
                
                self.codeFromServer = [NSMutableDictionary dictionaryWithDictionary:codeDict];
 
            }else{
            }
            
            
        } failure:^(NSError *error) {
            
            
        }];

    }else{
        
        [self promptBox_YTC_GeneralWithWords:@"输入11位手机号"];

    }

}






- (IBAction)LoginBtn:(id)sender {

 
    if (self.dismissNumber != 0) {
        
        self.dismissNumber = 0;
        
        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

- (IBAction)dismissBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
