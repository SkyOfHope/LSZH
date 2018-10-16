
//
//  LSMyInformationChangeViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/20.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSMyInformationChangeViewController.h"

@interface LSMyInformationChangeViewController ()


@property (weak, nonatomic) IBOutlet UITextField *detailLabel;


@property (weak, nonatomic) IBOutlet UIButton *changeInformation;


@property (weak, nonatomic) IBOutlet UILabel *warningLabel;

@end

@implementation LSMyInformationChangeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //判断修改的项目决定是否隐藏警告
    
    [self.warningLabel setHidden:YES];
    
    if (self.hiddenWaringLabel != 0) {
        
        [self.warningLabel setHidden:NO];
        
    }

    self.detailLabel.text = self.detailtext;
    
    self.changeInformation.layer.cornerRadius = 20;
    self.changeInformation.layer.masksToBounds = YES;
    
    [self.changeInformation addTarget:self action:@selector(changeInformationAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
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


-(void)changeInformationAction{
    
    //获取参数
    
    
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    
    //创建参数字典
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithObject:userId forKey:@"userId"];
    
    //其他参数
    
    if (self.detailLabel.text.length > 0) {
        
        switch (self.changeId) {
            case 11:
                [para setObject:self.detailLabel.text forKey:@"organizationName"];
                break;
            case 12:
                [para setObject:self.detailLabel.text forKey:@"licenseCode"];
                break;
            case 13:
                [para setObject:self.detailLabel.text forKey:@"principalName"];
                break;
            case 21:
                
                //还有问题 参数如何区分
                [para setObject:self.detailLabel.text forKey:@"province"];
                
                break;
            case 22:
                [para setObject:self.detailLabel.text forKey:@"email"];
                break;
            case 31:
                [para setObject:self.detailLabel.text forKey:@"remark"];
                break;
                //以下是个人情况下资料修改
            case 41:
                [para setObject:self.detailLabel.text forKey:@"realName"];
                break;
            case 42:
                [para setObject:self.detailLabel.text forKey:@"sex"];
                break;
            case 43:
                [para setObject:self.detailLabel.text forKey:@"nickname"];
                break;
            default:
                break;
        }

        //网络修改数据
        [[HRRequestManager manager]POST_PATH:PATH_UpdateUser para:para success:^(id responseObject) {
            
            if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
                
                NSLog(@"修改成功");

                //如果修改成功,则自动跳转到首页,并且是不登陆状态
                //如果是以下项目修改会有提示不可登录
                if (self.changeId == 11 || self.changeId == 12) {
                    
                    [self promptBox_YTC_GeneralWithWords_epinasty:@"修改成功"];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                        
                        [userDefault setObject:nil forKey:@"userId"];
                        
                        [self.navigationController popToRootViewControllerAnimated:YES];
                        
                        
                        UINavigationController *navi = (UINavigationController *)[[UIApplication sharedApplication].delegate window].rootViewController;
                        
                        UITabBarController *tabBarVC = [navi.viewControllers firstObject];
                        tabBarVC.selectedIndex = 0;
                        
                        
//                        [self dismissViewControllerAnimated:YES completion:nil];
    
                    });
                    
                }else{
                    
                    //提示成功
                    [self promptBox_YTC_GeneralWithWords_epinasty:@"修改成功"];
                    //可以登录,返回刷新即可
                    [self.delegate reloadNewinformation];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
  
            }else{
                [self promptBox_YTC_GeneralWithWords_epinasty:@"修改失败"];
            }
 
        } failure:^(NSError *error) {
            
        }];
        
    }else{
        [self tipLabelAnimationWith:@"请填入数据"];
    }
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
