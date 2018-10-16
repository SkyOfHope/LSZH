//
//  LSAboutMineController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/8/31.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSAboutMineController.h"

#define KWEB_URL @"http://www.wcsyq.gov.cn/API/About.aspx"

@interface LSAboutMineController ()<UIWebViewDelegate>

@end

@implementation LSAboutMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"关于我们";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(configUI) image:@"返回" highImage:nil];
    
    [self loadWebView:nil];
    
}


- (void)configUI {
    [self.navigationController popViewControllerAnimated:YES];
    //    [self configLeftBarButton];
    
}

#pragma mark - 加载webView
- (void)loadWebView:(NSString *)url {
    
    
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
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
