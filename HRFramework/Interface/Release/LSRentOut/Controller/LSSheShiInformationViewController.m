//
//  LSSheShiInformationViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/6/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSSheShiInformationViewController.h"
#import "LStotalCompeleteModel.h"
@interface LSSheShiInformationViewController ()<UITextViewDelegate>
//@property (weak, nonatomic) IBOutlet UITextField *shejidanweitf;
//@property (weak, nonatomic) IBOutlet UITextField *shigongdanweiTF;
@property (strong, nonatomic) IBOutlet UITextView *shejidanweitf;
@property (strong, nonatomic) IBOutlet UILabel *placeWordLabel;
@property (strong, nonatomic) IBOutlet UILabel *leftWordLabel;


@property (strong, nonatomic) IBOutlet UITextView *shigongdanweiTF;

@property (strong, nonatomic) IBOutlet UILabel *shigongdanweiTFLabel;
@property (strong, nonatomic) IBOutlet UILabel *shigongdanweiTFLeftWordLabel;


@end

@implementation LSSheShiInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"设施配套信息";
    
    [self configUI];
    
    LStotalCompeleteModel *model = [LStotalCompeleteModel shareInstance];
    
    if (model.shejidanwei1.length > 0)
    {
        self.shejidanweitf.text = model.shejidanwei1;
        self.placeWordLabel.hidden = YES;
        if (model.shigongdanwei1.length > 0)
        {
            self.shigongdanweiTF.text = model.shigongdanwei1;
            self.shigongdanweiTFLabel.hidden = YES;
        }else
        {
        }
    }else
    {
    }
    
    self.shigongdanweiTF.delegate = self;
    self.shejidanweitf.delegate = self;

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
    model.shejidanwei1 = _shejidanweitf.text;
    model.shigongdanwei1 = _shigongdanweiTF.text;
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark=============UITextViewDelegate==================
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (textView == self.shejidanweitf) {
        self.placeWordLabel.hidden = YES;
    }
    if (textView == self.shigongdanweiTF) {
        self.shigongdanweiTFLabel.hidden = YES;
    }
    
    
}

-(void)textViewDidChangeSelection:(UITextView *)textView{
    
    NSInteger wordCount = textView.text.length;
    
    if (textView == self.shejidanweitf) {
       self.leftWordLabel.text = [NSString stringWithFormat:@"%zd/500字",wordCount];
    }
    if (textView == self.shigongdanweiTF) {
        self.shigongdanweiTFLeftWordLabel.text = [NSString stringWithFormat:@"%zd/500字",wordCount];;
    }
    
    
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
