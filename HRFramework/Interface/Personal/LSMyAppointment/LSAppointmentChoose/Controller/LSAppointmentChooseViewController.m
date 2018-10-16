//
//  LSAppointmentChooseViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSAppointmentChooseViewController.h"

#import "LSAppointmentChooseCell.h"
#define CELL_AppointmentChoose @"AppointmentChooseCell"

#import "LSSelectMeetItemListModel.h"

#import "LSNeedOfficeRentCell.h"
#define CELL_NeedOfficeRent  @"NeedOfficeRentCell"

#import "LSCultureFinanceTopCell.h"
#define CELL_CultureFinanceTop  @"CultureFinanceTopCell"


@interface LSAppointmentChooseViewController ()
{
    BOOL isFirst;
}

@property (strong, nonatomic) IBOutlet UITableView *topCustomTableView;

@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;

//显示数据 [可筛选部分]
@property (strong, nonatomic) NSMutableArray *TotaldataSourceArr;

//全部数据
@property (strong, nonatomic) NSMutableArray *trueTotalDataSourceArr;

@property (strong, nonatomic) NSMutableArray *topDataSourceArr;

@property (strong, nonatomic) UIButton *selectBtn;

@property (nonatomic, strong)NSIndexPath *selectedPath;

@property (copy, nonatomic) NSString *day;
@property (copy, nonatomic) NSString *itemTypeId;




@end

@implementation LSAppointmentChooseViewController

