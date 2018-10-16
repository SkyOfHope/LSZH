
//
//  LSOfficeRentViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/23.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSOfficeRentViewController.h"

#import "LSOfficeRentCell.h"
#define CELL_OfficeRent  @"OfficeRentCell"

#import "LSNeedOfficeRentCell.h"
#define CELL_NeedOfficeRent  @"NeedOfficeRentCell"

#import "LSCultureFinanceTopCell.h"
#define CELL_CultureFinanceTop  @"CultureFinanceTopCell"



#import "LSOfficeRentDetailViewController.h"
//#import "LSNeedOfficeRentViewController.h"
#import "LSNeedOfficeRentDetaiViewController.h"
#import "LSSearchViewController.h"

#import "LSGetItemRentHouseListModel.h"
#import "LSGetItemWantHouseListModel.h"

#import "LSGetItemRentHouseTJModel.h"
#import "LSGetItemWantHouseTJModel.h"


#import "LSOfficeRentSizeView.h"
#import "LSOfficeRentMoneyView.h"
#import "LSOfficeRentStartDateView.h"


typedef NS_ENUM(NSUInteger, CELL_STYLE) {
    CELL_STYLE_ONE,
    CELL_STYLE_TWO,
};


@interface LSOfficeRentViewController ()<LSOfficeRentStartDateViewDelegate, LSOfficeRentMoneyViewDelegate,LSOfficeRentSizeViewDelegate,LSNeedOfficeRentDetaiViewControllerDelegate,LSOfficeRentDetailViewControllerDelegate>
{
    BOOL isFirst;
}

@property (strong, nonatomic) LSOfficeRentSizeView *officeRentSizeView;
@property (strong, nonatomic) LSOfficeRentMoneyView *officeRentMoneyView;
@property (strong, nonatomic) LSOfficeRentStartDateView *officeRentStartDateView;

@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;
@property (strong, nonatomic) IBOutlet UITableView *topCustomTableView;

@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@property (strong, nonatomic) UIButton *selectBtn;
@property (nonatomic, assign) CELL_STYLE style;

@property (strong, nonatomic) NSMutableArray *dataSourceArr;

@property (strong, nonatomic) NSMutableArray *dataSourceArrTJ;

@property (strong, nonatomic) NSMutableArray *topDataSourceArr;


@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSString *sizeStart;
@property (copy, nonatomic) NSString *sizeEnd;
@property (copy, nonatomic) NSString *rizujinStart;
@property (copy, nonatomic) NSString *rizujinEnd;
@property (copy, nonatomic) NSString *qizuDate;


@property (nonatomic, strong)NSIndexPath *selectedPath;

@end

