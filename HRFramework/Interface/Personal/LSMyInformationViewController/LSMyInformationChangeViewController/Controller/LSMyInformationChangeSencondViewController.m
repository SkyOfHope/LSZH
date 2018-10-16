//
//  LSMyInformationChangeSencondViewController.m
//  LSZH
//
//  Created by apple  on 16/8/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSMyInformationChangeSencondViewController.h"

@interface LSMyInformationChangeSencondViewController ()


@property (weak, nonatomic) IBOutlet UITextView *textF;

@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@end

@implementation LSMyInformationChangeSencondViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textF.text = self.detailtext;
    
    self.sureButton.layer.cornerRadius = 20;
    self.sureButton.layer.masksToBounds = YES;
    
    [self.sureButton addTarget:self action:@selector(changeInformationAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self configUI];
}

- (void)configUI {
    
    [self configLeftBarButton];
    
}
- (void)configLeftBarButton {
    [self navigationLeftBarButtonImageNames:@[@"返回"] click:^(NSInteger buttonTag) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
}


-(void)changeInformationAction{
    
    //获取参数
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    
    //创建参数字典
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithObject:userId forKey:@"userId"];
    
    //其他参数
    
    if (self.textF.text.length > 0) {
        

        [para setObject:self.textF.text forKey:@"remark"];

        
        //网络修改数据
        [[HRRequestManager manager]POST_PATH:PATH_UpdateUser para:para success:^(id responseObject) {
            
            if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
                
                NSLog(@"修改成功");
                
                
                    //提示成功
                    [self promptBox_YTC_GeneralWithWords_epinasty:@"修改成功"];
                    //可以登录,返回刷新即可
                    [self.delegate reloadNewinformation];
                
                    [self.navigationController popViewControllerAnimated:YES];

                
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

@end
