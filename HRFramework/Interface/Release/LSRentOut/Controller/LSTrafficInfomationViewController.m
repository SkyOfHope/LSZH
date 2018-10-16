

//
//  LSTrafficInfomationViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/6/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSTrafficInfomationViewController.h"
#import "LStotalCompeleteModel.h"
@interface LSTrafficInfomationViewController ()<UITextViewDelegate>

//@property (weak, nonatomic) IBOutlet UITextField *jiaotongpeitaoTF;
@property (strong, nonatomic) IBOutlet UITextView *jiaotongpeitaoTF;
@property (strong, nonatomic) IBOutlet UILabel *placeWordLabel;
@property (strong, nonatomic) IBOutlet UILabel *leftWordLabel;




@end

@implementation LSTrafficInfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"交通配套信息";
    
    [self configUI];
    
    LStotalCompeleteModel *model = [LStotalCompeleteModel shareInstance];
    
    if (model.jiaotongpeitao.length > 0) {
        self.jiaotongpeitaoTF.text = model.jiaotongpeitao;
        self.placeWordLabel.hidden = YES;
    }
    
    
    self.jiaotongpeitaoTF.delegate = self;
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


- (IBAction)compeleteAction:(id)sender {
    LStotalCompeleteModel *model = [LStotalCompeleteModel shareInstance];
    model.jiaotongpeitao = _jiaotongpeitaoTF.text;
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark=============UITextViewDelegate==================
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    self.placeWordLabel.hidden = YES;
    
}

-(void)textViewDidChangeSelection:(UITextView *)textView{
    
    NSInteger wordCount = textView.text.length;
    
    self.leftWordLabel.text = [NSString stringWithFormat:@"%zd/500字",wordCount];
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    NSString *string = textView.text;
    if ([string length] > 500)
        
    {
        
        string = [string substringToIndex:500];
        
        textView.text = string;
    }
    
}


//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    
//    
//    if (textView.text.length >= 500) {
//        
//        return NO;
//    }else{
//        
//        return YES;
//    }
//    
//}





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
