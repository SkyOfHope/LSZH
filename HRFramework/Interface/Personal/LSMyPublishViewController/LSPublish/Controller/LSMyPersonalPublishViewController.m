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
    
}

- (IBAction)publishInformation:(UIButton *)sender {
   
    self.selectBtn.selected = NO;
    self.selectBtn = sender;
    sender.selected = YES;
    
    switch (sender.tag) {
        case 1:{
            NSLog(@"发布的融资需求信息");
            LSPersonalFinaceNeedsViewController *finaceNeedsVC = [[LSPersonalFinaceNeedsViewController alloc] initWithNibName:@"LSPersonalFinaceNeedsViewController" bundle:nil];
            
            [self.navigationController pushViewController:finaceNeedsVC animated:YES];
            
            break;
        }
        case 2:{
            NSLog(@"发布的金融产品信息");
            LSPersonalPublishFinanceViewController *publishFinanceVC = [[LSPersonalPublishFinanceViewController alloc] initWithNibName:@"LSPersonalPublishFinanceViewController" bundle:nil];
            
            [self.navigationController pushViewController:publishFinanceVC animated:YES];
            
            break;
        }
        case 3:{
            NSLog(@"发布的办公出租信息");
            LSPersonalPublishRentOutViewController *rentOutVC = [[LSPersonalPublishRentOutViewController alloc] initWithNibName:@"LSPersonalPublishRentOutViewController" bundle:nil];
            
            [self.navigationController pushViewController:rentOutVC animated:nil];
            break;
        }
        case 4:{
            NSLog(@"发布的办公求租信息");
            LSPersonalPublishToRentViewController *publishToRentVC = [[LSPersonalPublishToRentViewController alloc] initWithNibName:@"LSPersonalPublishToRentViewController" bundle:nil];
            
            [self.navigationController pushViewController:publishToRentVC animated:YES];
            break;
        }


        default:
            break;
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
