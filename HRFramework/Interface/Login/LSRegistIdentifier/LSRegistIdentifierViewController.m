//
//  LSRegistIdentifierViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/26.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSRegistIdentifierViewController.h"

#import "LSRegistPersonalViewController.h"
#import "LSRegistFinanceOrgnizationViewController.h"
#import "LSRegistCompanyViewController.h"
#import "LSRegistGardenViewController.h"



#import "LSRegistDataModel.h"


@interface LSRegistIdentifierViewController ()

@property (strong, nonatomic) UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UIButton *nextBt;

- (IBAction)nextVC:(UIButton *)sender;

@property (strong, nonatomic) NSString * number;

@property (strong, nonatomic) LSRegistDataModel *dataModel;

@property (strong, nonatomic) NSString *filePath;

@end

@implementation LSRegistIdentifierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.filePath = [LSRegistDataModel filePathForRegist];
    self.dataModel = [NSKeyedUnarchiver unarchiveObjectWithFile:self.filePath];
    
    [self configLeftBarButton];
}

- (void)configLeftBarButton {
    [self navigationLeftBarButtonImageNames:@[@"返回"] click:^(NSInteger buttonTag) {
        NSLog(@"dahjkda");
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
}



- (IBAction)backBtn:(id)sender {
    
    //将用户的 信息保存
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - ||========== IBActions ===========||
- (IBAction)ButtonAction:(UIButton *)sender {
    
    self.selectBtn.selected = NO;
    self.selectBtn = sender;
    sender.selected = YES;

    switch (sender.tag) {
            
           
        case 1:{
            NSLog(@"园区会员");

            self.number = @"1";

            break;
        }
        case 2:{
            NSLog(@"企业会员");

            
            self.number = @"2";
            
            //将用户的 信息保存
            NSUserDefaults *registUserDefault = [NSUserDefaults standardUserDefaults];
            [registUserDefault setObject:@"2" forKey:@"userTypeId"];
            
            //push 改为 modal
//            [self.navigationController pushViewController:RegistCompanyVC animated:YES];
//            [self presentViewController:RegistCompanyVC animated:YES completion:nil];
            break;
        }
        case 3:{
            NSLog(@"金融机构");

            
            self.number = @"3";
            
            //将用户的 信息保存
            NSUserDefaults *registUserDefault = [NSUserDefaults standardUserDefaults];
            [registUserDefault setObject:@"3" forKey:@"userTypeId"];
            
            
            //push 改为 modal
//            [self.navigationController pushViewController:RegistFinanceOrgnizationVC animated:YES];
//            [self presentViewController:RegistFinanceOrgnizationVC animated:YES completion:nil];
            break;
        }
            
        case 4:{
            NSLog(@"个人");

            
            self.number = @"4";
            
            //将用户的 信息保存
            NSUserDefaults *registUserDefault = [NSUserDefaults standardUserDefaults];
            [registUserDefault setObject:@"4" forKey:@"userTypeId"];
            
            //push 改为 modal
//            [self.navigationController pushViewController:registPersonalVC animated:YES];
//            [self presentViewController:registPersonalVC animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
    
}


- (IBAction)nextVC:(UIButton *)sender {
    
    if (self.number != nil) {
        
        //根据选中的按钮跳转控制器
        if ([self.number isEqualToString:@"1"]) {
            
            LSRegistGardenViewController *registGardenVC = [[LSRegistGardenViewController alloc] initWithNibName:@"LSRegistGardenViewController" bundle:nil];
            
            //跳转之前将分类的编号归档存储
            self.dataModel.userTypeId = self.number;
            
            NSString *path = [LSRegistDataModel filePathForRegist];
            [NSKeyedArchiver archiveRootObject:self.dataModel toFile:path];
            
            
            [self presentViewController:registGardenVC animated:YES completion:nil];
            
        }else if ([self.number isEqualToString:@"2"]){
            
            self.dataModel.userTypeId = self.number;
            NSString *path = [LSRegistDataModel filePathForRegist];
            [NSKeyedArchiver archiveRootObject:self.dataModel toFile:path];
            LSRegistCompanyViewController *RegistCompanyVC = [[LSRegistCompanyViewController alloc] initWithNibName:@"LSRegistCompanyViewController" bundle:nil];
            [self presentViewController:RegistCompanyVC animated:YES completion:nil];
            
        }else if ([self.number isEqualToString:@"3"]){
            
            self.dataModel.userTypeId = self.number;
            NSString *path = [LSRegistDataModel filePathForRegist];
            [NSKeyedArchiver archiveRootObject:self.dataModel toFile:path];
            
            LSRegistFinanceOrgnizationViewController *RegistFinanceOrgnizationVC = [[LSRegistFinanceOrgnizationViewController alloc] initWithNibName:@"LSRegistFinanceOrgnizationViewController" bundle:nil];
            [self presentViewController:RegistFinanceOrgnizationVC animated:YES completion:nil];
        }else if ([self.number isEqualToString:@"4"]){
            
            self.dataModel.userTypeId = self.number;
            NSString *path = [LSRegistDataModel filePathForRegist];
            [NSKeyedArchiver archiveRootObject:self.dataModel toFile:path];
            
            
            LSRegistPersonalViewController *registPersonalVC = [[LSRegistPersonalViewController alloc] initWithNibName:@"LSRegistPersonalViewController" bundle:nil];
            registPersonalVC.passWord = self.dataModel.password;
            registPersonalVC.accountNum = self.dataModel.mobile;
            
            [self presentViewController:registPersonalVC animated:YES completion:nil];
        }
        
    }else{
        [self promptBox_YTC_GeneralWithWords:@"请选择用户类型"];
    }
    
    
    
}


@end
