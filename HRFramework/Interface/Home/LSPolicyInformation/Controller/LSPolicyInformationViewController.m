//
//  LSPolicyInformationViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/24.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSPolicyInformationViewController.h"

#import "LSPolicyInformationCell.h"
#define CELL_PolicyInformation  @"PolicyInformationCell"

#import "LSCultureFinanceTopCell.h"
#define CELL_CultureFinanceTop  @"CultureFinanceTopCell"


#import "LSSearchViewController.h"
#import "LSTestDynamicDetailViewController.h"
#import "LSGetArticleListModel.h"

#import "LSOfficeRentStartDateView.h"
#import "LSPublishTimeView.h"
#import "LSOfficeRentNewSizeView.h"


@interface LSPolicyInformationViewController ()<LSPublishTimeViewDelegate>
{
    BOOL isFirst;
}
@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;
@property (strong, nonatomic) IBOutlet UITableView *topCustomTableView;


@property (strong, nonatomic) LSCultureFinanceTopCell *selectCell;
@property (strong, nonatomic) UIButton *selectBtn;
@property (strong, nonatomic) NSMutableArray *dataSourceArr;

@property (strong, nonatomic) NSMutableArray *topDataSourceArr;

@property (strong, nonatomic) NSMutableArray *topOneDateSourceArr;

@property (strong, nonatomic) LSOfficeRentStartDateView *officeRentStartDateView;
@property (strong, nonatomic) LSPublishTimeView * PublishTimeView;
@property (nonatomic, strong) LSOfficeRentNewSizeView *OfficeRentNewSizeView;

@property (copy, nonatomic) NSString *fawenZhuti;
@property (copy, nonatomic) NSString *hangyeType;
@property (copy, nonatomic) NSString *categoryId;
@property (copy, nonatomic) NSString *startDate;
@property (copy, nonatomic) NSString *endDate;



@property (nonatomic, strong)NSIndexPath *selectedPath;

@end

@implementation LSPolicyInformationViewController

// 初始化
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"LSPolicyInformationViewController"bundle:nil];
    if (self)
    {
//        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}

#pragma mark - ||========== LifeCycle ===========||
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = NO;
}

// 视图加载完毕
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"政策资讯";
    
    NSString *row = @"0";
    
    [[NSUserDefaults standardUserDefaults] setObject:row forKey:@"1"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:row forKey:@"2"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:row forKey:@"3"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:row forKey:@"4"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    self.dataSourceArr = [NSMutableArray array];
    self.topDataSourceArr = [NSMutableArray array];
    self.topOneDateSourceArr = [NSMutableArray array];
    
    //计算日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    
    NSInteger year = [[formatter stringFromDate:[NSDate date]] integerValue];
    
    [self.topOneDateSourceArr addObject:@"全部"];
    
    for (int i = (int)year; i > 2012 ; --i) {
        
        
        if (i == 2013) {
            
            NSString *str = [NSString stringWithFormat:@"%zd年及以前",i];
            [self.topOneDateSourceArr addObject:str];
        }else{
            NSString *Str = [NSString stringWithFormat:@"%zd年",i];
            [self.topOneDateSourceArr addObject:Str];
        }
        
        
    }
    

    
    
    //设置导航搜索按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(BtnClick) image:@"搜索" highImage:nil];
    
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSPolicyInformationCell" bundle:nil] forCellReuseIdentifier:CELL_PolicyInformation];
    
    
    //注册topCell
    [self.topCustomTableView registerNib:[UINib nibWithNibName:@"LSCultureFinanceTopCell" bundle:nil] forCellReuseIdentifier:CELL_CultureFinanceTop];
    
    
    //数据请求
    [self requestGetArticle:NO];
    
    weakSelf(weakSelf);
    
    [self.myCustomTableView.mj_header beginRefreshing];
    
    self.myCustomTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf requestGetArticle:NO];
        
    }];
    
    self.myCustomTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf requestGetArticle:YES];
        
    }];
    
    
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



