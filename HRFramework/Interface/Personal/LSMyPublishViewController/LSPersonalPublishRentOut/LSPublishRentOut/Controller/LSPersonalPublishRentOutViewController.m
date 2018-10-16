//
//  LSPersonalPublishRentOutViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/24.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSPersonalPublishRentOutViewController.h"

#import "LSPersonalPublishRentOutCell.h"
#define CELL_PublishRentOut  @"PublishRentOutCell"

#import "LSGetMyRentHouseListModel.h"
//#import "LSCultureFinanceDetailViewController.h"
//#import "LSCultureFinanceProductDetailViewController.h"
#import "LSOfficeRentDetailViewController.h"
//#import "LSNeedOfficeRentDetaiViewController.h"


@interface LSPersonalPublishRentOutViewController ()<LSPersonalPublishRentOutCellDElegate>
{
    BOOL isFirst;
}
@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;
@property (strong, nonatomic) NSMutableArray *dataSourceArr;
@property (nonatomic, copy)NSString *stateStr;

@property (strong, nonatomic) UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIButton *theOneBtn;

@end

@implementation LSPersonalPublishRentOutViewController
#pragma mark - ||========== LifeCycle ===========||
// 视图加载完毕
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"发布的办公出租信息";
    
    self.selectBtn = self.theOneBtn;
    self.selectBtn.selected = YES;
    
    
    self.dataSourceArr = [NSMutableArray array];
    
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSPersonalPublishRentOutCell" bundle:nil] forCellReuseIdentifier:CELL_PublishRentOut];
    
    self.stateStr = @"0";
    //数据请求
    [self requestGetMyWantHouse:NO];
    
    weakSelf(weakSelf);
    
    [self.myCustomTableView.mj_header beginRefreshing];
    
    self.myCustomTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf requestGetMyWantHouse:NO];
        
    }];
    
    self.myCustomTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf requestGetMyWantHouse:YES];
        
    }];
    
    
    [self configUI];
}

- (void)configUI {
    //去掉分割线
    self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self configLeftBarButton];
    
}
- (void)configLeftBarButton {
    [self navigationLeftBarButtonImageNames:@[@"返回"] click:^(NSInteger buttonTag) {
        NSLog(@"dahjkda");
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
}

#pragma mark - ||========== IBActions ===========||
- (IBAction)buttonAction:(UIButton *)sender {
    
    self.selectBtn.selected = NO;
    self.selectBtn = sender;
    sender.selected = YES;
    
    switch (sender.tag) {
        case 1:{
            NSLog(@"待审核");
            //待审核
            self.stateStr = @"0";
            [self requestGetMyWantHouse:NO];
            
            break;
        }
        case 2:{
            NSLog(@"展示中");
            //展示中
            self.stateStr = @"1";
            [self requestGetMyWantHouse:NO];
            
            break;
        }
        case 3:{
            NSLog(@"已结束");
            //已结束
            self.stateStr = @"2";
            [self requestGetMyWantHouse:NO];
            
            break;
        }
            
        default:
            break;
    }
    
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
    
    LSPersonalPublishRentOutCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_PublishRentOut forIndexPath:indexPath];
    
    [cell buildingWithModel:self.dataSourceArr[indexPath.row]];
    
    //去掉分割线
    self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //cell点击变色
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.delegate = self;
    cell.jieshuBtn.tag = indexPath.row;
    cell.jieshuBtn.hidden = NO;
    if ([self.stateStr isEqualToString:@"2"]) {
        cell.jieshuBtn.hidden = YES;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",indexPath);
    
    LSGetMyRentHouseListModel *model = self.dataSourceArr[indexPath.row];
    
    LSOfficeRentDetailViewController *officeRentDetail = [[LSOfficeRentDetailViewController alloc]initWithNibName:@"LSOfficeRentDetailViewController" bundle:nil];
    
    officeRentDetail.Id = model.rentId;
    officeRentDetail.itemTypeId = @"3";
    officeRentDetail.hiddenLowView = 1535;
    
    [self.navigationController pushViewController:officeRentDetail animated:YES];
    
}

#pragma mark - ||==========数据请求===========||

/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.myCustomTableView.mj_header endRefreshing];
    [self.myCustomTableView.mj_footer endRefreshing];
}


-(void)requestGetMyWantHouse:(BOOL)isMore{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    
    [para setObject:userId forKey:@"userId"];
    [para setObject:self.stateStr forKey:@"state"];
    
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
    
    [[HRRequestManager manager] GET_PATH:PATH_GetMyRentHouse para:para success:^(id responseObject) {
        /*
         {
         ds =     (
         {
         Row = 1;
         address = 12;
         regDate = "2016/6/8 16:38:55";
         rizujinEnd = 12;
         rizujinStart = 21;
         sizeEnd = 12;
         sizeStart = 12;
         title = 13;
         viewCount = 2;
         wantId = 19;
         }
         );
         errMsg = "";
         success = 1;
         totalPageNo = 1;
         }
         */
        if ([responseObject[@"success"] boolValue]== 1) {
            NSLog(@"%@",responseObject);
            NSLog(@"请求成功🌹🌹🌹🌹🌹🌹");
            [weakSelf endRefresh];
            isFirst = NO;
            
            [self requestWithFindMyRentHouseListModelProject:[responseObject objectForKey:@"ds"] isMore:isMore];
        
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

- (void)requestWithFindMyRentHouseListModelProject:(NSArray *)Arr isMore:(BOOL)isMore
{
    if (!isMore) {
        [self.dataSourceArr removeAllObjects];
    }
    
    for (NSDictionary *dic in Arr) {
        
        LSGetMyRentHouseListModel *model = [[LSGetMyRentHouseListModel alloc] initWithDictionary:dic];
        
        [self.dataSourceArr addObject:model];
    }
    
    [self.myCustomTableView reloadData];
    
    
}


- (void)jieshufabu:(NSInteger)indecpath {
    NSLog(@"结束发布");
    //  isSuccess  交易是否成功（1成功；0失败）
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"交易是否成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self alertActionMethod:indecpath andIsSuccess:0];
        
    }];
    
    UIAlertAction *bushi = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self alertActionMethod:indecpath andIsSuccess:1];
    }];
    
    [alert addAction:action];
    [alert addAction:bushi];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


-(void)alertActionMethod:(NSInteger)indexPath andIsSuccess:(NSInteger)issuccess{
    

    
    LSGetMyRentHouseListModel *model = self.dataSourceArr[indexPath];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:model.rentId forKey:@"itemId"];
    [para setObject:@"3" forKey:@"itemTypeId"];
    [para setObject:[NSString stringWithFormat:@"%zd",issuccess] forKey:@"isSuccess"];
    
    weakSelf(weakSelf);
    
    [[HRRequestManager manager] GET_PATH:PATH_UpdateStateEnd para:para success:^(id responseObject) {
        
        if ([responseObject[@"success"]boolValue]== 1) {
            NSLog(@"%@",responseObject);
            NSLog(@"请求成功🌹🌹🌹🌹🌹🌹");
            [weakSelf requestGetMyWantHouse:NO];
            
        }
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"请求失败🌹🌹🌹🌹🌹🌹");
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
