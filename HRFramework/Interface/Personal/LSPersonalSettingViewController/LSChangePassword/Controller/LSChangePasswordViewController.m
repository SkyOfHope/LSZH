//
//  LSChangePasswordViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/19.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSChangePasswordViewController.h"

@interface LSChangePasswordViewController ()

@property (strong, nonatomic) IBOutlet UITextField *oldPwdTextField;

@property (strong, nonatomic) IBOutlet UITextField *passWord;

@property (weak, nonatomic) IBOutlet UITextField *passWordTwo;


@end

@implementation LSChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"修改密码";
    
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


#pragma mark - ||========== IBActions ===========||
- (IBAction)sureChangeBtn:(UIButton *)sender {
    
    [self requestUpdatePwd];
    
}

#pragma mark - ||==========数据请求===========||
-(void)requestUpdatePwd{
    
    //对比两次输入的密码是否一致
    
    if ([self.passWord.text isEqualToString:self.passWordTwo.text]) {
        //如果一致取出用户ID 并修改密码 修改完成 弹窗提示
        
        //取出用户ID
        
        NSUserDefaults *userDeful = [NSUserDefaults standardUserDefaults];
        NSString *userId = [userDeful objectForKey:@"userId"];
        
        NSMutableDictionary *para = [NSMutableDictionary dictionary];

        [para setObject:userId forKey:@"userId"];

        [para setObject:self.oldPwdTextField.text forKey:@"oldPwd"];
        [para setObject:self.passWord.text forKey:@"newPwd"];
        
        [[HRRequestManager manager] POST_PATH:PATH_UpdatePwd para:para success:^(id responseObject) {
            
            
            NSDictionary *dcit = responseObject;

            NSLog(@"%@",dcit[@"success"]);
            NSString *errMsg = dcit[@"errMsg"];

            if ([errMsg isEqualToString:@"修改成功"]) {
                
                [self promptBox_YTC_GeneralWithWords:responseObject[@"errMsg"]];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                });
                
                
                
            }else{
                [self promptBox_YTC_GeneralWithWords_epinasty:@"修改失败"];
            }
   
        } failure:^(NSError *error) {
            
            
        }];
        
    }else{
        
        //有弹窗
        
        [self promptBox_YTC_GeneralWithWords_epinasty:@"两次密码不一致"];
        
    }
    
    
    
    
    
        
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
