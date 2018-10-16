
//
//  LSMyCollectionViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/24.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSMyCollectionViewController.h"

#import "LSMyCollectionTableViewCell.h"
#define CELL_MyCollection @"MyCollectionTableViewCell"

#import "LSNeedOfficeRentCell.h"
#define CELL_NeedOfficeRent  @"NeedOfficeRentCell"


#import "LSGetCollectFinancingList.h"
#import "LSGetCollectJinRongList.h"
#import "LSGetCollectRentHouseList.h"
#import "LSGetCollectWantHouseList.h"


#import "LSCultureFinanceDetailViewController.h"
#import "LSCultureFinanceProductDetailViewController.h"
#import "LSOfficeRentDetailViewController.h"
#import "LSNeedOfficeRentDetaiViewController.h"




@interface LSMyCollectionViewController ()<LSMyCollectionTableViewCellDelegate>
{
    BOOL isFirst;
}

@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;

@property (strong, nonatomic) UIButton *selectBtn;
@property (strong, nonatomic) NSMutableArray *dataSourceArr;


@property (strong, nonatomic) NSString *itemTypeId;



@property (weak, nonatomic) IBOutlet UIButton *TheOneBtn;



@end

@implementation LSMyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"我的收藏";
    
    self.dataSourceArr = [NSMutableArray array];
    
    self.selectBtn = self.TheOneBtn;
    self.selectBtn.selected = YES;
    [self requestGetCollectFinancing:YES];
    
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSMyCollectionTableViewCell" bundle:nil] forCellReuseIdentifier:CELL_MyCollection];
    
    //注册cell-two
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSNeedOfficeRentCell" bundle:nil] forCellReuseIdentifier:CELL_NeedOfficeRent];
    
    //数据请求
    
    
    weakSelf(weakSelf);
    
    [self.myCustomTableView.mj_header beginRefreshing];
    
    self.myCustomTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        switch (self.selectBtn.tag) {
            case 1:
                [weakSelf requestGetCollectFinancing:NO];
                break;
            case 2:
                [weakSelf requestGetCollectJinRong:NO];
                break;
            case 3:
                [weakSelf requestGetCollectRentHouse:NO];
                
                break;
            case 4:
                [self requestGetCollectWantHouse:NO];
                
                break;
                
            default:
                break;
        }

    }];
    
    self.myCustomTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        switch (self.selectBtn.tag) {
            case 1:
                [weakSelf requestGetCollectFinancing:YES];
                break;
            case 2:
                [weakSelf requestGetCollectJinRong:YES];
                break;
            case 3:
                [weakSelf requestGetCollectRentHouse:YES];
                break;
            case 4:
                [self requestGetCollectWantHouse:YES];
                break;
                
            default:
                break;
        }

    }];
    
    [self configUI];
    
}

- (void)configUI {
    
    //删除cell分割线
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
- (IBAction)ButtonAction:(UIButton *)sender {
    
    
    //    if (self.selectBtn.selected) {
    //        return;
    //    }
    
    self.selectBtn.selected = NO;
    self.selectBtn = sender;
    sender.selected = YES;
    
    switch (sender.tag) {
        case 1:
            NSLog(@"融资需求融资需求融资需求融资需求融资需求");
            self.itemTypeId = @"2";
            //融资需求数据请求
            [self requestGetCollectFinancing:NO];
            
            break;
        case 2:
            NSLog(@"金融产品金融产品金融产品金融产品金融产品");
            
            self.itemTypeId = @"1";
            //金融产品数据请求
            [self requestGetCollectJinRong:NO];

            break;
        case 3:
            NSLog(@"办公出租办公出租办公出租办公出租办公出租");
            
            self.itemTypeId = @"3";
            //办公出租数据请求
            [self requestGetCollectRentHouse:NO];
            
            break;
        case 4:
            NSLog(@"办公求租办公求助办公求助办公求助办公求助");
            self.itemTypeId = @"4";
            //办公求助数据请求
            [self requestGetCollectWantHouse:NO];
            
            break;
            
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
    
    switch (self.selectBtn.tag) {
        case 1:{
            LSMyCollectionTableViewCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_MyCollection forIndexPath:indexPath];
            NSLog(@"融资需求融资需求融资需求融资需求融资需求");
            
            [cell buildingFinancingWithModel:self.dataSourceArr[indexPath.row]];
            
//            weakSelf(weakSelf);
//            [cell prepareNetRequest:^(LSCancelCollectModel *model) {
//                NSString *itemId = model.itemId;
////                [weakSelf requestCancelCollect:(NSString *)];
//                [weakSelf requestCancelCollect:itemId itemTypeId:model.itemTypeId];
//                
//            }];
            
            //取出模型 中 的数据对cell 取消收藏需要的参数 进行赋值
            cell.TypeIdentifier = @"2";
            
            LSGetCollectFinancingList *model = self.dataSourceArr[indexPath.row];
            
            cell.itemIdentifier = model.financingId ;
            
            cell.delegate = self;
            
            //去掉分隔线
            self.myCustomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            return cell;
            break;
        }
        case 2:{
            LSMyCollectionTableViewCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_MyCollection forIndexPath:indexPath];
            NSLog(@"金融产品金融产品金融产品金融产品金融产品");
            [cell buildingJinRongWithModel:self.dataSourceArr[indexPath.row]];
            
            cell.TypeIdentifier = @"1";
            
            //取出模型 中 的数据对cell进行赋值
            LSGetCollectJinRongList *model = self.dataSourceArr[indexPath.row];
            
            cell.itemIdentifier = model.jinrongId;
            
            cell.delegate = self;
            
            //去掉分割线
            self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            return cell;
            
            break;
        }
        case 3:{
            
            LSMyCollectionTableViewCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_MyCollection forIndexPath:indexPath];
            NSLog(@"办公出租办公出租办公出租办公出租办公出租");
            [cell buildingRentHouseWithModel:self.dataSourceArr[indexPath.row]];
            
            cell.TypeIdentifier = @"3";
            
            LSGetCollectRentHouseList *model = self.dataSourceArr[indexPath.row];
            
            cell.itemIdentifier = model.rentId;
            //添加代理方法
            cell.delegate = self;
            self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            return cell;
            break;
        }
        case 4:{
            
            LSNeedOfficeRentCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_NeedOfficeRent forIndexPath:indexPath];
            
//            NSLog(@"办公求租办公求助办公求助办公求助办公求助");
            cell.appointmentBtn.titleLabel.text = @"取消收藏";
            
            [cell buildingWantHouseWithModel:self.dataSourceArr[indexPath.row]];
            
            LSGetCollectWantHouseList *model = self.dataSourceArr[indexPath.row];

            cell.TypeIdentifier = @"4";
            cell.itemIdentifier = model.wantId;
            
            //去掉分割线
            self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            return cell;
            
            break;
        }
            
        default:
            break;
    }
    
        
    return nil;
}

