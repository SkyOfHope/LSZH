
//
//  LSFindPassWordViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/26.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSFindPassWordViewController.h"

#import "LSRegistViewController.h"

#import "LSRegistDataModel.h"

#import "HRRegular.h"

@interface LSFindPassWordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *testCode;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UITextField *surePassword;



- (IBAction)sendTestCode:(UIButton *)sender;

- (IBAction)sureFix:(UIButton *)sender;


- (IBAction)registerBtn:(id)sender;


- (IBAction)getBack:(id)sender;



//倒计时相关 : 五个属性

@property (weak, nonatomic) IBOutlet UIButton *countDownBtn;

@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;

@property (assign, nonatomic) NSInteger seconds;

@property (strong, nonatomic) NSTimer *clockTimer;


@end

@implementation LSFindPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//发送验证码
- (IBAction)sendTestCode:(UIButton *)sender {
    
    if (self.phoneNumber.text.length > 0 && [HRRegular checkTelephoneNumber:self.phoneNumber.text]) {
        
        NSMutableDictionary *para = [NSMutableDictionary dictionary];
        
        [para setObject:@"1" forKey:@"isVerify"];
        [para setObject:self.phoneNumber.text forKey:@"mobile"];
        
        //准备开始读秒
        
        sender.userInteractionEnabled = NO;
        
        self.seconds = 60;
        
        self.clockTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(subOne) userInfo:nil repeats:YES];

        [[HRRequestManager manager]POST_PATH:PATH_GetCode para:para success:^(id responseObject) {
            
            NSLog(@"%@",responseObject);
            
            //先进行取值
            NSDictionary *totalDict = responseObject;
            
            //对值进行判断 如果失败 提示
            //如果成功 存储验证码 以及注册手机 提示成功
            
            if ([totalDict[@"success"] isEqualToString:@"1"]) {
                
                NSString *filePath = [LSRegistDataModel filePathForRegist];
                LSRegistDataModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
                
                NSDictionary *dsDict = totalDict[@"ds"];
                
                model.testCode = dsDict[@"code"];
                model.codeMobile = dsDict[@"mobile"];
                
                [NSKeyedArchiver archiveRootObject:model toFile:filePath];
            
            }else{
                [self promptBox_YTC_GeneralWithWords_epinasty:@"该手机号未注册"];
            }
        } failure:^(NSError *error) {

            [self promptBox_YTC_GeneralWithWords_epinasty:@"发送失败"];
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
        self.countDownBtn.userInteractionEnabled = YES;
        self.countDownLabel.text = @"发送验证码";
        [self.clockTimer invalidate];
        self.clockTimer = nil;
    }
}




- (IBAction)sureFix:(UIButton *)sender {
    
    //先检查是否都有值
    //在检查 手机号码是否相同   验证码相同
    
    //忘记密码
    
    if (self.phoneNumber.text.length > 0) {
        if (self.testCode.text.length > 0) {
            if (self.password.text.length > 0 && self.surePassword.text.length > 0) {
                if ([self.password.text isEqualToString:self.surePassword.text]) {
                    
                    //判断过后进行网络请求
                    NSMutableDictionary *para = [NSMutableDictionary dictionary];
                    [para setObject:self.phoneNumber.text forKey:@"mobile"];
                    [para setObject:self.password.text forKey:@"newPwd"];
                    
                    [[HRRequestManager manager]POST_PATH:PATH_UpdatePwd2 para:para success:^(id responseObject) {
                        
                        //请求成功
                        
                        NSLog(@"%@",responseObject);
                        
                        //取参
                        
                        NSDictionary *totalDict = responseObject;
                        
                        NSString *isSuccess = [totalDict objectForKey:@"success"];
                        
                        if ([isSuccess isEqualToString:@"1"]) {
                            //成功
                            //先提示 跳转登陆页
                            [self dismissViewControllerAnimated:YES completion:nil];
                        }else{
                            //            [self promptBox_YTC_GeneralWithWords_epinasty:@"验证失败"];
                        }
                        
                    } failure:^(NSError *error) {
                        
                    }];
                    
                    
                    
                }else{
                    [self promptBox_YTC_GeneralWithWords_epinasty:@"两次密码不一致"];
                }
            }else{
                [self promptBox_YTC_GeneralWithWords_epinasty:@"请确认密码"];
            }
        }else{
            [self promptBox_YTC_GeneralWithWords_epinasty:@"请输入正确的验证码"];
        }
    }else{
        [self promptBox_YTC_GeneralWithWords_epinasty:@"请输入手机号码"];
    }
 
}

- (IBAction)registerBtn:(id)sender {
    
    LSRegistViewController *registerVC = [[LSRegistViewController alloc]initWithNibName:@"LSRegistViewController" bundle:nil];
    
    registerVC.dismissNumber = 2;
    
    [self presentViewController:registerVC animated:YES completion:nil];
    
    
}




- (IBAction)getBack:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


////提示框
//
//-(void)tipLabelAnimationWith:(NSString*)tip{
//    
//    UILabel *promptLabel = [[UILabel alloc]init];
//    
//    CGFloat width = SCREEN_WIDTH / 2 * 1.4;
//    CGFloat height = width * 0.2;
//    
//    promptLabel.alpha = 0;
//    
//    promptLabel.frame = CGRectMake(SCREEN_WIDTH / 2 - width/2 , SCREEN_WIDTH / 2 * 1.4 + 200, width, height);
//    promptLabel.backgroundColor = [UIColor blackColor];
//    promptLabel.textColor = [UIColor whiteColor];
//    promptLabel.layer.cornerRadius = height / 2;
//    promptLabel.layer.masksToBounds = YES;
//    
//    promptLabel.textAlignment = 1;
//    
//    promptLabel.layer.cornerRadius = 25;
//    promptLabel.layer.masksToBounds = YES;
//    
//    promptLabel.text = tip;
//    
//    [self.view addSubview:promptLabel];
//    
//    [UIView animateWithDuration:1.5 animations:^{
//        promptLabel.alpha = 0.8;
//    } completion:^(BOOL finished) {
//        
//        [UIView animateWithDuration:1 animations:^{
//            promptLabel.alpha = 0;
//        } completion:nil];
//        
//    }];
//    
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)countDownStart:(UIButton *)sender {
}
@end
