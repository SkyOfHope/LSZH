
//
//  LSTestDynamicDetailViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/23.
//  Copyright © 2016年 obgniyum. All rights reserved.
//


#define KWEB_URL @"http://www.wcsyq.gov.cn/API/GetArticleModelHtmlALL.aspx?id="

#import "LSTestDynamicDetailViewController.h"

#import "LSTestDynamicDetailCell.h"
#define CELL_TestDynamicDetail  @"TestDynamicDetailCell"
#import "LSShareView.h"
#import "LSGetArticleModel.h"

@interface LSTestDynamicDetailViewController ()<UIWebViewDelegate>
{
    NSString *html_str;
}

@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;
@property (strong, nonatomic) LSShareView *shareView;
@property (strong, nonatomic) NSMutableArray *dataSourceArr;

@property (strong, nonatomic) IBOutlet UIView *topView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation LSTestDynamicDetailViewController

#pragma mark - ||========== LifeCycle ===========||
// 视图加载完毕
- (void)viewDidLoad {
    [super viewDidLoad];

//    self.dataSourceArr = [NSMutableArray array];
//    
//    //注册cell
//    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSTestDynamicDetailCell" bundle:nil] forCellReuseIdentifier:CELL_TestDynamicDetail];
//    
//    /* 设置导航栏上面的内容 */
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(BtnClick) image:@"分享" highImage:nil];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(configUI) image:@"返回" highImage:nil];
//
//    
//    [self requestGetArticleModel];
//
//    [self configUI];
    [self loadWebView:self.Id];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

}


- (void)configUI {
    [self.navigationController popViewControllerAnimated:YES];
//    [self configLeftBarButton];
    
}
- (void)configLeftBarButton {
    [self navigationLeftBarButtonImageNames:@[@"返回"] click:^(NSInteger buttonTag) {
        NSLog(@"dahjkda");
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
}



-(void)BtnClick{
    NSLog(@"分享分享分享分享分享分享分享");
    
    self.shareView = [[LSShareView alloc]init];
    self.shareView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
    //    self.alertView.backgroundColor = RGBColor(0, 0, 0, .5);
    self.shareView.layer.cornerRadius = 5;
    self.shareView.layer.masksToBounds = YES;
    [AppDelegate.window addSubview:self.shareView];
    
    self.shareView.frame = SCREEN_BOUNDS;
    
    NSLog(@"123456");
    
    
    self.shareView.title = self.titles;
    NSLog(KWEB_URL);
    self.shareView.url = [NSString stringWithFormat:@"%@%@", KWEB_URL, self.Id];
    
}


#pragma mark @ UITableViewDataSource && UITableViewDelegate @
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSourceArr.count;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 84;
//}

//返回cell高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.myCustomTableView.estimatedRowHeight = self.myCustomTableView.rowHeight;
    self.myCustomTableView.rowHeight = UITableViewAutomaticDimension;
    return self.myCustomTableView.rowHeight;
}




-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSTestDynamicDetailCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_TestDynamicDetail forIndexPath:indexPath];
    
    [cell buildingWithModel:self.dataSourceArr[indexPath.row]];
    
    //去掉分割线
    self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //cell点击变色
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
//    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"cell点击方法");
    
}

#pragma mark - ||==========数据请求===========||
-(void)requestGetArticleModel{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setValue:self.Id forKey:@"Id"];
    
    weakSelf(weakSelf);
    
    [[HRRequestManager manager] GET_PATH:GetArticleModel para:para success:^(id responseObject) {
        
        NSString *str = responseObject[@"ds"];
        html_str = responseObject[@"ds"][@"content"];
        
        if ([responseObject[@"success"] boolValue] == 1) {
            
            NSLog(@"%@", responseObject);
            NSLog(@"请求成功》。。。");
            [weakSelf.dataSourceArr removeAllObjects];
            
            NSDictionary *data = [responseObject objectForKey:@"ds"];
            
            LSGetArticleModel *model = [[LSGetArticleModel alloc] initWithDictionary:data];
            
            [weakSelf.dataSourceArr addObject:model];
            [weakSelf.myCustomTableView reloadData];
        }
        /** 加载webView */
        [self loadWebView:html_str];

        
    } failure:^(NSError *error) {
        
        
    }];
    
    
    
}

#pragma mark - 加载webView
- (void)loadWebView:(NSString *)url {
    
//    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 64,  SCREEN_WIDTH, 100)];
//    
//    View.backgroundColor = [UIColor redColor];
//    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH-30, 0)];
//    
//    titleLabel.backgroundColor = [UIColor greenColor];
//    
//    
//    titleLabel.font = [UIFont systemFontOfSize:14];
//    NSString *titleContent = @"亲，欢迎您通过以下方式与我们的营销顾问取得联系，交流您再营销推广工作中遇到的问题，营销顾问将免费为您提供咨询服务。";
//    titleLabel.text = titleContent;
//    titleLabel.numberOfLines = 0;//多行显示，计算高度
//    titleLabel.textColor = [UIColor lightGrayColor];
//    CGSize titleSize = [titleContent boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
//    titleLabel.height = titleSize.height;
//    
//    
//    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, titleLabel.height + titleLabel.y + 10, 30, 18)];
//    
//    countLabel.backgroundColor = [UIColor yellowColor];
//    
//    
//    countLabel.font = [UIFont systemFontOfSize:12];
//    NSString *countTitle = @"浏览量：";
//    countLabel.text = countTitle;
//    countLabel.numberOfLines = 0;//多行显示，计算高度
//    countLabel.textColor = [UIColor lightGrayColor];
//    CGSize countSize = [countTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, 16) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
//    countLabel.width = countSize.width;
//    
//    
//    
//    View.height = countLabel.height + countLabel.y + 15;
//    
//    [self.view addSubview:View];
//    [View addSubview:titleLabel];
//    [View addSubview:countLabel];
    
    
    
    self.titleLabel.text = self.titles;
    self.timeLabel.text = [self cutAndReplaceDate:self.date][0];
    
    self.countLabel.text = self.count;
    
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT- 64)];
    [self.view addSubview:webView];
    webView.delegate = self;
    [webView loadHTMLString:url baseURL:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", KWEB_URL, url]]];
    [webView loadRequest:request];
}

#pragma mark -  UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requeststr = [NSString stringWithFormat:@"%@",request];
    NSLog(@"%@",requeststr);
    return YES;
}
//截取时间字符串
//0为日期 1为时间
-(NSMutableArray*)cutAndReplaceDate:(NSString *)date{
    
    if (date.length > 0) {
        NSArray *arr = [date componentsSeparatedByString:@" "];
        
        NSString *dateStr = [arr[0] stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
        
        NSMutableArray *dateArr = [NSMutableArray arrayWithArray:arr];
        
        [dateArr replaceObjectAtIndex:0 withObject:dateStr];
        
        return dateArr;
        
    }else{
        return nil;
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