-(void)BtnClick{
    NSLog(@"搜索搜索搜索搜索搜索搜索搜索搜索搜索");
    
    LSSearchViewController *searchVC = [[LSSearchViewController alloc] initWithNibName:@"LSSearchViewController" bundle:nil];
    searchVC.type = @"5";
    [self.navigationController pushViewController:searchVC animated:YES];
}



#pragma mark - ||========== IBActions ===========||
- (IBAction)ButtonAction:(UIButton *)sender {
    
     UIButton *btn =(UIButton *)sender;
//    self.selectBtn.selected = NO;
//    self.selectBtn = sender;
//    sender.selected = YES;
    
    if ([self.selectBtn isEqual:btn]) {
        [self.topCustomTableView setHidden:!self.topCustomTableView.isHidden];
        [btn setSelected:YES];
    }else {
        [self.topCustomTableView setHidden:NO];
        [self.selectBtn setSelected:NO];
        self.selectBtn = btn;
        [self.selectBtn setSelected:YES];
    }
    
    

    
//    if (sender.tag == 1) {
//        NSLog(@"发布时间发布时间发布时间发布时间发布时间");
//        sender.selected = !sender.selected;
        
//        self.officeRentStartDateView = [[LSOfficeRentStartDateView alloc]init];
//        
//        //        self.officeRentStartDateView.statusType = NO;
//        
//        self.officeRentStartDateView.delegate = self;
//        
//        self.officeRentStartDateView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
//        //    self.alertView.backgroundColor = RGBColor(0, 0, 0, .5);
//        self.officeRentStartDateView.layer.cornerRadius = 5;
//        self.officeRentStartDateView.layer.masksToBounds = YES;
//        [AppDelegate.window addSubview:self.officeRentStartDateView];
//        self.officeRentStartDateView.frame = SCREEN_BOUNDS;
//
//        
//        self.topCustomTableView.hidden = YES;
        
        
        
        //        self.PublishTimeView = [[LSPublishTimeView alloc]init];
//        
//        //        self.officeRentStartDateView.statusType = NO;
//        
//        self.PublishTimeView.delegate = self;
//        
//        self.PublishTimeView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
//        //    self.alertView.backgroundColor = RGBColor(0, 0, 0, .5);
//        self.PublishTimeView.layer.cornerRadius = 5;
//        self.PublishTimeView.layer.masksToBounds = YES;
//        [AppDelegate.window addSubview:self.PublishTimeView];
//        self.PublishTimeView.frame = SCREEN_BOUNDS;
//        
//        
//        self.topCustomTableView.hidden = YES;

        
        

//    }
//    else{
    
//    UIButton *btn =(UIButton *)sender;
    
        
        //            }
    if (!self.topCustomTableView.hidden) {
        
        switch (sender.tag) {
            case 1:{
                NSLog(@"发布文体发布文体发布文体发布文体发布文体");
                
//                self.topCustomTableView.hidden = NO;
//                self.topDataSourceArr = [@[@"全部",@"2016年",@"2015年",@"2014年",@"2013年及以前"] mutableCopy];
                //                [self.topCustomTableView reloadData];
                
                
                NSString *row = [[NSUserDefaults standardUserDefaults] objectForKey:@"4"];
                NSIndexPath *path = [NSIndexPath indexPathForRow:[row integerValue] inSection:0];
                self.selectedPath = path;
                
                break;
            }
                
            case 2:{
                NSLog(@"发布文体发布文体发布文体发布文体发布文体");
                
//                self.topCustomTableView.hidden = NO;
                self.topDataSourceArr = [@[@"全部",@"国家级",@"北京市",@"朝阳区",@"实验区"] mutableCopy];
                //                [self.topCustomTableView reloadData];
                
                NSString *row = [[NSUserDefaults standardUserDefaults] objectForKey:@"1"];
                NSIndexPath *path = [NSIndexPath indexPathForRow:[row integerValue] inSection:0];
                self.selectedPath = path;
                
                break;
            }
            case 3:{
                NSLog(@"行业类别行业类别行业类别行业类别行业类别");
                
//                self.topCustomTableView.hidden = NO;
                self.topDataSourceArr = [@[@"全部",@"文化艺术服务",@"新闻出版和发行服务",@"广播电视电影服务",@"软件和信息技术服务",@"广告和会展服务",@"艺术品生产与销售服务",@"设计服务",@"文化休闲娱乐服务",@"文化用品设备生产销售及其他辅助服务"] mutableCopy];
                
                //                [self.topCustomTableView reloadData];
                
                NSString *row = [[NSUserDefaults standardUserDefaults] objectForKey:@"2"];
                NSIndexPath *path = [NSIndexPath indexPathForRow:[row integerValue] inSection:0];
                self.selectedPath = path;
                
                break;
            }
            case 4:{
                NSLog(@"政策类型政策类型政策类型政策类型政策类型");
                
//                self.topCustomTableView.hidden = NO;
                self.topDataSourceArr = [@[@"全部",@"文化市场",@"文化贸易",@"文化金融",@"文化人才",@"文化财税",@"文化土地",@"专项资金",@"其他"]mutableCopy];
                //                [self.topCustomTableView reloadData];
                
                NSString *row = [[NSUserDefaults standardUserDefaults] objectForKey:@"3"];
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

#pragma mark --- 代理方法
-(void)sendDateStr:(NSString *)startDateStr WithEndDataStr:(NSString *)endDataStr{
    
    NSLog(@"%@",startDateStr);
    self.startDate = startDateStr;
    self.endDate = endDataStr;
    
    [self requestGetArticle:NO];
}


//-(void)sendDateStr:(NSString *)dateStr{
//    
////    NSLog(@"%@",dateStr);
////    self.startDate = dateStr;
//    
//}
//

#pragma mark @ UITableViewDataSource && UITableViewDelegate @
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.topCustomTableView) {
        
        if (self.selectBtn.tag == 1) {
            return self.topOneDateSourceArr.count;
        }else{
            return self.topDataSourceArr.count;
        }
        
    }
    
    if (tableView == self.myCustomTableView) {
        return self.dataSourceArr.count;
    }
    
    return 0;
//    return self.dataSourceArr.count;
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
    
    
    if (self.topCustomTableView.hidden == YES) {
        
        LSPolicyInformationCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_PolicyInformation forIndexPath:indexPath];
        
        [cell buildingWithModel:self.dataSourceArr[indexPath.row]];
        
        //去掉分割线
        self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        //cell点击变色
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;

        
    }else if (self.topCustomTableView.hidden == NO){
        
        LSCultureFinanceTopCell *cell = [self.topCustomTableView dequeueReusableCellWithIdentifier:CELL_CultureFinanceTop forIndexPath:indexPath];
        
        if (self.selectBtn.tag == 1) {
            cell.nameLabel.text = self.topOneDateSourceArr[indexPath.row];
            
        }else{
            cell.nameLabel.text = self.topDataSourceArr[indexPath.row];
        }
        
//        cell.nameLabel.text = self.topDataSourceArr[indexPath.row];
        
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
        
        LSGetArticleListModel *model = self.dataSourceArr[indexPath.row];
        
        LSTestDynamicDetailViewController *detailVC = [[LSTestDynamicDetailViewController alloc] initWithNibName:@"LSTestDynamicDetailViewController" bundle:nil];
        
        detailVC.Id = model.articleId;
        detailVC.titles = model.title;
        detailVC.date = model.publishdate;
        detailVC.count = model.viewCount;
        [self.navigationController pushViewController:detailVC animated:YES];
        
        NSLog(@"cell点击方法");

    }else if (self.topCustomTableView.hidden == NO){
        
        switch (self.selectBtn.tag) {
            case 1:{
                NSLog(@"发布时间发布时间发布时间发布时间发布时间");
                
                if (indexPath.row == 0) {
                    self.startDate = @"";
                }else{
                    self.startDate = [self.topOneDateSourceArr[indexPath.row] substringToIndex:4];
                }
                
                NSString *row = [NSString stringWithFormat:@"%ld",indexPath.row];
                [[NSUserDefaults standardUserDefaults] setObject:row forKey:@"4"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                break;
            }

            case 2:{
                NSLog(@"发文主体发文主体发文主体发文主体");
                
                if (indexPath.row == 0) {
                    self.fawenZhuti = @"";
                }else{
                    self.fawenZhuti = self.topDataSourceArr[indexPath.row];
                }
                
                NSString *row = [NSString stringWithFormat:@"%ld",indexPath.row];
                [[NSUserDefaults standardUserDefaults] setObject:row forKey:@"1"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                break;
            }
            case 3:{
                NSLog(@"行业类别行业类别行业类别行业类别");
                if (indexPath.row == 0) {
                    self.hangyeType = @"";
                }else{
                    self.hangyeType = self.topDataSourceArr[indexPath.row];
                }
                
                NSString *row = [NSString stringWithFormat:@"%ld",indexPath.row];
                [[NSUserDefaults standardUserDefaults] setObject:row forKey:@"2"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                break;
            }
            case 4:{
                NSLog(@"政策类型政策类型政策类型政策类型");
                if (indexPath.row == 0) {
                    self.categoryId = @"";
                }else{
                    self.categoryId = self.topDataSourceArr[indexPath.row];
                }

//                if (indexPath.row == 0) {
//                    self.categoryId = @"2";
//                }else
                
                    
                
                NSString *row = [NSString stringWithFormat:@"%ld",indexPath.row];
                [[NSUserDefaults standardUserDefaults] setObject:row forKey:@"3"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                break;
            }
                
            default:
                break;
        }
        
//        self.selectCell.img.hidden = YES;
//        LSCultureFinanceTopCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        self.selectCell = cell;
//        cell.img.hidden = NO;
//
        
        [self requestGetArticle:NO];
        self.topCustomTableView.hidden = YES;
        
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


-(void)requestGetArticle:(BOOL)isMore{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    [para setValue:@"2" forKey:@"categoryId"];
    if (self.fawenZhuti) {
        [para setObject:self.fawenZhuti forKey:@"fawenZhuti"];
    }
    if (self.hangyeType) {
        [para setObject:self.hangyeType forKey:@"hangyeType"];
    }
    if (self.categoryId) {
        [para setObject:self.categoryId forKey:@"zhengceType"];
    }
    if (self.startDate) {
        [para setObject:self.startDate forKey:@"startDate"];
    }
//    if (self.endDate) {
//        [para setObject:self.endDate forKey:@"endDate"];
//    }
    
    
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
    
    [[HRRequestManager manager] GET_PATH:PATH_GetArticle para:para success:^(id responseObject) {
        
        if ([responseObject[@"success"]boolValue] == 1) {
            
            NSLog(@"打印成功");
            
            [weakSelf endRefresh];
            isFirst = NO;
            
            
            [self requestWithFindArticleListModelProject:[responseObject objectForKey:@"ds"] isMore:isMore];
            
        }
        
    } failure:^(NSError *error) {
        
        [weakSelf endRefresh];
        
    }];
    
}

- (void)requestWithFindArticleListModelProject:(NSArray *)Arr isMore:(BOOL)isMore
{
    if (!isMore) {
        [self.dataSourceArr removeAllObjects];
    }
    
    for (NSDictionary *dic in Arr) {
        
        LSGetArticleListModel *model = [[LSGetArticleListModel alloc] initWithDictionary:dic];
        
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
