//
//  LSNeedOfficeRentDetaiViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSNeedOfficeRentDetaiViewController.h"

#import "LSCultureFinanceDetailCell.h"
#define CELL_CultureFinanceDetail  @"CultureFinanceDetailCell"

#import "LSNeedOfficeRentDetailHeader.h"
#import "LSGetItemWantHouseModel.h"

#import "LSSendAppointmentViewController.h"

@interface LSNeedOfficeRentDetaiViewController ()<UITableViewDelegate,UITableViewDataSource,LSNeedOfficeRentDetailHeaderDelegate>
{
    UIAlertView *alertView;
}


@property (strong, nonatomic) LSNeedOfficeRentDetailHeader *needRentHeader;
@property (strong, nonatomic) NSMutableArray *dataSourceArr;

@property (strong, nonatomic) NSArray *nameArr;

//下方约谈视图

@property (weak, nonatomic) IBOutlet UIView *lowView;

//下方两个按钮状态

@property (weak, nonatomic) IBOutlet UIButton *yuetan;

@property (weak, nonatomic) IBOutlet UIButton *collection;

@property (assign, nonatomic) NSInteger collectionNumber;

//被收藏的数量
@property (assign, nonatomic) NSInteger collectionCount;

@property (assign, nonatomic) BOOL isC;

//补充 tableView
@property (strong, nonatomic) UITableView *customTableView;

@end

@implementation LSNeedOfficeRentDetaiViewController

#pragma mark - ||========== Lazy loading ===========||

-(UITableView *)customTableView{
    
    if (!_customTableView) {
        if (self.hiddenLowView != 0) {
            _customTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
            [self.lowView setHidden:YES];
        }else{
            _customTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.lowView.frame.size.height - 64) style:UITableViewStylePlain];
            [self.lowView setHidden:NO];
        }
    }
    return _customTableView;
}

-(LSNeedOfficeRentDetailHeader *)needRentHeader{
    if (!_needRentHeader) {
//        _needRentHeader = [[[NSBundle mainBundle] loadNibNamed:@"LSNeedOfficeRentDetailHeader" owner:nil options:nil]firstObject];
       
        _needRentHeader = [[LSNeedOfficeRentDetailHeader alloc] init];
        
    }
    
        _needRentHeader.delegate = self;
    
    return _needRentHeader;
}

#pragma mark - ||========== LifeCycle ===========||
// 视图加载完毕
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.customTableView];
    self.customTableView.delegate = self;
    self.customTableView.dataSource = self;
    
    
    [self requestNumberOfCollection];
    
    
    //设置标题以及注册cell
    self.title = @"办公求租详情";
    
    self.nameArr = @[@"配套",@"交通",@"求租企业简介",@"备注"];
    
    self.dataSourceArr = [NSMutableArray array];
    
    //注册cell
    [self.customTableView registerNib:[UINib nibWithNibName:@"LSCultureFinanceDetailCell" bundle:nil] forCellReuseIdentifier:CELL_CultureFinanceDetail];
    
    self.customTableView.tableHeaderView = self.needRentHeader;
    NSLog(@"%f",self.needRentHeader.height);
    
    [self requestGetItemWantHouseModel];
    alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                          message:nil
                                         delegate:nil
                                cancelButtonTitle:@"确定"
                                otherButtonTitles:nil];
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



#pragma mark - ||========== IBActions ===========||


//收藏
-(void)CollectedItem{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    
    [para setObject:userId forKey:@"userId"];
    [para setObject:self.Id forKey:@"itemId"];
    [para setObject:self.itemTypeId forKey:@"itemTypeId"];
    
    [[HRRequestManager manager] GET_PATH:PATH_JoinCollect para:para success:^(id responseObject) {
        
        if ([responseObject[@"success"] boolValue] == 1) {
            
            //            [alertView setTitle:@"收藏成功"];
            //            [alertView show];
            NSLog(@"收藏成功");
        } else {
            [alertView setTitle:@"收藏失败"];
            [alertView show];
        }
    } failure:^(NSError *error) {
        [alertView setTitle:@"收藏失败"];
        [alertView show];
    }];
    
    
}

//取消
-(void)cancelCollection{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    
    [para setObject:userId forKey:@"userId"];
    [para setObject:self.Id forKey:@"itemId"];
    [para setObject:self.itemTypeId forKey:@"itemTypeId"];
    
    [[HRRequestManager manager] GET_PATH:PATH_CancelCollect para:para success:^(id responseObject) {
        
        if ([responseObject[@"success"] boolValue] == 1) {
            
            NSLog(@"取消成功");
            
        } else {
            [alertView setTitle:@"取消失败"];
            [alertView show];
        }
    } failure:^(NSError *error) {
        [alertView setTitle:@"取消失败"];
        [alertView show];
    }];
    
}

