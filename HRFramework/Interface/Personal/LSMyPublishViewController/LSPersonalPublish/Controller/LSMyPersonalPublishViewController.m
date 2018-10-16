//
//  LSMyPersonalPublishViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/19.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSMyPersonalPublishViewController.h"

#import "LSPersonalPublishRentOutViewController.h"
#import "LSPersonalPublishFinanceViewController.h"
#import "LSPersonalFinaceNeedsViewController.h"
#import "LSPersonalPublishToRentViewController.h"

@interface LSMyPersonalPublishViewController ()

@property (strong, nonatomic) UIButton *selectBtn;

@end

@implementation LSMyPersonalPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的发布";
    
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

- (IBAction)publishInformation:(UIButton *)sender {
   
    self.selectBtn.selected = NO;
    self.selectBtn = sender;
    sender.selected = YES;
    
    //提前取出userTypeId 用来判断可以进入的模块
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    
    NSInteger userTypeId = [[userdefault objectForKey:@"userTypeId"] integerValue];
 

    switch (sender.tag) {
        case 1:{
            NSLog(@"发布的融资需求信息");
            
            if (userTypeId == 2 || userTypeId == 4 || userTypeId == 1) {
            
                LSPersonalFinaceNeedsViewController *finaceNeedsVC = [[LSPersonalFinaceNeedsViewController alloc] initWithNibName:@"LSPersonalFinaceNeedsViewController" bundle:nil];
                
                [self.navigationController pushViewController:finaceNeedsVC animated:YES];
            }else{
                [self tipLabelAnimationWith:@"您没有发布相关信息"];
            }

            break;
        }
        case 2:{
            NSLog(@"发布的金融产品信息");
            
            if (userTypeId == 3) {
            
                LSPersonalPublishFinanceViewController *publishFinanceVC = [[LSPersonalPublishFinanceViewController alloc] initWithNibName:@"LSPersonalPublishFinanceViewController" bundle:nil];
                
                [self.navigationController pushViewController:publishFinanceVC animated:YES];
            }else{
                [self tipLabelAnimationWith:@"您没有发布相关信息"];
            }
            
            break;
        }
        case 3:{
            NSLog(@"发布的办公出租信息");
            
            if (userTypeId == 1 || userTypeId == 2 ) {
                LSPersonalPublishRentOutViewController *rentOutVC = [[LSPersonalPublishRentOutViewController alloc] initWithNibName:@"LSPersonalPublishRentOutViewController" bundle:nil];
                
                [self.navigationController pushViewController:rentOutVC animated:nil];
                
            }else{
                [self tipLabelAnimationWith:@"您没有发布相关信息"];
            }
            
            break;
        }
        case 4:{
            NSLog(@"发布的办公求租信息");
            
            if (userTypeId == 2 ||  userTypeId == 4) {
            
                LSPersonalPublishToRentViewController *publishToRentVC = [[LSPersonalPublishToRentViewController alloc] initWithNibName:@"LSPersonalPublishToRentViewController" bundle:nil];
                
                [self.navigationController pushViewController:publishToRentVC animated:YES];
            }else{
                [self tipLabelAnimationWith:@"您没有发布相关信息"];
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
