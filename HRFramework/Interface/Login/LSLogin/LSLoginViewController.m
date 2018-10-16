//
//  LSLoginViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/26.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSLoginViewController.h"

#import "LSFindPassWordViewController.h"
#import "LSRegistIdentifierViewController.h"
#import "LSRegistViewController.h"

#import "HRRegular.h"

#import "LSRegistPersonalViewController.h"
#import "LSHomeViewController.h"


@interface LSLoginViewController ()
@property (strong, nonatomic) IBOutlet UIView *findPassWordBtn;

@property (strong, nonatomic) IBOutlet UITextField *putInMobile;
@property (strong, nonatomic) IBOutlet UITextField *putInKeyWords;

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;



@property (weak, nonatomic) IBOutlet UIButton *savePsw;


@property (weak, nonatomic) IBOutlet UIImageView *headImg;

@property (weak, nonatomic) IBOutlet UIButton *headImgBtn;

@property (strong,nonatomic) NSString *phoneNum;


//保存请求到的 用户类型
@property (copy, nonatomic) NSString *userTypeId;


- (IBAction)savePsw:(UIButton *)sender;
@property (assign, nonatomic) BOOL selectedBtn;


@property (weak, nonatomic) IBOutlet UIView *BigLoginView;

//登录页返回按钮
- (IBAction)dismissBtn:(UIButton *)sender;

@end

@implementation LSLoginViewController


