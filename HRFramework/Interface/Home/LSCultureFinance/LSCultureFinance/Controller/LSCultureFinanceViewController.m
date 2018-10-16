//
//  LSCultureFinanceViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/21.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSCultureFinanceViewController.h"

#import "LSCultureFinanceCell.h"
#define CELL_CultureFinance  @"CultureFinanceCell"

#import "LSCultureFinanceTopCell.h"
#define CELL_CultureFinanceTop  @"CultureFinanceTopCell"

#import "LSTopButton.h"
#import "LSFinanceProductsView.h"
#import "LSCultureFinanceDetailViewController.h"
#import "LSCultureFinanceProductDetailViewController.h"
#import "LSSearchViewController.h"

#import "LSGetItemJinRongListModel.h"
#import "LSGetItemFinancingListModel.h"
//#import "LSHomeSearchViewController.h"

//#import "MJRefresh.h"


typedef NS_ENUM(NSUInteger, VIEW_STYLE) {
    VIEW_STYLE_ONE,
    VIEW_STYLE_TWO,
};

@interface LSCultureFinanceViewController ()<LSCultureFinanceDetailViewControllerDelegate,LSCultureFinanceProductDetailViewControllerDelegate>
{
     BOOL isFirst;
}

@property (nonatomic, assign)VIEW_STYLE style;

@property (strong, nonatomic) IBOutlet UITableView *topCustomTableView;
@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;
@property (strong, nonatomic) IBOutlet UIView *twoBtnView;

@property (strong, nonatomic) LSFinanceProductsView *financeView;
@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@property (strong, nonatomic) UIButton *selectBtn;
@property (assign, nonatomic) NSInteger beforSelectBtnIndex;
@property (strong, nonatomic) UIButton *twoSelectBtn;
@property (strong, nonatomic) LSCultureFinanceTopCell *selectCell;
@property (assign, nonatomic) NSIndexPath *selectCellIndex;


/**
 *  tableView 数据源
 */
@property (strong, nonatomic) NSMutableArray *dataSourceArr;

@property (strong, nonatomic) NSMutableArray *topDataSourceArr;

@property (copy, nonatomic) NSString *pageNo;

@property (nonatomic, copy)NSString *suoshuHangye;
@property (nonatomic, copy)NSString *city;
@property (nonatomic, copy)NSString *rongziWay;
@property (nonatomic, copy)NSString *moneyStart;
@property (nonatomic, copy)NSString *moneyEnd;
@property (nonatomic, copy)NSString *money;
@property (nonatomic, copy)NSString *totalMoneyStart;
@property (nonatomic, copy)NSString *totalMoneyEnd;


@property (nonatomic, copy)NSString *unitType;
@property (nonatomic, copy)NSString *productType;
@property (nonatomic, copy)NSString *keyword;


@property (nonatomic, strong)NSIndexPath *selectedPath;
@property (strong, nonatomic) IBOutlet LSTopButton *firstBtn;

@property (strong, nonatomic) IBOutlet UIButton *productFirstBtn;

@end

@implementation LSCultureFinanceViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - ||========== LifeCycle ===========||
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = nil;
    self.navigationItem.hidesBackButton = YES;
    