@implementation LSOfficeRentViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - ||========== LifeCycle ===========||
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString * row = @"0";
    [[NSUserDefaults standardUserDefaults] setObject:row forKey:@"1"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    

    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIExtended

    
    self.style = CELL_STYLE_ONE;
    
    self.dataSourceArr = [NSMutableArray array];

    self.dataSourceArrTJ = [NSMutableArray array];
    
    self.topDataSourceArr = [NSMutableArray array];
    
    //设置导航搜索按钮
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                  target:nil action:nil];
    negativeSpacer.width = 10;//这个数值可以根据情况自由变化
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"搜索-蓝色"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0,  2, 0, 0);
    
    btn.frame = CGRectMake(0, 0, 37, 36);
    
    [btn addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    
//    self.navigationItem.rightBarButtonItem = item;
    self.navigationItem.rightBarButtonItem = item ;
    
    
    self.segmentedControl = [ [ UISegmentedControl alloc ] initWithItems:nil];
    [ self.segmentedControl insertSegmentWithTitle:
     @"办公出租" atIndex: 0 animated: NO ];
    [ self.segmentedControl insertSegmentWithTitle:
     @"办公求租" atIndex: 1 animated: NO ];
    //默认选中的按钮索引
    self.segmentedControl.selectedSegmentIndex = 0;
    
    self.navigationItem.titleView = self.segmentedControl;
    
    [self.segmentedControl addTarget: self
                              action: @selector(controllerPressed:)
                    forControlEvents: UIControlEventValueChanged
     ];

    
    //注册cell-one
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSOfficeRentCell" bundle:nil] forCellReuseIdentifier:CELL_OfficeRent];
    //注册cell-two
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSNeedOfficeRentCell" bundle:nil] forCellReuseIdentifier:CELL_NeedOfficeRent];
    
    //注册topCell
    [self.topCustomTableView registerNib:[UINib nibWithNibName:@"LSCultureFinanceTopCell" bundle:nil] forCellReuseIdentifier:CELL_CultureFinanceTop];
    
    [self requestGetItemRentHouseTJ:NO];
    [self requestGetItemRentHouse:NO];
    
    weakSelf(weakSelf);
    
    [self.myCustomTableView.mj_header beginRefreshing];
    
    self.myCustomTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.style == CELL_STYLE_ONE) {
            
            [weakSelf requestGetItemRentHouseTJ:NO];
            [weakSelf requestGetItemRentHouse:NO];
            
        }else if (self.style == CELL_STYLE_TWO){
            
            [weakSelf requestGetItemWantHouseTJ:NO];
            [weakSelf requestGetItemWantHouse:NO];
            
        }
        
        
    }];
    
    self.myCustomTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if (self.style == CELL_STYLE_ONE) {
            [weakSelf requestGetItemRentHouse:YES];
        }else if (self.style == CELL_STYLE_TWO){
            [weakSelf requestGetItemWantHouse:YES];
        }
        
    }];
    
    [self configUI];
    
}

