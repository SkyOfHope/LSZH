//
//  LSRegistProtocolViewController.m
//  LSZH
//
//  Created by apple  on 16/6/14.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSRegistProtocolViewController.h"

@interface LSRegistProtocolViewController ()<UITextViewDelegate>


@property (weak, nonatomic) IBOutlet UITextView *text;

@property (weak, nonatomic) IBOutlet UILabel *filed;

@end

@implementation LSRegistProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.text.delegate = self;
    
    self.view.backgroundColor = self.text.backgroundColor;
 
    self.text.showsVerticalScrollIndicator = NO;
    self.text.showsHorizontalScrollIndicator = NO;
    
    self.filed.backgroundColor = self.filed.backgroundColor;
    
    [self configUI];
}


-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
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

//回到注册页面
- (IBAction)toRigistController:(id)sender {
    
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
