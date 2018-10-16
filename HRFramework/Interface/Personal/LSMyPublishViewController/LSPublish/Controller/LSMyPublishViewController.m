//
//  LSMyPublishViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/19.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSMyPublishViewController.h"

#import "LSPublishRentOutViewController.h"


@interface LSMyPublishViewController ()

@property (strong, nonatomic) UIButton *selectBtn;

@end

@implementation LSMyPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)publishInformation:(UIButton *)sender {
   
    self.selectBtn.selected = NO;
    self.selectBtn = sender;
    sender.selected = YES;
    
    LSPublishRentOutViewController *rentOutVC = [[LSPublishRentOutViewController alloc] initWithNibName:@"LSPublishRentOutViewController" bundle:nil];
    
    [self.navigationController pushViewController:rentOutVC animated:nil];
    
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