- (void)configUI {
    
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
    
     UIButton *btn =(UIButton *)sender;
    
    if (sender.tag == 1) {
        
        if ([self.selectBtn isEqual:btn]) {
            [self.topCustomTableView setHidden:!self.topCustomTableView.isHidden];
            [btn setSelected:YES];
        }else {
            [self.topCustomTableView setHidden:NO];
            [self.selectBtn setSelected:NO];
            self.selectBtn = btn;
            [self.selectBtn setSelected:YES];
            
        }

        NSLog(@"地理位置地理位置地理位置地理位置地理位置地理位置");
        
        //            self.topCustomTableView.hidden = NO;
        self.topDataSourceArr = [@[@"全部",@"朝阳门",@"东大桥",@"国贸",@"CBD",@"大望路",@"双井",@"八里庄",@"十里堡",@"青年路",@"定福庄",@"双桥",@"常营",@"管庄",@"其他"] mutableCopy];
        
        NSString *row = [[NSUserDefaults standardUserDefaults] objectForKey:@"1"];
        NSIndexPath *path = [NSIndexPath indexPathForRow:[row integerValue] inSection:0];
        self.selectedPath = path;
        
        [self.topCustomTableView reloadData];
//        [self.myCustomTableView reloadData];
        
    }
    else{
        
        
        if ([self.selectBtn isEqual:btn]) {
            [self.topCustomTableView setHidden:!self.topCustomTableView.isHidden];
            [btn setSelected:YES];
        }else {
            [self.topCustomTableView setHidden:NO];
            [self.selectBtn setSelected:NO];
            self.selectBtn = btn;
            [self.selectBtn setSelected:YES];
            
        }

        
        switch (sender.tag) {
            case 2:{
                NSLog(@"面积面积面积面积面积");
                
                self.officeRentSizeView = [[LSOfficeRentSizeView alloc]init];
                
                self.officeRentSizeView.start = self.sizeStart;
                self.officeRentSizeView.end = self.sizeEnd;
                
                
                self.officeRentSizeView.delegate = self;
                
                self.officeRentSizeView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
                //    self.alertView.backgroundColor = RGBColor(0, 0, 0, .5);
                self.officeRentSizeView.layer.cornerRadius = 5;
                self.officeRentSizeView.layer.masksToBounds = YES;
                [AppDelegate.window addSubview:self.officeRentSizeView];
                
                self.officeRentSizeView.frame = SCREEN_BOUNDS;
                self.topCustomTableView.hidden = YES;
                
                break;
            }
            case 3:{
                NSLog(@"日租金日租金日租金日租金日租金");
                self.officeRentMoneyView = [[LSOfficeRentMoneyView alloc]init];
                self.officeRentMoneyView.start = self.rizujinStart;
                self.officeRentMoneyView.end = self.rizujinEnd;

                self.officeRentMoneyView.delegate = self;
                
                self.officeRentMoneyView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
                //    self.alertView.backgroundColor = RGBColor(0, 0, 0, .5);
                self.officeRentMoneyView.layer.cornerRadius = 5;
                self.officeRentMoneyView.layer.masksToBounds = YES;
                [AppDelegate.window addSubview:self.officeRentMoneyView];
                
                self.officeRentMoneyView.frame = SCREEN_BOUNDS;
                self.topCustomTableView.hidden = YES;
                
                break;
            }
            case 4:{
                NSLog(@"起租日期起租日期起租日期起租日期起租日期");
                self.officeRentStartDateView = [[LSOfficeRentStartDateView alloc]init];
                
//                self.officeRentStartDateView.statusType = YES;
                
                self.officeRentStartDateView.delegate = self;
                
                self.officeRentStartDateView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
                //    self.alertView.backgroundColor = RGBColor(0, 0, 0, .5);
                self.officeRentStartDateView.layer.cornerRadius = 5;
                self.officeRentStartDateView.layer.masksToBounds = YES;
                [AppDelegate.window addSubview:self.officeRentStartDateView];
                
                self.officeRentStartDateView.frame = SCREEN_BOUNDS;
                
                [self.officeRentStartDateView hideViewWithStatusType:YES];
                self.topCustomTableView.hidden = YES;
                
                break;
            }
            default:
                break;
        }

        
    }
    
//    self.selectBtn.selected = NO;
//    self.selectBtn = sender;
//    sender.selected = YES;
    
//    switch (sender.tag) {
    
}

#pragma mark --- 代理方法
//-(void)sendDateStr:(NSString *)startDateStr WithEndDataStr:(NSString *)endDataStr{
//    
//    NSLog(@"%@   %@",startDateStr,endDataStr);
//    self.qizuDate = startDateStr;
////    self.rizujinEnd
////    self.endData = endDataStr;
//    
//    if (self.style == CELL_STYLE_ONE) {
//        
//        [self requestGetItemRentHouse:NO];
//        
//    }else if (self.style == CELL_STYLE_TWO){
//        
//        [self requestGetItemWantHouse:NO];
//    }
//
//    
//}

-(void)sendDateStr:(NSString *)dateStr{
    
    NSLog(@"%@",dateStr);
    self.qizuDate = dateStr;
    
    if (self.style == CELL_STYLE_ONE) {
        
        [self requestGetItemRentHouseTJ:NO];
        [self requestGetItemRentHouse:NO];
        
    }else if (self.style == CELL_STYLE_TWO){
        
        [self requestGetItemWantHouseTJ:NO];
        [self requestGetItemWantHouse:NO];
    }
    
}

- (void)sendmoney:(NSString *)start moneyend:(NSString *)moneyend {

    NSLog(@"start==%@  moneyend==%@",start,moneyend);
    
    self.rizujinStart = start;
    self.rizujinEnd = moneyend;
    
    if (self.style == CELL_STYLE_ONE) {
        
        [self requestGetItemRentHouseTJ:NO];
        [self requestGetItemRentHouse:NO];
        
    }else if (self.style == CELL_STYLE_TWO){
        
        [self requestGetItemWantHouseTJ:NO];
        [self requestGetItemWantHouse:NO];
        
    }
}