-(void)cancelCollectWith:(NSInteger)itemType isSuccess:(BOOL)success{
    //先判断是否成功,如果取消成功
    if (success) {
        
        //cell取消收藏后在主控制器中根据取消收藏cell的类型进行刷新
        
        if (itemType == 2) {
            [self requestGetCollectFinancing:NO];
        }else if (itemType == 1){
            [self requestGetCollectJinRong:NO];
        }else if (itemType == 3){
            [self requestGetCollectRentHouse:NO];
        }else{
            return;
        }
        
        [self.myCustomTableView reloadData];
        
        [self promptBox_YTC_GeneralWithWords:@"取消成功"];
        
    }else{
        //否则提示 取消失败
        [self promptBox_YTC_GeneralWithWords:@"取消失败"];
        
    }

}

-(void)cancelBtnForNeedOfficeItem:(NSInteger)itemIdentifier{
    
    [self requestGetCollectWantHouse:NO];
    
    [self.myCustomTableView reloadData];
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",indexPath);
    
    switch (self.selectBtn.tag) {
        case 1:{
            NSLog(@"融资需求融资需求融资需求融资需求融资需求");
            
            LSGetCollectFinancingList *model = self.dataSourceArr[indexPath.row];
            LSCultureFinanceDetailViewController  *cultureFinanceDetail = [[LSCultureFinanceDetailViewController alloc] initWithNibName:@"LSCultureFinanceDetailViewController" bundle:nil];
            
            cultureFinanceDetail.Id = model.financingId;
            cultureFinanceDetail.itemTypeId = @"1";
            //传入值 判断 是否隐藏下方的view
            cultureFinanceDetail.isHidden = 135;
            
            [self.navigationController pushViewController:cultureFinanceDetail animated:YES];
            
            break;
        }
        case 2:{
            NSLog(@"金融产品金融产品金融产品金融产品金融产品");
            
            LSGetCollectJinRongList *model = self.dataSourceArr[indexPath.row];
            LSCultureFinanceProductDetailViewController *cultureFinanceProductDetail = [[LSCultureFinanceProductDetailViewController alloc]initWithNibName:@"LSCultureFinanceProductDetailViewController" bundle:nil];
            
            cultureFinanceProductDetail.Id = model.jinrongId;
            cultureFinanceProductDetail.itemTypeId = @"2";
            
            cultureFinanceProductDetail.isHidden = 51;
            
            [self.navigationController pushViewController:cultureFinanceProductDetail animated:YES];
            
            break;
        }
        case 3:{
            NSLog(@"办公出租办公出租办公出租办公出租办公出租");
            
            LSGetCollectRentHouseList *model = self.dataSourceArr[indexPath.row];
            
            LSOfficeRentDetailViewController *officeRentDetailVC = [[LSOfficeRentDetailViewController alloc] initWithNibName:@"LSOfficeRentDetailViewController" bundle:nil];
            
            officeRentDetailVC.Id = model.rentId;
            officeRentDetailVC.itemTypeId = @"3";
            
            officeRentDetailVC.hiddenLowView = 03;
            
            [self.navigationController pushViewController:officeRentDetailVC animated:YES];
            break;
        }
        case 4:{
            NSLog(@"办公求租办公求助办公求助办公求助办公求助");
            
            LSGetCollectWantHouseList *model = self.dataSourceArr[indexPath.row];
            LSNeedOfficeRentDetaiViewController *needOfficeRentDetai = [[LSNeedOfficeRentDetaiViewController alloc] initWithNibName:@"LSNeedOfficeRentDetaiViewController" bundle:nil];
            
            needOfficeRentDetai.Id = model.wantId;
            needOfficeRentDetai.itemTypeId = @"4";
            
            needOfficeRentDetai.hiddenLowView = 26;
            
            [self.navigationController pushViewController:needOfficeRentDetai animated:YES];
            
            break;
        }
        default:
            break;
    }

    
}