//    [self navigationLeftBarButtonImageNames:@[@"返回"] click:^(NSInteger buttonTag) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
    
    self.selectBtn = self.firstBtn;
    self.twoSelectBtn = self.productFirstBtn;
    
    NSString * row = @"0";

    [UserDefault setObject:row forKey:@"1"];
    [UserDefault synchronize];
    
    [UserDefault setObject:row forKey:@"2"];
    [UserDefault synchronize];
    
    [UserDefault setObject:row forKey:@"3"];
    [UserDefault synchronize];
    
    [UserDefault setObject:row forKey:@"4"];
    [UserDefault synchronize];
    
    [UserDefault setObject:row forKey:@"5"];
    [UserDefault synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:row forKey:@"6"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Do any additional setup after loading the view from its nib.
    self.style = VIEW_STYLE_ONE;
    
    self.selectCellIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    
    self.dataSourceArr = [NSMutableArray array];
    
    self.topDataSourceArr = [NSMutableArray array];
    
    
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSCultureFinanceCell" bundle:nil] forCellReuseIdentifier:CELL_CultureFinance];
    
        [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSCultureFinanceCell" bundle:nil] forCellReuseIdentifier:identifierForProduction];
    
    //注册topCell
    [self.topCustomTableView registerNib:[UINib nibWithNibName:@"LSCultureFinanceTopCell" bundle:nil] forCellReuseIdentifier:CELL_CultureFinanceTop];

    [self.topCustomTableView setTableFooterView:[UIView new]];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = 10;//这个数值可以根据情况自由变化
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"搜索-蓝色"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0,  2, 0, 0);
    
    btn.frame = CGRectMake(0, 0, 37, 36);
    
    [btn addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem = item ;

    
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(BtnClick) image:@"返回" highImage:nil];
    

    [self requestGetItemFinancing:NO];
    
    
    weakSelf(weakSelf);
    
    [self.myCustomTableView.mj_header beginRefreshing];
    
    self.myCustomTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.twoBtnView.hidden == YES) {
            [weakSelf requestGetItemFinancing:NO];
        }else if (self.twoBtnView.hidden == NO){
            [weakSelf requestGetItemJinRong:NO];
        }
        
        
    }];
    
    self.myCustomTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if (self.twoBtnView.hidden == YES) {
            [weakSelf requestGetItemFinancing:YES];
        }else if (self.twoBtnView.hidden == NO){
            [weakSelf requestGetItemJinRong:YES];
        }
        
    }];
    
    [self configUI];
    
}


