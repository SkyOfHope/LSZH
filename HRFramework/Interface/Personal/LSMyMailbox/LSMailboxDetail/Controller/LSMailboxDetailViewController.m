//
//  LSMailboxDetailViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/6/1.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSMailboxDetailViewController.h"

@interface LSMailboxDetailViewController ()

@property (strong, nonatomic) UILabel *label;

@end

@implementation LSMailboxDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"消息详情";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, self.view.frame.size.height)];
    scrollView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:scrollView];
    
    self.label = [[UILabel alloc] init];
//    self.label.backgroundColor = [UIColor redColor];
    self.label.frame = CGRectMake( 10, -54, SCREEN_WIDTH-20, 10);
    
    [scrollView addSubview:self.label];
    
    [self requestGetMessageModel];
    
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


-(UILabel *)createLabel:(UILabel *)label withText:(NSString *)Ltext withFont:(CGFloat )Lfont withtosize:(CGRect)Lframe withLine:(NSInteger)Lline
{
    //内容显示  高度自适应
    //    CGSize sizeToFit =[Ltext sizeWithFont:[UIFont systemFontOfSize:Lfont]constrainedToSize:CGSizeMake(Lframe.size.width,60)lineBreakMode:NSLineBreakByWordWrapping];
    CGSize sizeToFit =[Ltext sizeWithFont:[UIFont systemFontOfSize:Lfont]constrainedToSize:CGSizeMake(Lframe.size.width,10000)lineBreakMode:NSLineBreakByWordWrapping];
    CGRect labelframe = CGRectMake(Lframe.origin.x,Lframe.origin.y,sizeToFit.width, sizeToFit.height);
    label.frame=labelframe;
    label.numberOfLines=Lline;
    label.lineBreakMode=NSLineBreakByTruncatingTail;
    label.font=[UIFont systemFontOfSize:Lfont];
    label.text = Ltext;
    //    label.backgroundColor=kbackgroundColor;
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor darkTextColor];
    //    [self.view addSubview:label];
    
    return label;
}


#pragma mark - ||==========数据请求===========||
-(void)requestGetMessageModel{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:self.ID forKey:@"messageId"];
    
    [[HRRequestManager manager] GET_PATH:PATH_GetMessageModel para:para success:^(id responseObject) {
        
        NSDictionary *data = [responseObject objectForKey:@"ds"];
        
        [self createLabel:self.label withText:[data objectForKey:@"content"] withFont:14 withtosize:self.label.frame withLine:0];
        
//        self.label.text = [data objectForKey:@"content"];
        
    } failure:^(NSError *error) {
        
        
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
