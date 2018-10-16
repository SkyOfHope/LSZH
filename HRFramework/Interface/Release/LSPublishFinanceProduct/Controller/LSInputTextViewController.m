//
//  LSInputTextViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/7/21.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSInputTextViewController.h"

#import "LSPublishFinanceproductViewController.h"
#import "LSSingelForPubilishFinaceProduct.h"


@interface LSInputTextViewController ()<UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *contentTextView;

@property (strong, nonatomic) IBOutlet UILabel *placeWordLabel;

@property (strong, nonatomic) IBOutlet UILabel *leftWordLabel;
@property (strong, nonatomic) IBOutlet UIButton *completeBtn;


@end

@implementation LSInputTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.title = @"请输入";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.contentTextView.delegate = self;
    self.contentTextView.text = self.str;
    
    if (self.contentTextView.text.length>0) {
        self.placeWordLabel.hidden = YES;
    }
 
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

- (IBAction)completeBtn:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(sendText: WithLabelTag:)]) {
        [_delegate sendText:self.contentTextView.text WithLabelTag:self.labelTag];
    }
    
    LSSingelForPubilishFinaceProduct *shareSingle= [LSSingelForPubilishFinaceProduct shareSingelForPubilishFinaceProduct];
    
    switch (self.labelTag) {
        case 101:
            shareSingle.detailTFContent = self.contentTextView.text;
            break;
        case 102:
            shareSingle.instructionDetailtfContent = self.contentTextView.text;
            break;
        case 103:
            shareSingle.applicableCustomerTFContent = self.contentTextView.text;
            break;
        case 104:
            shareSingle.requirementTF = self.contentTextView.text;
            break;
        case 105:
            shareSingle.materialTF = self.contentTextView.text;
            break;
        case 106:
             shareSingle.processTF = self.contentTextView.text;
            break;
        case 107:
            shareSingle.remarksTF = self.contentTextView.text;
            break;
            
            
        case 201:
            shareSingle.financeUseTextField = self.contentTextView.text;
            break;
        case 202:
            shareSingle.provideMaterialTextField = self.contentTextView.text;
            break;
        case 203:
            shareSingle.projectDescripeTextField = self.contentTextView.text;
            break;
        case 204:
            shareSingle.projectGoodTextField = self.contentTextView.text;
            break;
        case 205:
//            shareSingle.remarkTF = @"";
            shareSingle.remarkTF = self.contentTextView.text;
            break;
            
            
        case 301:
            shareSingle.peitaoSheshiTF = self.contentTextView.text;
            break;
        case 302:
            shareSingle.jiaotongTF = self.contentTextView.text;
            break;
        case 303:
            shareSingle.remarkTF = self.contentTextView.text;
            break;
        case 304:
            shareSingle.tipsTF = self.contentTextView.text;
            break;
            
            
//        case 101:
//            shareSingle.detailTFContent = self.contentTextView.text;
//            break;

            
        default:
            break;
    }
    
//    if (self.labelTag == 101) {
//        shareSingle.detailTFContent = self.contentTextView.text;
//    }
//    if (self.labelTag == 102) {
//        shareSingle.instructionDetailtfContent = self.contentTextView.text;
//    }
//    if (self.labelTag == 103) {
//        shareSingle.applicableCustomerTFContent = self.contentTextView.text;
//    }
//    if (self.labelTag == 104) {
//        shareSingle.requirementTF = self.contentTextView.text;
//    }
//    if (self.labelTag == 105) {
//        shareSingle.materialTF = self.contentTextView.text;
//    }
//    if (self.labelTag == 106) {
//        shareSingle.processTF = self.contentTextView.text;
//    }
//    if (self.labelTag == 107) {
//        shareSingle.remarksTF = self.contentTextView.text;
//    }
    
    
//    if (self.labelTag == 201) {
//        shareSingle.financeUseTextField = self.contentTextView.text;
//    }

    
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
        
        self.contentTextView.text = string;
    }
    
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    
//    
//    if (self.contentTextView.text.length >= 500) {
//        
//        return NO;
//    }else{
//        
//        return YES;
//    }
//    
//    
//    NSString *string = [self.contentTextView.text stringByReplacingCharactersInRange:range withString:text];
//    
//    if ([string length] > 500)
//        
//    {
//        
//        string = [string substringToIndex:500];
//        
//    }
//    
//    self.contentTextView.text = string;
//    
//    return NO;
//    
//    
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