#pragma mark - ||========== LifeCycle ===========||
// 视图加载完毕
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"选择";
    
    NSString * row = @"0";
    [[NSUserDefaults standardUserDefaults] setObject:row forKey:@"1"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:row forKey:@"2"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    self.topDataSourceArr = [NSMutableArray array];
    
    self.TotaldataSourceArr = [NSMutableArray array];
    
    self.trueTotalDataSourceArr = [NSMutableArray array];
    
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSAppointmentChooseCell" bundle:nil] forCellReuseIdentifier:CELL_AppointmentChoose];
    
    //注册cell-two
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSNeedOfficeRentCell" bundle:nil] forCellReuseIdentifier:CELL_NeedOfficeRent];
    
    //注册topCell
    [self.topCustomTableView registerNib:[UINib nibWithNibName:@"LSCultureFinanceTopCell" bundle:nil] forCellReuseIdentifier:CELL_CultureFinanceTop];
    
    
    [self requestSelectMeetItem:NO];
    
    weakSelf(weakSelf);
    
    [self.myCustomTableView.mj_header beginRefreshing];
    
    self.myCustomTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf requestSelectMeetItem:NO];
        
    }];
    
    self.myCustomTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf requestSelectMeetItem:YES];
        
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
    
    
    if(!self.topCustomTableView.hidden){
        
        switch (sender.tag) {
            case 1:{
                NSLog(@"发布日期发布日期发布日期发布日期发布日期发布日期");
                self.topDataSourceArr = [@[@"全部",@"今天",@"昨天",@"7天内",@"30天内",@"30天以上"] mutableCopy];
                
                NSString *row = [[NSUserDefaults standardUserDefaults] objectForKey:@"1"];
                NSIndexPath *path = [NSIndexPath indexPathForRow:[row integerValue] inSection:0];
                self.selectedPath = path;
                
                
                break;
            }case 2:{
                NSLog(@"项目类型项目类型项目类型项目类型项目类型");
                self.topDataSourceArr = [@[@"全部",@"金融产品",@"融资需求",@"办公出租",@"办公求租"] mutableCopy];
                
                NSString *row = [[NSUserDefaults standardUserDefaults] objectForKey:@"2"];
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
    
//    return self.dataSourceArr.count;
    
    if (tableView == self.topCustomTableView) {
        return self.topDataSourceArr.count;
    }
    
    if (tableView == self.myCustomTableView) {
        return self.TotaldataSourceArr.count;
    }
    
    return 0;
    
    
}

//返回cell高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.myCustomTableView.estimatedRowHeight = self.myCustomTableView.rowHeight;
    self.myCustomTableView.rowHeight = UITableViewAutomaticDimension;
    return self.myCustomTableView.rowHeight;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.topCustomTableView.hidden == YES) {
        
        LSSelectMeetItemListModel *model = self.TotaldataSourceArr[indexPath.row];
        
        switch ([model.itemTypeId integerValue]) {
            case 1:{
                LSAppointmentChooseCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_AppointmentChoose forIndexPath:indexPath];
                NSLog(@"融资需求融资需求融资需求融资需求融资需求");
                
                [cell buildingFinancingWithModel:self.TotaldataSourceArr[indexPath.row]];
                
                [cell.stateBtn setHidden:YES];
                
                //去掉分割线
                self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                
                return cell;
                break;
            }
            case 2:{
                LSAppointmentChooseCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_AppointmentChoose forIndexPath:indexPath];
                NSLog(@"金融产品金融产品金融产品金融产品金融产品");
                [cell buildingJinRongWithModel:self.TotaldataSourceArr[indexPath.row]];
                
                [cell.stateBtn setHidden:YES];
                
                //去掉分割线
                self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                
                return cell;
                break;
            }
            case 3:{
                
                LSAppointmentChooseCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_AppointmentChoose forIndexPath:indexPath];
                NSLog(@"办公出租办公出租办公出租办公出租办公出租");
                [cell buildingRentHouseWithModel:self.TotaldataSourceArr[indexPath.row]];
                
                [cell.stateBtn setHidden:YES];
                
                //去掉分割线
                self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                return cell;
                break;
            }
            case 4:{
                
                LSNeedOfficeRentCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_NeedOfficeRent forIndexPath:indexPath];
                
                NSLog(@"办公求租办公求助办公求助办公求助办公求助");
                [cell buildingWantHouseModel:self.TotaldataSourceArr[indexPath.row]];
                
                [cell.appointmentBtn setHidden:YES];
                
                //去掉分割线
                self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                return cell;
                break;
            }
                
            default:
                break;
        }

    }else if (self.topCustomTableView.hidden == NO){
        
        LSCultureFinanceTopCell *cell = [self.topCustomTableView dequeueReusableCellWithIdentifier:CELL_CultureFinanceTop forIndexPath:indexPath];
        
        cell.nameLabel.text = self.topDataSourceArr[indexPath.row];
        
        //        cell.nameLabel.font = [UIFont systemFontOfSize:12];
        
        
        //去掉分割线
        self.topCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        //cell点击变色
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [cell changeSelectedState:[self.selectedPath isEqual:indexPath]];
        
        return cell;

    }

    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (self.topCustomTableView.hidden == YES) {
        NSLog(@"%@",indexPath);
        
        LSSelectMeetItemListModel *model = self.TotaldataSourceArr[indexPath.row];
        
        self.sendCellModle(model);
        
        [self.navigationController popViewControllerAnimated:YES];
    }else if (self.topCustomTableView.hidden == NO){
        
        switch (self.selectBtn.tag) {
            case 1:{
                
                self.day = self.topDataSourceArr[indexPath.row];

                NSString *row = [NSString stringWithFormat:@"%ld",indexPath.row];
                [[NSUserDefaults standardUserDefaults] setObject:row forKey:@"1"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
//                [self filterByDate:indexPath.row];
                
//                [self.myCustomTableView reloadData];
                
                [self requestSelectMeetItem:NO];
                
                break;
            }
            case 2:{
                
                self.itemTypeId = self.topDataSourceArr[indexPath.row];
                
                NSString *row = [NSString stringWithFormat:@"%ld",indexPath.row];
                [[NSUserDefaults standardUserDefaults] setObject:row forKey:@"2"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                
//                if ([self.itemTypeId isEqualToString:@"金融产品"]) {
//                    [self filterByItemType:2];
//                }if ([self.itemTypeId isEqualToString:@"融资需求"]) {
//                    [self filterByItemType:1];
//                }if ([self.itemTypeId isEqualToString:@"办公出租"]) {
//                    [self filterByItemType:3];
//                }if ([self.itemTypeId isEqualToString:@"办公求租"]) {
//                    [self filterByItemType:4];
//                }
//
//                [self.myCustomTableView reloadData];
                
                [self requestSelectMeetItem:NO];
                
                break;
            }

            default:
                break;
        }
        
//        [self requestSelectMeetItem:NO];
        
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


-(void)requestSelectMeetItem:(BOOL)isMore {
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (self.day) {
        //@"今天",@"昨天",@"7天内",@"7天-30天",@"30天以上"
        if ([self.day isEqualToString:@"全部"]) {
            NSNumber *numberD = [NSNumber numberWithInt:0];
            [para setObject:numberD forKey:@"day"];
        }if ([self.day isEqualToString:@"今天"]) {
            NSNumber *numberD = [NSNumber numberWithInt:1];
            [para setObject:numberD forKey:@"day"];
        }if ([self.day isEqualToString:@"昨天"]) {
            NSNumber *numberD = [NSNumber numberWithInt:2];
            [para setObject:numberD forKey:@"day"];
        }if ([self.day isEqualToString:@"7天内"]) {
            NSNumber *numberD = [NSNumber numberWithInt:3];
            [para setObject:numberD forKey:@"day"];
        }if ([self.day isEqualToString:@"30天内"]) {
            NSNumber *numberD = [NSNumber numberWithInt:4];
            [para setObject:numberD forKey:@"day"];
        }if ([self.day isEqualToString:@"30天以上"]) {
            NSNumber *numberD = [NSNumber numberWithInt:5];
            [para setObject:numberD forKey:@"day"];
        }
        
    }
    if (self.itemTypeId) {
        if ([self.day isEqualToString:@"全部"]) {
            NSNumber *number = [NSNumber numberWithInt:nil];
            [para setObject:number forKey:@"day"];
        }if ([self.itemTypeId isEqualToString:@"金融产品"]) {
            NSNumber *number = [NSNumber numberWithInt:2];
            [para setObject:number forKey:@"itemTypeId"];
        }if ([self.itemTypeId isEqualToString:@"融资需求"]) {
            NSNumber *number = [NSNumber numberWithInt:1];
            [para setObject:number forKey:@"itemTypeId"];
        }if ([self.itemTypeId isEqualToString:@"办公出租"]) {
            NSNumber *number = [NSNumber numberWithInt:3];
            [para setObject:number forKey:@"itemTypeId"];
        }if ([self.itemTypeId isEqualToString:@"办公求租"]) {
            NSNumber *number = [NSNumber numberWithInt:4];
            [para setObject:number forKey:@"itemTypeId"];
        }
    }
    
    
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    
    [para setObject:userId forKey:@"userId"];
//    [para setObject:@"1" forKey:@"itemTypeId"];
//    [para setObject:@"1" forKey:@"day"];
    
    [para setObject:@"0" forKey:@"pageNo"];
    [para setObject:@"10" forKey:@"pageSize"];
    
    if (self.TotaldataSourceArr.count % 10 == 0)
    {
        [para setObject:isMore ? [NSString stringWithFormat:@"%lu",(long)self.TotaldataSourceArr.count/10+1 ] : @"1" forKey:@"pageNo"] ;
    }
    else
    {
        
        [para setObject:isMore ? [NSString stringWithFormat:@"%lu",self.TotaldataSourceArr.count/10+2] :@"1" forKey:@"pageNo"];
    }

    
    weakSelf(weakSelf);
    
    [[HRRequestManager manager] POST_PATH:PATH_SelectMeetItem para:para success:^(id responseObject) {

        [weakSelf endRefresh];
        isFirst = NO;
        
        
        [self requestWithFindSelectMeetItemListModelProject:[responseObject objectForKey:@"ds"] isMore:isMore];
        
    } failure:^(NSError *error) {
        
        
    }];
    
    
    
}

- (void)requestWithFindSelectMeetItemListModelProject:(NSArray *)Arr isMore:(BOOL)isMore
{
    if (!isMore) {
        [self.TotaldataSourceArr removeAllObjects];
        [self.trueTotalDataSourceArr removeAllObjects];
    }
    
    for (NSDictionary *dic in Arr) {
        
        LSSelectMeetItemListModel *model = [[LSSelectMeetItemListModel alloc] initWithDictionary:dic];
        
        [self.TotaldataSourceArr addObject:model];
    }
//    for (NSDictionary *dic in Arr) {
//        
//        LSSelectMeetItemListModel *model = [[LSSelectMeetItemListModel alloc] initWithDictionary:dic];
//        
//        [self.trueTotalDataSourceArr addObject:model];
//    }
    
    [self.myCustomTableView reloadData];
    
    
}

@end