#pragma mark - ||==========数据请求===========||

/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.myCustomTableView.mj_header endRefreshing];
    [self.myCustomTableView.mj_footer endRefreshing];
}


-(void)requestGetCollectFinancing:(BOOL)isMore{
    
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
    
    [[HRRequestManager manager] GET_PATH:PATH_GetCollectFinancing para:para success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"success"] boolValue]) {
            
            [weakSelf endRefresh];
            isFirst = NO;
            
            
            [self requestWithFindCollectFinancingListProject:[responseObject objectForKey:@"ds"] isMore:isMore];
        }else{
            
//            NSLog(@"没有数据返回");

        }
   
    } failure:^(NSError *error) {
        
        [weakSelf endRefresh];
        
    }];
    
}

- (void)requestWithFindCollectFinancingListProject:(NSArray *)Arr isMore:(BOOL)isMore
{
    if (!isMore) {
        [self.dataSourceArr removeAllObjects];
    }
    
    if (Arr.count > 0) {
        
        for (NSDictionary *dic in Arr) {
            
            LSGetCollectFinancingList *model = [[LSGetCollectFinancingList alloc] initWithDictionary:dic];
            [self.dataSourceArr addObject:model];
        }
    }else{
//        NSLog(@"没有参数");
    }
    
    
    
    
    [self.myCustomTableView reloadData];
    
}



-(void)requestGetCollectJinRong:(BOOL)isMore{
    
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
    
    [[HRRequestManager manager] GET_PATH:PATH_GetCollectJinRong para:para success:^(id responseObject) {
        
        [weakSelf endRefresh];
        isFirst = NO;

        
        [self requestWithFindCollectJinRongListProject:[responseObject objectForKey:@"ds"] isMore:isMore];
        
    } failure:^(NSError *error) {
        
        [weakSelf endRefresh];
        
    }];
    
    
}

- (void)requestWithFindCollectJinRongListProject:(NSArray *)Arr isMore:(BOOL)isMore
{
    if (!isMore) {
        [self.dataSourceArr removeAllObjects];
    }
    
    
    for (NSDictionary *dic in Arr){
        
        LSGetCollectJinRongList *model = [[LSGetCollectJinRongList alloc] initWithDictionary:dic];
        
        [self.dataSourceArr addObject:model];
        
    }
    
    [self.myCustomTableView reloadData];
    
}


-(void)requestGetCollectRentHouse:(BOOL)isMore{
    
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
    
    [[HRRequestManager manager] GET_PATH:PATH_GetCollectRentHouse para:para success:^(id responseObject) {
        
        [weakSelf endRefresh];
        isFirst = NO;
        
        
        [self requestWithFindCollectRentHouseListProject:[responseObject objectForKey:@"ds"] isMore:isMore];
        
    } failure:^(NSError *error) {
        
        
    }];
    
    
}

- (void)requestWithFindCollectRentHouseListProject:(NSArray *)Arr isMore:(BOOL)isMore
{
    if (!isMore) {
        [self.dataSourceArr removeAllObjects];
    }
    
    for (NSDictionary *dic in Arr) {
        
        LSGetCollectRentHouseList *model = [[LSGetCollectRentHouseList alloc] initWithDictionary:dic];
        
        [self.dataSourceArr addObject:model];
        
    }
    
    [self.myCustomTableView reloadData];
    
}


-(void)requestGetCollectWantHouse:(BOOL)isMore{
    
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
    
    [[HRRequestManager manager] GET_PATH:PATH_GetCollectWantHouse para:para success:^(id responseObject) {
        
        [weakSelf endRefresh];
        
        isFirst = NO;
        
        
        [self requestWithFindCollectWantHouseListProject:[responseObject objectForKey:@"ds"] isMore:isMore];
        
    } failure:^(NSError *error) {
        
        [weakSelf endRefresh];
        
    }];
    
    
}

- (void)requestWithFindCollectWantHouseListProject:(NSArray *)Arr isMore:(BOOL)isMore
{
    if (!isMore) {
        [self.dataSourceArr removeAllObjects];
    }
    
    for (NSDictionary *dic in Arr) {
        
        LSGetCollectWantHouseList *model = [[LSGetCollectWantHouseList alloc] initWithDictionary:dic];
        
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