- (void)configUI {
    
    
    self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self configLeftBarButton];
    
    //设置分段控制器
    [self setSegmentedControl];
    
}
- (void)configLeftBarButton {
    [self navigationLeftBarButtonImageNames:@[@"返回"] click:^(NSInteger buttonTag) {
        NSLog(@"dahjkda");
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
}

-(void)BtnClick{
    NSLog(@"搜索搜索搜索搜索搜索搜索搜索搜索搜索");
    
    LSSearchViewController *searchVC = [[LSSearchViewController alloc] initWithNibName:@"LSSearchViewController" bundle:nil];
    /*
     GetItemFinancing  八、	查询融资需求
     GetSyqdt          四、	查询实验区动态（列表）
     GetItemJinRong    六、	查询文化金融（列表）
     PATH_GetItemRentHouse  十、	查询办公空间出租（列表）
     PATH_GetItemWantHouse 十二、	查询办公空间求租（列表）
     PATH_GetArticle  十四、	查询政策资讯（列表）
     */
    if (self.twoBtnView.hidden) {
        searchVC.type = @"1";//融资需求
    } else {
    
        searchVC.type = @"2";//金融产品
    }
    
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void)setSegmentedControl{
    
    self.segmentedControl = [[UISegmentedControl alloc ] initWithItems:nil];
    [ self.segmentedControl insertSegmentWithTitle:
     @"融资需求" atIndex: 0 animated: NO ];
    [ self.segmentedControl insertSegmentWithTitle:
     @"金融产品" atIndex: 1 animated: NO ];
    //默认选中的按钮索引
    self.segmentedControl.selectedSegmentIndex = 0;
    
    self.navigationItem.titleView = self.segmentedControl;
    
    [self.segmentedControl addTarget: self
                              action: @selector(controllerPressed:)
                    forControlEvents: UIControlEventValueChanged
     ];
}

#pragma mark - ||========== IBActions ===========||
- (IBAction)ButtonAction:(UIButton *)sender {

    
    UIButton *btn =(UIButton *)sender;

    
    if ([self.selectBtn isEqual:btn]) {
        [self.topCustomTableView setHidden:!self.topCustomTableView.isHidden];
        [btn setSelected:YES];
    }else {
        [self.topCustomTableView setHidden:NO];
        [self.selectBtn setSelected:NO];
        self.selectBtn = btn;
        [self.selectBtn setSelected:YES];
    }
    
    if (!self.topCustomTableView.hidden) {
        switch (self.selectBtn.tag) {
            case 1:
            {
                NSLog(@"所属行业所属行业所属行业所属行业所属行业所属行业");
                self.topDataSourceArr = [@[@"全部",@"文化艺术服务",@"新闻出版及发行服务",@"广播电视电影服务",@"软件和信息技术服务",@"广告和会展服务",@"艺术品生产与销售服务",@"设计服务",@"文化休闲娱乐服务",@"文化用品设备生产销售及其他辅助服务"] mutableCopy];
                
                NSString *row = [[NSUserDefaults standardUserDefaults] objectForKey:@"1"];
                NSIndexPath *path = [NSIndexPath indexPathForRow:[row integerValue] inSection:0];
                self.selectedPath = path;
                break;
            }

            case 2:
            {NSLog(@"总投资额总投资额总投资额总投资额");
                
                self.topDataSourceArr = [@[@"全部",@"1000万以下",@"1000-3000万",@"3000-5000万",@"5000-1亿",@"1亿以上"] mutableCopy];
                
                NSString *row = [[NSUserDefaults standardUserDefaults] objectForKey:@"2"];
                NSIndexPath *path = [NSIndexPath indexPathForRow:[row integerValue] inSection:0];
            self.selectedPath = path;}
        
                break;
            case 3:
            {NSLog(@"融资方式融资方式融资方式融资方式融资方式融资方式");
                self.topDataSourceArr = [@[@"全部",@"债权融资",@"股权融资",@"信托融资",@"银行贷款",@"小额贷款",@"整体转让",@"其他融资"] mutableCopy];
                
                NSString *row = [[NSUserDefaults standardUserDefaults] objectForKey:@"3"];
                NSIndexPath *path = [NSIndexPath indexPathForRow:[row integerValue] inSection:0];
                self.selectedPath = path;}
                break;
            case 4:
            {
                NSLog(@"融资金额融资金额融资金额融资金额融资金额融资金额");
                self.topDataSourceArr = [@[@"全部",@"100万以下",@"100-500万",@"500-1000万",@"1000-3000万",@"3000万以上"] mutableCopy];
                NSString *row = [[NSUserDefaults standardUserDefaults] objectForKey:@"4"];
                NSIndexPath *path = [NSIndexPath indexPathForRow:[row integerValue] inSection:0];
                self.selectedPath = path;
            }
                break;
                
            default:
                break;
        }
        
        
        [self.topCustomTableView reloadData];
    }

}


- (IBAction)TwoBtnAction:(UIButton *)sender {
    
    UIButton *btn =(UIButton *)sender;
    
    
    if ([self.twoSelectBtn isEqual:btn]) {
        [self.topCustomTableView setHidden:!self.topCustomTableView.isHidden];
        [btn setSelected:YES];
    }else {
        [self.topCustomTableView setHidden:NO];
        [self.twoSelectBtn setSelected:NO];
        self.twoSelectBtn = btn;
        [self.twoSelectBtn setSelected:YES];
    }

    
    if (!self.topCustomTableView.hidden) {
        
        switch (self.twoSelectBtn.tag) {
            case 5:{
                NSLog(@"机构类型机构类型机构类型机构类型机构类型");
                self.topDataSourceArr = [@[@"全部",@"商业银行",@"信托公司",@"担保公司",@"小额贷款公司",@"风投机构",@"其他投资公司",@"其他"] mutableCopy];
                
                NSString *row = [[NSUserDefaults standardUserDefaults] objectForKey:@"5"];
                NSIndexPath *path = [NSIndexPath indexPathForRow:[row integerValue] inSection:0];
                self.selectedPath = path;

                
                break;
            }
            case 6:{
                NSLog(@"产品类型产品类型产品类型产品类型产品类型");
                self.topDataSourceArr = [@[@"全部",@"信贷产品",@"担保品",@"债券",@"信托产品",@"小额贷产品",@"融资租赁",@"私募股权",@"基金",@"互联网金融"] mutableCopy];
                
                NSString *row = [[NSUserDefaults standardUserDefaults] objectForKey:@"6"];
                NSIndexPath *path = [NSIndexPath indexPathForRow:[row integerValue] inSection:0];
                self.selectedPath = path;
                
                break;
            }
            default:
                break;
        }
        
        [self.topCustomTableView reloadData];
    }
    
    
}

#pragma mark @ UITableViewDataSource && UITableViewDelegate @
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.topCustomTableView) {
        return self.topDataSourceArr.count;
    }
    
    if (tableView == self.myCustomTableView) {
        return self.dataSourceArr.count;
    }
    
    return 0;
}


