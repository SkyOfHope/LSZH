
//
//  LSRegistPersonalViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/26.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSRegistPersonalViewController.h"

#import "LSRegistDataModel.h"

#import "LSLoginViewController.h"


@interface LSRegistPersonalViewController ()

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *nicknameTextField;

@property (strong, nonatomic) UIButton *selectBtn;

@property (strong, nonatomic) MBProgressHUD *hud;

@property (copy, nonatomic) NSString *userType;


@end

@implementation LSRegistPersonalViewController

- (IBAction)backBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    NSLog(@"%@",self.getData)
    
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


- (IBAction)chooseSexBtnAction:(UIButton *)sender {
    
    self.selectBtn.selected = NO;
    self.selectBtn = sender;
    sender.selected = YES;
    
//    NSLog(@"%@",self.selectBtn.titleLabel.text);
}



- (IBAction)completeBtnAction:(UIButton *)sender {
    
    if (self.nameTextField.text.length > 0 && self.nicknameTextField.text.length > 0 && self.selectBtn.titleLabel.text.length > 0) {
        
        [self requestRegister];

    }else{
        [self promptBox_YTC_GeneralWithWords_epinasty:@"请输入所有信息"];
    }
    
    
}


#pragma mark - ||==========数据请求===========||
-(void)requestRegister{
    
    NSMutableDictionary *para = [self PostPara];
        
    [para setObject:self.nameTextField.text forKey:@"realname"];
    [para setObject:self.nicknameTextField.text forKey:@"nickname"];
    [para setObject:self.selectBtn.titleLabel.text forKey:@"sex"];

    [[HRRequestManager manager] POST_PATH:PATH_Register para:para success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSDictionary *totalDict = responseObject;
        
        NSString *iSsuccess = totalDict[@"success"];
        
        if ([iSsuccess isEqualToString:@"1"]) {
            
//            self.hud = [[MBProgressHUD alloc]initWithWindow:[UIApplication sharedApplication].keyWindow];
//            [self.hud show:YES];
//            [self.view addSubview:self.hud];
//            
//            self.hud.mode = MBProgressHUDModeText;
//            self.hud.labelText = @"注册成功,即将自动登录";
            
            [self requestLogin];
            
        }else{
            [self promptBox_YTC_GeneralWithWords:@"注册失败,请检查您的数据"];
        }
        
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"网络连接不畅");
        
    }];
    
}

-(NSMutableDictionary*)PostPara{
    
//    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
//    NSString *mobile = [userdefault objectForKey:@"mobile"];
//    NSString *password = [userdefault objectForKey:@"password"];
//    NSString *userTypeId = [userdefault objectForKey:@"userTypeId"];

    NSString *path = [LSRegistDataModel filePathForRegist];
    
    LSRegistDataModel *dataModel = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    
    
    NSMutableDictionary *paraDict = [NSMutableDictionary dictionary];
    [paraDict setObject:dataModel.mobile forKey:@"mobile"];
    [paraDict setObject:dataModel.password forKey:@"password"];
    [paraDict setObject:dataModel.userTypeId forKey:@"userTypeId"];
    
    
    return paraDict;
    
}


//判断成功后加入参数进行数据请求
-(void)requestLogin{

        NSMutableDictionary *para = [NSMutableDictionary dictionary];
        [para setValue:self.accountNum forKey:@"mobile"];
        [para setValue:self.passWord forKey:@"password"];
        
        [[HRRequestManager manager] POST_PATH:PATH_Login para:para success:^(id responseObject) {
            //成功 先判断请求是否成功 如果失败 返回 如果成功 保存用户信息到偏好设置
            
            NSDictionary *LoginDict = responseObject;
            NSString *FaultOrSuccess = LoginDict[@"success"];
            
            if ([FaultOrSuccess  isEqual: @"0"]) {
                    
//                    self.hud.labelText = @"用户暂未通过管理员审核";
//                    [self.hud hide:YES afterDelay:2];
                
            }else if ([FaultOrSuccess isEqualToString:@"1"]){
                
                //根据记住密码是否被选中决定是否保存密码 以及 下一次是否直接登录主页
                
                NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
                
                BOOL isSave = [userdefault boolForKey:@"savePassword"];
                //如果记住密码为yes保存密码，否则只保存用户Id以及记住密码状态 以及账号
                if (isSave == YES) {
                    //创建用户偏好设置 存储 密码 以及用户ID
                    [userdefault setObject:self.passWord forKey:@"password"];
                }
                
                [userdefault setObject:self.accountNum forKey:@"mobile"];
                
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
//                [self.delegate LoadPersonalControllerAfterLogin];
                
                //            [self dismissViewControllerAnimated:YES completion:nil];
                
                self.hud = nil;
                
                [self.presentingViewController.presentingViewController.presentingViewController.presentingViewController dismissViewControllerAnimated:NO completion:^{
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
        }];
    
}

//查询用户类型
-(void)GetUsertype{
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    
    NSString *userId = [userdefault objectForKey:@"userId"];
    
    
    NSDictionary *para = [NSDictionary dictionaryWithObject:userId forKey:@"userId"];
    
    [[HRRequestManager manager]POST_PATH:PATH_GetUserType para:para success:^(id responseObject) {
        
        NSDictionary *ds = responseObject[@"ds"];
        
        self.userType = ds[@"userTypeId"];
        
        [userdefault setObject:self.userType forKey:@"userTypeId"];
        
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
