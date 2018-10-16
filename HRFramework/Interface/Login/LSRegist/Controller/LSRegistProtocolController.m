//
//  LSRegistProtocolController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/8/31.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSRegistProtocolController.h"

#define KWEB_URL @"http://www.wcsyq.gov.cn/API/RegisterProtocol.aspx"

@interface LSRegistProtocolController ()<UIWebViewDelegate>

@end

@implementation LSRegistProtocolController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"用户注册协议";
    
    
    
    [self loadWebView:nil];
}

//回到注册页面
- (IBAction)toRigistController:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - 加载webView
- (void)loadWebView:(NSString *)url {
    

    
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT- 64)];
    [self.view addSubview:webView];
    webView.delegate = self;
    [webView loadHTMLString:url baseURL:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", KWEB_URL]]];
    [webView loadRequest:request];
}

#pragma mark -  UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requeststr = [NSString stringWithFormat:@"%@",request];
    NSLog(@"%@",requeststr);
    return YES;
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