//返回cell高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (tableView == self.topCustomTableView) {
        self.topCustomTableView.estimatedRowHeight = self.topCustomTableView.rowHeight;
        self.topCustomTableView.rowHeight = UITableViewAutomaticDimension;
        return self.topCustomTableView.rowHeight;
//        return 10;
    }
    
    if (tableView == self.myCustomTableView) {
        
        self.myCustomTableView.estimatedRowHeight = self.myCustomTableView.rowHeight;
        self.myCustomTableView.rowHeight = UITableViewAutomaticDimension;
        return self.myCustomTableView.rowHeight;
        
    }
    
    return 0;
    
}

NSString *identifierForProduction = @"indentifierForProduction";

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.topCustomTableView.hidden == YES) {
        
        LSCultureFinanceCell *cell = nil;
        
        if (self.twoBtnView.hidden) {
            
            cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_CultureFinance forIndexPath:indexPath];
            cell.rongzizhutiLabel.text = @"融资主体：";
            
            [cell buildingGetItemFinancingWithModel:self.dataSourceArr[indexPath.row]];
            
        }else if (!self.twoBtnView.hidden){
            
            cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:identifierForProduction forIndexPath:indexPath];
            
            cell.rongzizhutiLabel.text = @"发行单位：";
            
            NSLog(@"%d", [[self.dataSourceArr[indexPath.row] unit] length] == 0);
            
            [cell buildingGetItemJinRongWithModel:self.dataSourceArr[indexPath.row]];
            
        }
        
        //去掉分割线
        self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        return cell;

    }else if (self.topCustomTableView.hidden == NO){
        
         LSCultureFinanceTopCell *cell = [self.topCustomTableView dequeueReusableCellWithIdentifier:CELL_CultureFinanceTop forIndexPath:indexPath];
        
        cell.nameLabel.text = self.topDataSourceArr[indexPath.row];
        
//        cell.nameLabel.font = [UIFont systemFontOfSize:12];
        
        
        //去掉分割线
        self.topCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        //cell点击变色
        
        [cell changeSelectedState:[self.selectedPath isEqual:indexPath]];
        
        return cell;
    }

    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.topCustomTableView.hidden == YES) {
        
        if (self.twoBtnView.hidden) {
            
            LSGetItemFinancingListModel *model = self.dataSourceArr[indexPath.row];
            
            LSCultureFinanceDetailViewController *detailVC = [[LSCultureFinanceDetailViewController alloc] initWithNibName:@"LSCultureFinanceDetailViewController" bundle:nil];
            
            
            
            detailVC.Id = model.financingId;
            detailVC.itemTypeId = @"2";
            detailVC.userId = model.userId;
            
            detailVC.delegate = self;
            
            
            NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
            NSString *userId = [userdefault objectForKey:@"userId"];
            
            if ([model.userId isEqualToString:userId]) {
                detailVC.isHidden = 145;
            }
            
            
            [self.navigationController pushViewController:detailVC animated:YES];
        }else if (!self.twoBtnView.hidden){
            
            LSGetItemJinRongListModel *model = self.dataSourceArr[indexPath.row];
            
            LSCultureFinanceProductDetailViewController *productDetailVC = [[LSCultureFinanceProductDetailViewController alloc] initWithNibName:@"LSCultureFinanceProductDetailViewController" bundle:nil];
            
            productDetailVC.Id = model.jinrongId;
            productDetailVC.itemTypeId = @"1";
            productDetailVC.userId = model.userId;
            
            productDetailVC.delegate = self;
            
            NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
            NSString *userId = [userdefault objectForKey:@"userId"];
            
            if ([model.userId isEqualToString:userId]) {
                productDetailVC.isHidden = 145;
            }
            

            [self.navigationController pushViewController:productDetailVC animated:YES];
            
        }
        
        
    }else if (self.topCustomTableView.hidden == NO){
        
        
        if (self.twoBtnView.hidden) {
            
            switch (self.selectBtn.tag) {
                case 1:{
                    NSLog(@"所属行业所属行业所属行业所属行业所属行业所属行业");
                    if (indexPath.row == 0) {
                        self.suoshuHangye = @"";
                    }else{
                        self.suoshuHangye = self.topDataSourceArr[indexPath.row];
                    }
                    
                    
                    NSString *row = [NSString stringWithFormat:@"%ld",indexPath.row];
                    [[NSUserDefaults standardUserDefaults] setObject:row forKey:@"1"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
//                    [[NSUserDefaults standardUserDefaults] setObject:indexPath forKey:@"LSCulture_Four"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];

                    
                    break;
                }
                case 2:{
                    NSLog(@"总投资额");
                    
                    switch (indexPath.row) {
                        case 0:{
                            self.totalMoneyStart = @"";
                            self.totalMoneyEnd = @"";
                        }
                            break;
                        case 1:{
                            self.totalMoneyStart=@"0";
                            self.totalMoneyEnd=@"1000";
                        }
                            break;
                        case 2:{
                            self.totalMoneyStart=@"1000";
                            self.totalMoneyEnd=@"3000";
                        }
                            break;
                        case 3:{
                            self.totalMoneyStart=@"3000";
                            self.totalMoneyEnd=@"5000";
                        }
                            break;
                        case 4:{
                            
                            self.totalMoneyStart=@"5000";
                            self.totalMoneyEnd=@"10000";
                        }
                            break;
                        case 5:{
                            self.totalMoneyStart=@"10000";
                            self.totalMoneyEnd=@"0";
                        }
                            break;

                            
                        default:
                            break;
                    }
                    
                    
//                    if (indexPath.row == 0) {
//                        self.city = @"";
//                    }else{
//                        self.city = self.topDataSourceArr[indexPath.row];
//                    }
                    
                    
                    NSString *row = [NSString stringWithFormat:@"%ld",indexPath.row];
                    [[NSUserDefaults standardUserDefaults] setObject:row forKey:@"2"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    
                    break;
                }
                case 3:{
                    NSLog(@"融资方式融资方式融资方式融资方式融资方式融资方式");
                    if (indexPath.row == 0) {
                        self.rongziWay = @"";
                    }else{
                        self.rongziWay = self.topDataSourceArr[indexPath.row];
                    }
                    
                    NSString *row = [NSString stringWithFormat:@"%ld",indexPath.row];
                    [[NSUserDefaults standardUserDefaults] setObject:row forKey:@"3"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
//                    [[NSUserDefaults standardUserDefaults] setObject:indexPath forKey:@"LSCulture_Three"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];

                    
                    break;
                }
                case 4:{
                    NSLog(@"融资金额融资金额融资金额融资金额融资金额融资金额");
                    if (indexPath.row == 0) {
                        self.moneyStart = @"";
                        self.moneyEnd = @"";
                    }else{
                        self.money = self.topDataSourceArr[indexPath.row];
                        
                        if (indexPath.row >=2 && indexPath.row <=4) {
                            NSArray *numArr = [self.money componentsSeparatedByString:@"-"];
                            
                            NSString *placeStr = numArr[1];
                            
                            NSString *lastNum = [placeStr substringToIndex:placeStr.length - 1];
                            
                            
                            NSString *firstNum = numArr[0];
                            
                            self.moneyStart = firstNum;
                            self.moneyEnd = lastNum;
                            NSLog(@"#$#$#$#$#$#$#$#$#$#$#%@",firstNum);
                            
                            
                            
                        }else if (indexPath.row == 5){
                            
                            NSString *num = [self.money substringToIndex:4];
                            self.moneyStart = num;
                            self.moneyEnd = @"";
                            
                        }else if (indexPath.row == 1){
                            
                            NSString *num = [self.money substringToIndex:3];
                            self.moneyStart = @"";
                            self.moneyEnd = num;
                            
                        }

                        
                        
                    }
                    
                    NSString *row = [NSString stringWithFormat:@"%ld",indexPath.row];
                    [[NSUserDefaults standardUserDefaults] setObject:row forKey:@"4"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
//                    [[NSUserDefaults standardUserDefaults] setObject:indexPath forKey:@"LSCulture_Four"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];

                    
                    break;
                }
                    
                default:
                    break;
            }
            
            
            [self requestGetItemFinancing:NO];
            
            self.topCustomTableView.hidden = YES;
            
        }
        else {
            
            switch (self.twoSelectBtn.tag) {
                case 5:{
                    NSLog(@"机构类型机构类型机构类型机构类型机构类型");
                    if (indexPath.row == 0) {
                        self.unitType = @"";
                    }else{
                        self.unitType = self.topDataSourceArr[indexPath.row];
                    }
                    
                    NSString *row = [NSString stringWithFormat:@"%ld",indexPath.row];
                    [[NSUserDefaults standardUserDefaults] setObject:row forKey:@"5"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    break;
                }
                case 6:{
                    NSLog(@"产品类型产品类型产品类型产品类型产品类型");
                    
                    if (indexPath.row == 0) {
                        self.productType = @"";
                    }else{
                        self.productType = self.topDataSourceArr[indexPath.row];
                    }
                    
                    NSString *row = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
                    [[NSUserDefaults standardUserDefaults] setObject:row forKey:@"6"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    break;
                }
                    
                default:
                    break;
            }
            
            [self requestGetItemJinRong:NO];
            
            self.topCustomTableView.hidden = YES;
            
        }

    }
    
}


#pragma mark - ||========= 代理方法 =========||
//四个详情页面的代理方法,用来刷新数据

-(void)requestMoreData{
    [self requestGetItemFinancing:NO];
    //LSCultureFinanceDetailViewController
}

-(void)requestMoreDataCultureFinanceProductDetailViewController{
    //CultureFinanceProductDetailViewController
    [self requestGetItemJinRong:NO];
}



#pragma mark - ||========= PrivateMethods =========||

- (void) controllerPressed:(id)sender {
    NSInteger selectedSegment = self.segmentedControl.selectedSegmentIndex;

    
    if (selectedSegment == 1) {
        
        self.topCustomTableView.hidden = YES;
        
        if (self.twoBtnView.hidden) {
            self.twoBtnView.hidden = NO;
//            self.selectBtn = self.firstBtn;
            self.productFirstBtn.selected = YES;
            self.twoSelectBtn = self.productFirstBtn;
            
            [self requestGetItemJinRong:NO];
            
        }
        
    }else {
        
        self.topCustomTableView.hidden = YES;
        
        if (!self.twoBtnView.hidden) {
            
            self.twoBtnView.hidden = YES;
            [self requestGetItemFinancing:NO];
        }
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



-(void)requestGetItemJinRong:(BOOL)isMore {
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    [para setObject:@"0" forKey:@"pageNo"];
    [para setObject:@"10" forKey:@"pageSize"];
    
    if (self.unitType) {
        
        [para setObject:self.unitType forKey:@"unitType"];
    }
    if (self.productType) {
        [para setObject:self.productType forKey:@"productType"];
    }
    if (self.keyword) {
        [para setObject:self.rongziWay forKey:@"keyword"];
    }
    if (self.dataSourceArr.count % 10 == 0)
    {
        [para setObject:isMore ? [NSString stringWithFormat:@"%lu",(long)self.dataSourceArr.count/10+1 ] : @"1" forKey:@"pageNo"] ;
    }
    else
    {
        
        [para setObject:isMore ? [NSString stringWithFormat:@"%lu",self.dataSourceArr.count/10+2] :@"1" forKey:@"pageNo"];
    }

    
    weakSelf(weakSelf);
    
    
    [[HRRequestManager manager] GET_PATH:GetItemJinRong para:para success:^(id responseObject) {
        
        [weakSelf endRefresh];
        isFirst = NO;
        
        
        [self requestWithFindJinRongListModelProject:[responseObject objectForKey:@"ds"] isMore:isMore];
        
    } failure:^(NSError *error) {
        
        [weakSelf endRefresh];
        
    }];
    
}

- (void)requestWithFindJinRongListModelProject:(NSArray *)Arr isMore:(BOOL)isMore
{
    if (!isMore) {
        [self.dataSourceArr removeAllObjects];
    }
    
    for (NSDictionary *dic in Arr) {
        
        LSGetItemJinRongListModel *model = [[LSGetItemJinRongListModel alloc] initWithDictionary:dic];
        
        [self.dataSourceArr addObject:model];
    }
    
    [self.myCustomTableView reloadData];

    
}


-(void)requestGetItemFinancing:(BOOL)isMore{
    
    
//    NSString *moneyStr = self.moneyStart;
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    [para setObject:@"0" forKey:@"pageNo"];
    [para setObject:@"10" forKey:@"pageSize"];
    
    if (self.suoshuHangye) {
        [para setObject:self.suoshuHangye forKey:@"suoshuHangye"];
    }
//    if (self.city) {
//        [para setObject:self.city forKey:@"city"];
//    }
    if(self.totalMoneyStart && self.totalMoneyEnd){
        [para setObject:self.totalMoneyStart forKey:@"totalMoneyStart"];
        [para setObject:self.totalMoneyEnd forKey:@"totalMoneyEnd"];
    }
    
    if (self.rongziWay) {
        [para setObject:self.rongziWay forKey:@"rongziWay"];
    }
    if (self.moneyStart) {
        [para setObject:self.moneyStart forKey:@"moneyStart"];
    }
    if(self.moneyEnd){
        [para setObject:self.moneyEnd forKey:@"moneyEnd"];
    }
    
  
    
    if (self.dataSourceArr.count % 10 == 0)
    {
        [para setObject:isMore ? [NSString stringWithFormat:@"%lu",(long)self.dataSourceArr.count/10+1 ] : @"1" forKey:@"pageNo"] ;
    }
    else
    {

        [para setObject:isMore ? [NSString stringWithFormat:@"%lu",self.dataSourceArr.count/10+2] :@"1" forKey:@"pageNo"];
    }
    
       if (self.moneyEnd) {
        
        [para setObject:self.moneyEnd forKey:@"moneyEnd"];
    }
    
    weakSelf(weakSelf);
    
    [[HRRequestManager manager] GET_PATH:GetItemFinancing para:para success:^(id responseObject) {
        
        [weakSelf endRefresh];
        isFirst = NO;

        
        [self requestWithFindFinancingListModelProject:[responseObject objectForKey:@"ds"] isMore:isMore];
        

    } failure:^(NSError *error) {
        
        [weakSelf endRefresh];
    }];
}

- (void)requestWithFindFinancingListModelProject:(NSArray *)Arr isMore:(BOOL)isMore
{
    if (!isMore) {
//        self.selectCell.img.hidden = YES;
        [self.dataSourceArr removeAllObjects];
    }
    
    for (NSDictionary *dic in Arr) {
        
        LSGetItemFinancingListModel *model = [[LSGetItemFinancingListModel alloc] initWithDictionary:dic];
        
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