- (IBAction)collectionAction:(id)sender {
    
    self.isC = !self.isC;
    
    self.collection.selected = self.isC;
    
    if (self.isC == YES) {
        [self.collection setTitle:@"已收藏" forState:UIControlStateNormal];
        
        [self CollectedItem];
    }else{
        NSString *title = [NSString stringWithFormat:@"收藏(%zd)",self.collectionCount];
        [self.collection setTitle:title forState:UIControlStateNormal];
        [self cancelCollection];
    }

    
}

//请求被收藏的次数 并且 改变UI
-(void)requestNumberOfCollection{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    
    [para setObject:userId forKey:@"userId"];
    [para setObject:self.Id forKey:@"itemId"];
    [para setObject:self.itemTypeId forKey:@"itemTypeId"];
    
    [[HRRequestManager manager]POST_PATH:PATH_isHaveCollected para:para success:^(id responseObject) {
        
        if ([responseObject[@"success"] isEqualToString:@"1"]) {
            
            NSDictionary *dsDict = responseObject[@"ds"];
            //可查询收藏数量 count
            self.collectionNumber = [dsDict[@"isCollect"] integerValue];

            self.collectionCount = [dsDict[@"count"] integerValue];
            
            [self.collection setTitle:@"已收藏" forState:UIControlStateNormal];
            
            self.isC = YES;
            self.collection.selected = self.isC;
            
            if (self.collectionNumber == 0) {
                NSLog(@"没有被收藏");
                //取出已经被收藏的次数
                NSString *title = [NSString stringWithFormat:@"收藏(%zd)",self.collectionCount];
                [self.collection setTitle:title forState:UIControlStateNormal];
                
                self.isC = NO;
                self.collection.selected = self.isC;
            }else{
            }
        }else{
            NSLog(@"请求失败");
            
        }
    } failure:^(NSError *error) {
    }];
}

#pragma mark @ UITableViewDataSource && UITableViewDelegate @
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.dataSourceArr.count) {
        return self.dataSourceArr.count;
    }else{
        return self.nameArr.count;
    }
    
    return 0;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 84;
//}

//返回cell高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.customTableView.estimatedRowHeight = self.customTableView.rowHeight;
    self.customTableView.rowHeight = UITableViewAutomaticDimension;
    return self.customTableView.rowHeight + 49;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSCultureFinanceDetailCell *cell = [self.customTableView dequeueReusableCellWithIdentifier:CELL_CultureFinanceDetail forIndexPath:indexPath];
    
    cell.nameLabel.text = self.nameArr[indexPath.row];
    
    if (self.dataSourceArr.count>0) {
        cell.contentLabel.text = self.dataSourceArr[indexPath.row];
    }else{
        
        cell.contentLabel.text = @"";
    }
    
    
    
    //去掉分割线
    self.customTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //cell点击变色
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"点击cell");
}


//约谈按钮点击事件

- (IBAction)appointmentBtn:(UIButton *)sender {

        LSSendAppointmentViewController *sendVC = [[LSSendAppointmentViewController alloc]initWithNibName:@"LSSendAppointmentViewController" bundle:nil];
        
        NSMutableDictionary *paraDict =[NSMutableDictionary dictionary];
        [paraDict setObject:self.Id forKey:@"itemId"];
        [paraDict setObject:self.itemTypeId forKey:@"itemTypeId"];
        [paraDict setObject:self.userId forKey:@"toUserId"];
        
        sendVC.paraDict = paraDict;
        
        [self.navigationController pushViewController:sendVC animated:YES];
}


#pragma mark - ||==========代理方法===========||

-(void)updateData{
    
    self.customTableView.tableHeaderView = self.needRentHeader;
    
    [self.customTableView  reloadData];
}



#pragma mark - ||==========数据请求===========||
-(void)requestGetItemWantHouseModel{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:self.Id forKey:@"Id"];
    
    weakSelf(weakSelf);
    
    [[HRRequestManager manager] GET_PATH:PATH_GetItemWantHouseModel para:para success:^(id responseObject) {
        
        [weakSelf.dataSourceArr removeAllObjects];
        
        
        if ([responseObject[@"success"] integerValue] == 1) {
            
            NSDictionary *data = [responseObject objectForKey:@"ds"];
            
            LSGetItemWantHouseModel *model = [[LSGetItemWantHouseModel alloc] initWithDictionary:data];
            
            [self.needRentHeader buildingWithModel:model];
            
            [self.dataSourceArr addObject:model.peitaoSheshi];
            [self.dataSourceArr addObject:model.jiaotong];
            [self.dataSourceArr addObject:model.companyRemark];
            [self.dataSourceArr addObject:model.remark];
            
            [weakSelf.customTableView  reloadData];
        }else{
            [self promptBox_YTC_GeneralWithWords:responseObject[@"errMsg"]];
        }
        
        
        
    } failure:^(NSError *error) {
        
        
    }];
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    if ([self.delegate respondsToSelector:@selector(requestMoreDataNeedOfficeRentDetaiViewController)]) {
        [self.delegate requestMoreDataNeedOfficeRentDetaiViewController];
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
