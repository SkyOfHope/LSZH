//
//  LSTestDynamicViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/23.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSTestDynamicViewController.h"

#import "LSTestDynamicCell.h"
#define CELL_TestDynamic  @"TestDynamicCell"

#import "LSTestDynamicHeaderView.h"
#import "LSTestDynamicDetailViewController.h"
#import "LSSearchViewController.h"

#import "LSGetSyqdtTopModel.h"
#import "LSGetSyqdtModel.h"

#import "LSTestDynamicNoImageTableViewCell.h"

@interface LSTestDynamicViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL isFirst;
}


@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;

@property (strong, nonatomic) LSTestDynamicHeaderView *testHeader;
/**
 *  tableView 数据源
 */
@property (strong, nonatomic) NSMutableArray *dataSourceArr;

@end

@implementation LSTestDynamicViewController
#pragma mark - ||========== Lazy loading ===========||
-(LSTestDynamicHeaderView *)testHeader{
    if (!_testHeader) {
        _testHeader = [[NSBundle mainBundle] loadNibNamed:@"LSTestDynamicHeaderView" owner:nil options:nil].lastObject;
        
        weakSelf(weakSelf);
        
        _testHeader.backBlock = ^(){
          
            [weakSelf.myCustomTableView reloadData];
            
        };
        
        
//        [_testHeader buildingWithModel:self.dataSourceArr];
    }
    
    return _testHeader;
}

#pragma mark - ||========== LifeCycle ===========||
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"实验区动态";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.dataSourceArr = [NSMutableArray array];
    
    //设置导航搜索按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(BtnClick) image:@"搜索" highImage:nil];
    
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSTestDynamicCell" bundle:nil] forCellReuseIdentifier:CELL_TestDynamic];
    
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSTestDynamicNoImageTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    
    self.myCustomTableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
    
//    self.myCustomTableView.tableHeaderView = self.testHeader;

    
    [self requestSyqdtTop];
    [self requestGetSyqdt:NO];
    
    weakSelf(weakSelf);
    
    [self.myCustomTableView.mj_header beginRefreshing];
    
    self.myCustomTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf requestGetSyqdt:NO];
        
    }];
    
    self.myCustomTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf requestGetSyqdt:YES];
        
    }];
    
    
    [self configUI];
    
}


- (void)configUI {
    
    self.myCustomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self configLeftBarButton];
    
}
- (void)configLeftBarButton {

    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -5;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 9.5, 18)];
    [btn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];

    self.navigationItem.leftBarButtonItems = @[space,item];
}

-(void)popVC{
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark - ||========= PrivateMethods =========||
-(void)BtnClick{
    NSLog(@"搜索搜索搜索搜索搜索搜索搜索搜索搜索");
    
    LSSearchViewController *searchVC = [[LSSearchViewController alloc] initWithNibName:@"LSSearchViewController" bundle:nil];
    searchVC.type = @"6";
    [self.navigationController pushViewController:searchVC animated:YES];
    
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


NSString *identifier = @"identifierForNoImageCell";

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    LSGetSyqdtModel *model = self.dataSourceArr[indexPath.row];
    
    if (model.imgPath.length > 0) {
        LSTestDynamicCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_TestDynamic forIndexPath:indexPath];
        
        [cell buildingWithModel:self.dataSourceArr[indexPath.row]];
        
        //去掉分割线
        self.myCustomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //cell点击变色
//        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
        
    }else{
        
        LSTestDynamicNoImageTableViewCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        
        [cell buildingSecondCellWithModel:self.dataSourceArr[indexPath.row]];
        
        //去掉分割线
        self.myCustomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
        
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"cell点击方法");
    
    LSGetSyqdtModel *model = self.dataSourceArr[indexPath.row];
    
    LSTestDynamicDetailViewController *detailVC = [[LSTestDynamicDetailViewController alloc] initWithNibName:@"LSTestDynamicDetailViewController" bundle:nil];
    
    detailVC.Id = model.articleId;
//    detailVC.title = model.title;
    detailVC.titles = model.title;
    detailVC.date = model.publishdate;
    detailVC.count = model.viewCount;
    
    [self.navigationController pushViewController:detailVC animated:nil];
    
}



-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return self.testHeader;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return self.testHeader.headerHeight;
}

#pragma mark - ||==========数据请求===========||

/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.myCustomTableView.mj_header endRefreshing];
    [self.myCustomTableView.mj_footer endRefreshing];
}


-(void)requestSyqdtTop{
    
       
    [[HRRequestManager manager] GET_PATH:GetSyqdtTop para:nil success:^(id responseObject) {
        
        NSDictionary *data = [responseObject objectForKey:@"ds"];
        
        LSGetSyqdtTopModel *model = [[LSGetSyqdtTopModel alloc] initWithDictionary:data];
        
//        [self.dataSourceArr addObject:model];
//        NSLog(@"🌹🌹🌹🌹🌹🌹🌹%@",self.dataSourceArr);
        [self.testHeader buildingWithModel:model];
        
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

-(void)requestGetSyqdt:(BOOL)isMore{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
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
    
    [[HRRequestManager manager] GET_PATH:GetSyqdt para:para success:^(id responseObject) {
        
        
        if ([responseObject[@"success"]boolValue] == 1) {
            
            NSLog(@"打印成功");
            
            [weakSelf endRefresh];
            isFirst = NO;
            
            [self requestWithFindSyqdtModelProject:[responseObject objectForKey:@"ds"] isMore:isMore];
            
        }
        
        
    } failure:^(NSError *error) {
        
        [weakSelf endRefresh];
        
    }];
    
    
}

- (void)requestWithFindSyqdtModelProject:(NSArray *)Arr isMore:(BOOL)isMore
{
    if (!isMore) {
        [self.dataSourceArr removeAllObjects];
    }
    
    for (NSDictionary *dic in Arr) {
        
        LSGetSyqdtModel *model = [[LSGetSyqdtModel alloc] initWithDictionary:dic];
        
        [self.dataSourceArr addObject:model];
    }
    
    [self.myCustomTableView reloadData];
    
    
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
