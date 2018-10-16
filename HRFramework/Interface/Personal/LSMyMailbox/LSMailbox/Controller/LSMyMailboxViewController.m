//
//  LSMyMailboxViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/20.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSMyMailboxViewController.h"

#import "LSMailboxTableViewCell.h"
#define CELL_Mailbox  @"MailboxCell"

#import "LSGetUserMessageListModel.h"
#import "LSMailboxDetailViewController.h"


@interface LSMyMailboxViewController ()
{
    BOOL isFirst;
}

@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;

@property (strong, nonatomic) NSMutableArray *dataSourceArr;

@end

@implementation LSMyMailboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"我的信箱";
    
    self.dataSourceArr = [NSMutableArray array];
    
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSMailboxTableViewCell" bundle:nil] forCellReuseIdentifier:CELL_Mailbox];
    
    //去掉分隔线
    self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    

    
    //数据请求
    [self requestGetUserMessage:NO];
    
    weakSelf(weakSelf);
    
    [self.myCustomTableView.mj_header beginRefreshing];
    
    self.myCustomTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf requestGetUserMessage:NO];
        
    }];
    
    self.myCustomTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf requestGetUserMessage:YES];
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    LSMailboxTableViewCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_Mailbox forIndexPath:indexPath];
    
    [cell buildingWithModle:self.dataSourceArr[indexPath.row]];
    
    //cell点击变色
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //去掉分隔线
    self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"#$#$#$#$#$#$#$#$#$##$#$#");
    
    LSGetUserMessageListModel *model = self.dataSourceArr[indexPath.row];
    
    LSMailboxDetailViewController *detailVC = [[LSMailboxDetailViewController alloc] init];
    
    detailVC.ID = model.messageId;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - ||==========数据请求===========||√

/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.myCustomTableView.mj_header endRefreshing];
    [self.myCustomTableView.mj_footer endRefreshing];
}


-(void)requestGetUserMessage:(BOOL)isMore{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    
    [para setObject:userId forKey:@"userId"];
    
    [para setObject:@"0" forKey:@"pageNo"];
    [para setObject:@"10" forKey:@"pageSize"];
    
    if (self.dataSourceArr.count % 10 == 0)
    {
        [para setObject:isMore ? [NSString stringWithFormat:@"%lu",(long)self.dataSourceArr.count/10+1 ] : @"1" forKey:@"pageNo"] ;
    }
    else
    {
        
        [para setObject:isMore ? [NSString stringWithFormat:@"%lu",self.dataSourceArr.count/10+2] :@"1" forKey:@"pageNo"];
    }
    
    weakSelf(weakSelf);

    
    [[HRRequestManager manager] GET_PATH:PATH_GetUserMessage para:para success:^(id responseObject) {
        
        [weakSelf endRefresh];
        isFirst = NO;
        
        
        [self requestWithFindUserMessageListModelProject:[responseObject objectForKey:@"ds"] isMore:isMore];
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

- (void)requestWithFindUserMessageListModelProject:(NSArray *)Arr isMore:(BOOL)isMore
{
    if (!isMore) {
        [self.dataSourceArr removeAllObjects];
    }
    
    for (NSDictionary *dic in Arr) {
        
        LSGetUserMessageListModel *model = [[LSGetUserMessageListModel alloc] initWithDictionary:dic];
        
        [self.dataSourceArr addObject:model];
        
    }
    
    [self.myCustomTableView reloadData];
    
    
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