-(void)SendSizeStart:(NSString *)sizeStart WithSizeEnd:(NSString *)sizeEnd{
    
    NSLog(@"start==%@  End==%@",sizeStart,sizeEnd);
    
    self.sizeEnd = sizeEnd;
    self.sizeStart = sizeStart;
    
    if (self.style == CELL_STYLE_ONE) {
        
        [self requestGetItemRentHouseTJ:NO];
        [self requestGetItemRentHouse:NO];
        
    }else if (self.style == CELL_STYLE_TWO){
        
        [self requestGetItemWantHouseTJ:NO];
        [self requestGetItemWantHouse:NO];
        
    }
    
}


#pragma mark @ UITableViewDataSource && UITableViewDelegate @


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView == self.topCustomTableView) {
        return 1;
    }
    
    if (tableView == self.myCustomTableView) {
        return 2;
    }
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.topCustomTableView) {
        return self.topDataSourceArr.count;
    }
    
    if (tableView == self.myCustomTableView) {
        if(section == 0){
            return self.dataSourceArrTJ.count;
        }
        if (section == 1) {
            return self.dataSourceArr.count;
        }
        
    }

    
    
    return 0;

    
//    return self.dataSourceArr.count;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 84;
//}

//返回cell高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.topCustomTableView) {
        self.topCustomTableView.estimatedRowHeight = self.topCustomTableView.rowHeight;
        self.topCustomTableView.rowHeight = UITableViewAutomaticDimension;
        return self.topCustomTableView.rowHeight;
    }
    
    if (tableView == self.myCustomTableView) {
        self.myCustomTableView.estimatedRowHeight = self.myCustomTableView.rowHeight;
        self.myCustomTableView.rowHeight = UITableViewAutomaticDimension;
        return self.myCustomTableView.rowHeight;
    }

    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.topCustomTableView.hidden == YES) {
        if (self.style == CELL_STYLE_ONE) {
            LSOfficeRentCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_OfficeRent forIndexPath:indexPath];
            
            NSUInteger section = [indexPath section];
            if (section == 0) {
                [cell buildingWithGetItemRentHouseTJModel:self.dataSourceArrTJ[indexPath.row]];
            }
            if (section == 1){
                [cell buildingWithModel:self.dataSourceArr[indexPath.row]];
            }
            
//            [self.myCustomTableView  reloadData];
            //去掉分割线
            self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
            //cell点击变色
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            return cell;
            
        }else if (self.style == CELL_STYLE_TWO) {
            
            LSNeedOfficeRentCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_NeedOfficeRent forIndexPath:indexPath];
            
            NSUInteger section = [indexPath section];
            if (section == 0) {
                [cell buildingWithGetItemWantHouseTJModle:self.dataSourceArrTJ[indexPath.row]];
            }
            if (section == 1){
                [cell buildingGetItemWantHouseWithModle:self.dataSourceArr[indexPath.row]];
            }

            
            //去掉分割线
            self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
            //cell点击变色
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            
            return cell;
        }

    }else if (self.topCustomTableView.hidden == NO){
        
        LSCultureFinanceTopCell *cell = [self.topCustomTableView dequeueReusableCellWithIdentifier:CELL_CultureFinanceTop forIndexPath:indexPath];
        
        cell.nameLabel.text = self.topDataSourceArr[indexPath.row];
        
        //去掉分割线
        self.topCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        //cell点击变色
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [cell changeSelectedState:[self.selectedPath isEqual:indexPath]];
        
        return cell;
        
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.topCustomTableView.hidden == YES) {
        if (self.style == CELL_STYLE_ONE) {
            //出租
            
            NSLog(@"cell点击方法");
            LSOfficeRentDetailViewController  *detailVC = [[LSOfficeRentDetailViewController alloc] initWithNibName:@"LSOfficeRentDetailViewController" bundle:nil];
            
            if(indexPath.section == 0){
                
                LSGetItemRentHouseTJModel *model = self.dataSourceArrTJ[indexPath.row];
                detailVC.Id = model.rentId;
                detailVC.itemTypeId = @"4";
                detailVC.userId = model.userId;
                
                detailVC.delegate = self;
                detailVC.hiddenLowView = 0;
                
                NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
                NSString *userId = [userdefault objectForKey:@"userId"];
                
                if ([model.userId isEqualToString:userId]) {
                    
                    detailVC.hiddenLowView = 526;
                }

                
            }else if(indexPath.section == 1){
                LSGetItemRentHouseListModel *model = self.dataSourceArr[indexPath.row];
                
                detailVC.Id = model.rentId;
                detailVC.itemTypeId = @"4";
                detailVC.userId = model.userId;
                
                detailVC.delegate = self;
                detailVC.hiddenLowView = 0;
                
                NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
                NSString *userId = [userdefault objectForKey:@"userId"];
                
                if ([model.userId isEqualToString:userId]) {
                    
                    detailVC.hiddenLowView = 526;
                }

            }
            
            

            
            
            [self.navigationController pushViewController: detailVC animated:YES];
        }else if (self.style == CELL_STYLE_TWO){
            //求租
            
            
            LSNeedOfficeRentDetaiViewController *detailVC = [[LSNeedOfficeRentDetaiViewController alloc] initWithNibName:@"LSNeedOfficeRentDetaiViewController" bundle:nil];
            
            if (indexPath.section == 0) {
                
                LSGetItemWantHouseTJModel *model = self.dataSourceArrTJ[indexPath.row];
                detailVC.Id = model.wantId;
                detailVC.itemTypeId = @"3";
                detailVC.userId = model.userId;
                detailVC.hiddenLowView = 0;
                detailVC.delegate = self;
                
                
                
                NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
                NSString *userId = [userdefault objectForKey:@"userId"];
                
                if ([model.userId isEqualToString:userId]) {
                    detailVC.hiddenLowView = 5414;
                }

                
            }else if(indexPath.section == 1){
                LSGetItemWantHouseListModel *model = self.dataSourceArr[indexPath.row];
                detailVC.Id = model.wantId;
                detailVC.itemTypeId = @"3";
                detailVC.userId = model.userId;
                detailVC.hiddenLowView = 0;
                detailVC.delegate = self;
                
                
                
                NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
                NSString *userId = [userdefault objectForKey:@"userId"];
                
                if ([model.userId isEqualToString:userId]) {
                    detailVC.hiddenLowView = 5414;
                }

            }
            
            
            [self.navigationController pushViewController:detailVC animated:YES];
            
        }

        
    }else if (self.topCustomTableView.hidden == NO){
        
        
        if (self.style == CELL_STYLE_ONE) {
            
            switch (self.selectBtn.tag) {
                case 1:{
                    NSLog(@"地理位置地理位置地理位置地理位置地理位置");
                    if (indexPath.row == 0) {
                        self.address = @"";
                    }else{
                        self.address = self.topDataSourceArr[indexPath.row];
                    }
                    
                    NSString *row = [NSString stringWithFormat:@"%ld",indexPath.row];
                    [[NSUserDefaults standardUserDefaults] setObject:row forKey:@"1"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    break;
                }
                
                    
                default:
                    break;
            }
            
            [self requestGetItemRentHouse:NO];
            
            self.topCustomTableView.hidden = YES;
            

        }else if (self.style == CELL_STYLE_TWO){
            
            switch (self.selectBtn.tag) {
                case 1:{
                    NSLog(@"地理位置地理位置地理位置地理位置地理位置");
                    if (indexPath.row == 0) {
                        self.address = @"";
                    }else{
                        self.address = self.topDataSourceArr[indexPath.row];
                    }
                    
                    NSString *row = [NSString stringWithFormat:@"%ld",indexPath.row];
                    [[NSUserDefaults standardUserDefaults] setObject:row forKey:@"1"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    break;
                }

                    
                default:
                    break;
            }
            
            [self requestGetItemWantHouse:NO];
            
            self.topCustomTableView.hidden = YES;
                
        }
        
    }
    
}

#pragma mark - ||========= 代理方法 =========||
-(void)requestMoreDataNeedOfficeRentDetaiViewController{
    
    [self requestGetItemWantHouse:NO];
    
}

-(void)requestMoreDataOfficeRentDetailViewController{
    
    [self requestGetItemRentHouse:NO];
}



#pragma mark - ||========= PrivateMethods =========||

-(void)BtnClick{
    NSLog(@"搜索搜索搜索搜索搜索搜索搜索搜索搜索");
    LSSearchViewController *searchVC = [[LSSearchViewController alloc] initWithNibName:@"LSSearchViewController" bundle:nil];
    if (self.style == CELL_STYLE_ONE) {
        searchVC.type = @"3";//办公出租
    } else if (self.style == CELL_STYLE_TWO) {
        
        searchVC.type = @"4";//办公求租
    }
    [self.navigationController pushViewController:searchVC animated:YES];
    
}

- (void) controllerPressed:(id)sender {
    [self.dataSourceArrTJ removeAllObjects];
    [self.dataSourceArr removeAllObjects];
    NSInteger selectedSegment = self.segmentedControl.selectedSegmentIndex;
    if (selectedSegment == 1)
    {
        NSLog(@"办公求租");
        
        self.style = CELL_STYLE_TWO;
        
        self.address = @"";
        self.sizeStart = @"";
        self.sizeEnd = @"";
        self.rizujinStart = @"";
        self.rizujinEnd = @"";
        self.qizuDate = @"";
        
        [self requestGetItemWantHouseTJ:NO];
        [self requestGetItemWantHouse:NO];
        self.topCustomTableView.hidden = YES;
        
    }
    else
    {
        NSLog(@"办公出租");
        
        self.style = CELL_STYLE_ONE;
        
        self.address = @"";
        self.sizeStart = @"";
        self.sizeEnd = @"";
        self.rizujinStart = @"";
        self.rizujinEnd = @"";
        self.qizuDate = @"";
        
        [self requestGetItemRentHouseTJ:NO];
        [self requestGetItemRentHouse:NO];
        self.topCustomTableView.hidden = YES;
//        [self.myCustomTableView reloadData];
        
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

-(void)requestGetItemWantHouseTJ:(BOOL)isMore{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    [para setObject:userId forKey:@"userId"];
    
    weakSelf(weakSelf);
    [self.dataSourceArrTJ removeAllObjects];
    [[HRRequestManager manager] GET_PATH:PATH_GetItemWantHouse_TJ para:para success:^(id responseObject) {
        
        if ([responseObject[@"success"] boolValue] == 1) {
            
            NSLog(@"请求成功");
            
            for (NSDictionary *dic in responseObject[@"ds"]) {
                
                LSGetItemWantHouseTJModel *model = [[LSGetItemWantHouseTJModel alloc] initWithDictionary:dic];
                
                [weakSelf.dataSourceArrTJ addObject:model];
            }

            
        }else{
            
            NSLog(@"请求失败");
        }
        [weakSelf.myCustomTableView reloadData];
        [weakSelf endRefresh];

        
    } failure:^(NSError *error) {
        [weakSelf endRefresh];
        
    }];
}
     
-(void)requestGetItemRentHouseTJ:(BOOL)isMore{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    [para setObject:userId forKey:@"userId"];
    weakSelf(weakSelf);
    [self.dataSourceArrTJ removeAllObjects];
    [[HRRequestManager manager] GET_PATH:PATH_GetItemRentHouse_TJ para:para success:^(id responseObject) {
        
         NSLog(@"请求成功");
        if ([responseObject[@"success"] boolValue] == 1) {
            
            for (NSDictionary *dic in responseObject[@"ds"]) {
                
                LSGetItemRentHouseTJModel *model = [[LSGetItemRentHouseTJModel alloc] initWithDictionary:dic];
                
                [weakSelf.dataSourceArrTJ addObject:model];
            }
            
           
        }else{
            
            NSLog(@"请求失败");
        }
        
//        [weakSelf.myCustomTableView reloadData];
        [weakSelf endRefresh];
        
    } failure:^(NSError *error) {
        
        [weakSelf endRefresh];
    }];
}



-(void)requestGetItemRentHouse:(BOOL)isMore{
    
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (self.address) {
        [para setObject:self.address forKey:@"city"];
    }
    if (self.sizeStart) {
        [para setObject:self.sizeStart forKey:@"sizeStart"];
    }
    if (self.sizeEnd) {
        [para setObject:self.sizeEnd forKey:@"sizeEnd"];
    }
    if (self.rizujinStart) {
        [para setObject:self.rizujinStart forKey:@"rizujinStart"];
    }
    if (self.rizujinEnd) {
        [para setObject:self.rizujinEnd forKey:@"rizujinEnd"];
    }
    if (self.qizuDate) {
        [para setObject:self.qizuDate forKey:@"qizuDate"];
    }
    
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
    
    [[HRRequestManager manager] GET_PATH:PATH_GetItemRentHouse para:para success:^(id responseObject) {
        
        [weakSelf endRefresh];
        isFirst = NO;
        
        [self requestWithFindRentHouseListModelProject:[responseObject objectForKey:@"ds"] isMore:isMore];
        
    } failure:^(NSError *error) {
        
        [weakSelf endRefresh];
        
    }];
    
}


- (void)requestWithFindRentHouseListModelProject:(NSArray *)Arr isMore:(BOOL)isMore
{
    if (!isMore) {
        [self.dataSourceArr removeAllObjects];
    }
    
    for (NSDictionary *dic in Arr) {
        
        LSGetItemRentHouseListModel *model = [[LSGetItemRentHouseListModel alloc] initWithDictionary:dic];
        
        [self.dataSourceArr addObject:model];
    }
    
    [self.myCustomTableView  reloadData];
    
}



-(void)requestGetItemWantHouse:(BOOL)isMore{
    
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (self.address) {
        [para setObject:self.address forKey:@"address"];
    }
    if (self.sizeStart) {
        [para setObject:self.sizeStart forKey:@"sizeStart"];
    }
    if (self.sizeEnd) {
        [para setObject:self.sizeEnd forKey:@"sizeEnd"];
    }
    if (self.rizujinStart) {
        [para setObject:self.rizujinStart forKey:@"rizujinStart"];
    }
    if (self.rizujinEnd) {
        [para setObject:self.rizujinEnd forKey:@"rizujinEnd"];
    }
    if (self.qizuDate) {
        [para setObject:self.qizuDate forKey:@"qizuDate"];
    }

    
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
    
    [[HRRequestManager manager] GET_PATH:PATH_GetItemWantHouse para:para success:^(id responseObject) {
    
        [weakSelf endRefresh];
        isFirst = NO;
        
        [self requestWithFindWantHouseListModelProject:[responseObject objectForKey:@"ds"] isMore:isMore];
        
    } failure:^(NSError *error) {
        
        [weakSelf endRefresh];
        
    }];
    
    
}

- (void)requestWithFindWantHouseListModelProject:(NSArray *)Arr isMore:(BOOL)isMore
{
    if (!isMore) {
        [self.dataSourceArr removeAllObjects];
    }
    
    
    for (NSDictionary *dic in Arr) {
        
        LSGetItemWantHouseListModel *model = [[LSGetItemWantHouseListModel alloc] initWithDictionary:dic];
        
        [self.dataSourceArr addObject:model];
    }
    
    [self.myCustomTableView  reloadData];
    

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
