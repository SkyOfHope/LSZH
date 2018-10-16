//
//  LSReleaseViewController.m
//  LSZH
//
//  Created by 穆英波 on 16/5/18.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSReleaseViewController.h"

#import "LSPublishRentOutViewController.h"
#import "LSPublishOfficeToRentViewController.h"
#import "LSPublishFinanceproductViewController.h"
#import "LSPublishFinanceNeedsViewController.h"
#import "LSLoginViewController.h"

@interface LSReleaseViewController ()

@property (strong, nonatomic) UIButton *selectBtn;

@end

@implementation LSReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.title = @"";
    
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

- (void)viewWillAppear:(BOOL)animated {
    
    [self configNavigationTitle];
    
    //添加判断是否登录
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    
    NSString *userId = [userdefault objectForKey:@"userId"];
    
    if (userId == nil) {
        
        LSLoginViewController *loginVC = [[LSLoginViewController alloc]initWithNibName:@"LSLoginViewController" bundle:nil];
        [self presentViewController:loginVC animated:YES completion:nil];
    }

}


- (IBAction)publishInformation:(UIButton *)sender {
    
//    LSPublishOfficeToRentViewController *publishToRentVC = [[LSPublishOfficeToRentViewController alloc] initWithNibName:@"LSPublishOfficeToRentViewController" bundle:nil];
//    
//    [self.navigationController pushViewController:publishToRentVC animated:YES];
//    return;
    
    //获取用户Id进行判断是否进入页面  权限限制
    LSLoginViewController *LoginVC = [[LSLoginViewController alloc]initWithNibName:@"LSLoginViewController" bundle:nil];
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    
    NSString *userId = [userdefault objectForKey:@"userId"];
    
    NSInteger userTypeId = [[userdefault objectForKey:@"userTypeId"] integerValue];
    
    self.selectBtn.selected = NO;
    self.selectBtn = sender;
    sender.selected = YES;
    
    switch (sender.tag) {
        case 1:{
            NSLog(@"发布的融资需求信息");
            
            if (userId == nil) {
                [self presentViewController:LoginVC animated:YES completion:nil];
                
            }else{
                
                if (userTypeId == 2 || userTypeId == 4 || userTypeId == 1) {
            
                    LSPublishFinanceNeedsViewController *finaceNeedsVC = [[LSPublishFinanceNeedsViewController alloc] initWithNibName:@"LSPublishFinanceNeedsViewController" bundle:nil];
                    
                    [self.navigationController pushViewController:finaceNeedsVC animated:YES];
                }else{
                    [self tipLabelAnimationWith:@"您没有这个权限"];
                }
            
            }
  
            break;
        }
        case 2:{
            NSLog(@"发布的金融产品信息");
            
            if (userId == nil) {
                [self presentViewController:LoginVC animated:YES completion:nil];
                
            }else{
                
                if (userTypeId == 3) {
                    LSPublishFinanceproductViewController *publishFinanceVC = [[LSPublishFinanceproductViewController alloc] initWithNibName:@"LSPublishFinanceproductViewController" bundle:nil];
                    
                    [self.navigationController pushViewController:publishFinanceVC animated:YES];
//                    
                }else{
                    [self tipLabelAnimationWith:@"您没有这个权限"];
                }
  
            }
 
            break;
        }
        case 3:{
            NSLog(@"发布的办公出租信息");
            
            if (userId == nil) {
                [self presentViewController:LoginVC animated:YES completion:nil];
                
            }else{
                
                if (userTypeId == 1 || userTypeId == 2) {
                    LSPublishRentOutViewController *rentOutVC = [[LSPublishRentOutViewController alloc] initWithNibName:@"LSPublishRentOutViewController" bundle:nil];
                    
                    [self.navigationController pushViewController:rentOutVC animated:nil];
                    
                }else{
                    [self tipLabelAnimationWith:@"您没有这个权限"];
                }

            }
            break;
        }
        case 4:{
            NSLog(@"发布的办公求租信息");
            
            if (userId == nil) {
                
                [self presentViewController:LoginVC animated:YES completion:nil];
                
            }else{
                
                if (userTypeId == 2 || userTypeId == 4) {
            
                    LSPublishOfficeToRentViewController *publishToRentVC = [[LSPublishOfficeToRentViewController alloc] initWithNibName:@"LSPublishOfficeToRentViewController" bundle:nil];
                    
                    [self.navigationController pushViewController:publishToRentVC animated:YES];
                }else{
                    [self tipLabelAnimationWith:@"您没有这个权限"];
                }
            
            }
            break;
        }
            
            
        default:
            break;
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


#pragma mark - ---------- Private Methods ----------

- (void)configNavigationTitle {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    titleLabel.text = @"我要发布";
    titleLabel.textColor = RGB_0X(0x333333);
    titleLabel.font = [UIFont systemFontOfSize:17];
    self.tabBarController.navigationItem.titleView = titleLabel;
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