-(void)setDict:(NSMutableDictionary *)dict{
    
    _dict = dict;
    
    self.phoneNum = self.dict[@"Account"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"账号注册";

    //登录view相关设置
    
    UIColor *backColor = [UIColor colorWithRed:83/255.0 green:140/255.0 blue:175/255.0 alpha:1];
    //设置输入框风格
    self.BigLoginView.backgroundColor = backColor;
    self.BigLoginView.layer.cornerRadius = 12;
    self.BigLoginView.layer.masksToBounds = YES;
    
    self.putInMobile.backgroundColor = backColor;
    self.putInMobile.borderStyle = UITextBorderStyleNone;
    self.putInMobile.autocorrectionType = UITextAutocorrectionTypeNo;

    [self.putInMobile setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    self.putInKeyWords.borderStyle = UITextBorderStyleNone;
    self.putInKeyWords.backgroundColor = backColor;
    self.putInKeyWords.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [self.putInKeyWords setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
//    if (self.phoneNum.length > 0) {
////    if (self.registtype == registType_presonal) {
//        
//        int i = 1;
//        
//        if (i == 1) {
//            UIWindow *window = [[UIApplication sharedApplication].delegate window];
//            UINavigationController *navi = (UINavigationController *)window.rootViewController;
//            [navi popToRootViewControllerAnimated:NO];
//            UITabBarController *tabBar = navi.viewControllers[0];
//            [tabBar setSelectedIndex:0];
//        }else{
//            
//            self.putInMobile.text = self.dict[@"Account"];
//            self.putInKeyWords.text = self.dict[@"Pass"];
//            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self loginBtnAction:nil];
//            });
//
//        }
//        
//        
//    }else{
    
        //取出用户设置
        NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
        //根据是否保存密码 决定 是否填充 账号密码栏 确定的情况下 填充 账号密码
        BOOL isSave = [userdefault boolForKey:@"savePassword"];
        
        if (isSave == YES) {
            self.selectedBtn = YES;
            [self.savePsw setImage:[UIImage imageNamed:@"记住密码"] forState:UIControlStateNormal];
            
            //如果记住密码 取出本地账号密码 头像 填充 label 图片
            NSString *Phone = [userdefault objectForKey:@"mobile"];
            NSString *secret = [userdefault objectForKey:@"password"];
            //填充
            self.putInMobile.text = Phone;
            self.putInKeyWords.text = secret;
            //用户头像
            
            NSString *headUrl = [[NSUserDefaults standardUserDefaults]objectForKey:@"headImg"];
            
            if (![headUrl isEqualToString:@"http://www.wcsyq.gov.cn"]) {
                
                UIImageView *placeImg = [[UIImageView alloc]init];
                
                [placeImg sd_setImageWithURL:[NSURL URLWithString:headUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    
                    UIImage *headImg = placeImg.image;
                    
                    [self.headImgBtn setBackgroundImage:headImg forState:UIControlStateNormal];
                    
                    self.headImgBtn.layer.cornerRadius = self.headImgBtn.frame.size.width / 2;
                    self.headImgBtn.layer.masksToBounds = YES;
                }];
                
            }

        }else{
            self.selectedBtn = NO;
            [self.savePsw setImage:[UIImage imageNamed:@"未记住密码"] forState:UIControlStateNormal];
            
            //        [self.headImgBtn setBackgroundImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
            
        }
        
//    }
    
    
    

    [self configUI];
    self.putInMobile.keyboardType = UIKeyboardTypeNumberPad;
    
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


#pragma mark - ||========== IBActions ===========||

-(void)skipHome:(NSNotification *)notification{
    
    self.putInMobile.text = notification.userInfo[@"Pass"];
    [self requestLogin];
    self.putInKeyWords.text = notification.userInfo[@"Account"];
    
    
    self.phoneNum = notification.userInfo[@"Account"];
    
}

- (IBAction)loginBtnAction:(UIButton *)sender{
    
    [self requestLogin];
    
}


- (IBAction)passWordBtnAction:(UIButton *)sender {
    
    LSFindPassWordViewController *findPassWorVC = [[LSFindPassWordViewController alloc] initWithNibName:@"LSFindPassWordViewController" bundle:nil];
    
    [self presentViewController:findPassWorVC animated:YES completion:nil];
    
}

- (IBAction)registBtnClick:(UIButton *)sender {	
    
    LSRegistViewController *regist = [[LSRegistViewController alloc] initWithNibName:@"LSRegistViewController" bundle:nil];
    
    
    [self presentViewController:regist animated:YES completion:nil];
}

#pragma mark - ||==========数据请求===========||

//判断输入是否正确
-(BOOL)IsPutinRight{
    
    
    if (self.putInMobile.text.length > 0 && self.putInKeyWords.text.length > 0) {
    
        if ([HRRegular checkTelephoneNumber:self.putInMobile.text]) {
            
            return YES;
            
        }else{
            [self tipLabelAnimationWith:@"密码或账户名错误"];
            return NO;
        }
        
    }else{
            [self tipLabelAnimationWith:@"请重新输入"];
        return NO;
    }
}

//判断成功后加入参数进行数据请求
-(void)requestLogin{
    
    if ([self IsPutinRight]) {
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setValue:self.putInMobile.text forKey:@"mobile"];
    [para setValue:self.putInKeyWords.text forKey:@"password"];
    
    [[HRRequestManager manager] POST_PATH:PATH_Login para:para success:^(id responseObject) {
        //成功 先判断请求是否成功 如果失败 返回 如果成功 保存用户信息到偏好设置
        
        NSDictionary *LoginDict = responseObject;
        NSString *FaultOrSuccess = LoginDict[@"success"];
        
        if ([FaultOrSuccess  isEqual: @"0"]) {
            //根据请求的数据 获得 输入不正确
            //判断是未通过审核还是账号密码错误
            NSString *errMsg = responseObject[@"errMsg"];
            if ([errMsg isEqualToString:@"用户暂未通过管理员审核"]) {
                
                [self tipLabelAnimationWith:@"用户暂未通过管理员审核"];
                
            }else{
                
                [self tipLabelAnimationWith:@"密码或账户名错误"];
            }
            
        }else if ([FaultOrSuccess isEqualToString:@"1"]){
            
            //根据记住密码是否被选中决定是否保存密码 以及 下一次是否直接登录主页
            
            NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
            
            BOOL isSave = [userdefault boolForKey:@"savePassword"];
            //如果记住密码为yes保存密码，否则只保存用户Id以及记住密码状态 以及账号
            if (isSave == YES) {
                //创建用户偏好设置 存储 密码 以及用户ID
                [userdefault setObject:self.putInKeyWords.text forKey:@"password"];
            }
            
            [userdefault setObject:self.putInMobile.text forKey:@"mobile"];
            
            NSDictionary *Login_ds = LoginDict[@"ds"];
            NSString *userId = Login_ds[@"userId"];
            [userdefault setObject:userId forKey:@"userId"];
            //立刻存储
            [userdefault synchronize];
            
            //获取用户类型ID
            [self GetUsertype];
            //获取用户信息(主要是用户头像)
            [self GetInfoOfUser];
            
            //加载
            [self.delegate LoadPersonalControllerAfterLogin];
            
//            [self dismissViewControllerAnimated:YES completion:nil];
            
            
            [self dismissViewControllerAnimated:NO completion:^{
                UIWindow *window = [[UIApplication sharedApplication].delegate window];
                UINavigationController *navi = (UINavigationController *)window.rootViewController;
                [navi popToRootViewControllerAnimated:NO];
                UITabBarController *tabBar = navi.viewControllers[0];
                [tabBar setSelectedIndex:0];
            }];
            
//
            //必须要保存的数据 : 是否记住密码savePassword 用户IDuserId 账号mobile
        }
        
    } failure:^(NSError *error) {
        
        //失败 弹窗提示.
        
        [self tipLabelAnimationWith:@"网络请求失败"];
    }];
    }else{
        return;
    }

}

//查询用户类型
-(void)GetUsertype{
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    
    NSString *userId = [userdefault objectForKey:@"userId"];
    
    
    NSDictionary *para = [NSDictionary dictionaryWithObject:userId forKey:@"userId"];
    
    [[HRRequestManager manager]POST_PATH:PATH_GetUserType para:para success:^(id responseObject) {
        
        NSDictionary *ds = responseObject[@"ds"];
        
        self.userTypeId = ds[@"userTypeId"];
        
        [userdefault setObject:self.userTypeId forKey:@"userTypeId"];
        
    } failure:^(NSError *error) {
//        [self tipLabelAnimationWith:@"输入的信息有误，请重新输入"];
        return ;
    }];
    
}

//查询用户头像
-(void)GetInfoOfUser{
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];

    NSString *userId = [userdefault objectForKey:@"userId"];

    NSDictionary *dict = [NSDictionary dictionaryWithObject:userId forKey:@"userId"];

    [[HRRequestManager manager]POST_PATH:PATH_GetUserInfo para:dict success:^(id responseObject) {
       
        NSDictionary *dsDict = responseObject[@"ds"];
        
        NSString *headImageUrl = dsDict[@"headImg"];
        
        [[NSUserDefaults standardUserDefaults]setObject:headImageUrl forKey:@"headImg"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } failure:^(NSError *error) {
        
    }];
    
}

//提示框
-(void)tipLabelAnimationWith:(NSString*)tip{
    
    self.tipLabel.layer.cornerRadius = 25;
    self.tipLabel.layer.masksToBounds = YES;
    
    self.tipLabel.text = tip;
    
    [UIView animateWithDuration:1.5 animations:^{
        self.tipLabel.alpha = 0.8;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1 animations:^{
            self.tipLabel.alpha = 0;
        } completion:nil];
        
    }];
}

//记住密码按钮
- (IBAction)savePsw:(UIButton *)sender {
    
    NSUserDefaults *userdefaule = [NSUserDefaults standardUserDefaults];

    self.selectedBtn = !self.selectedBtn;
    
    if (self.selectedBtn == NO) {
       
        [sender setImage:[UIImage imageNamed:@"未记住密码"] forState:UIControlStateNormal];
        [userdefaule setBool:NO forKey:@"savePassword"];
        [userdefaule synchronize];
 
    }else{
        [sender setImage:[UIImage imageNamed:@"记住密码"] forState:UIControlStateNormal];
        [userdefaule setBool:YES forKey:@"savePassword"];
        [userdefaule synchronize];
        

        
    }

}

//登录页退出按钮
- (IBAction)dismissBtn:(UIButton *)sender {
    
    UINavigationController *navi = (UINavigationController *)[[UIApplication sharedApplication].delegate window].rootViewController;
    
    UITabBarController *tabBarVC = [navi.viewControllers firstObject];
    tabBarVC.selectedIndex = 0;
    
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
