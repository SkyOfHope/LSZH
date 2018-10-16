
//
//  LSAppointmentDetailViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/21.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSAppointmentDetailViewController.h"

#import "LSAppointmentDetailCell.h"
#define CELL_AppointmentDetailt  @"AppointmentDetail"

#import "LSMyReceiveAppontmentDetailCell.h"
#define CELL_MyReceiveAppontmentDetail  @"MyReceiveAppontmentDetail"

#import "LSShouDaoYueTanModel.h"

#import "LSCultureFinanceDetailViewController.h"

#import "LSCultureFinanceProductDetailViewController.h"

#import "LSNeedOfficeRentDetaiViewController.h"

#import "LSOfficeRentDetailViewController.h"

@interface LSAppointmentDetailViewController ()<LSMyReceiveAppontmentDetailCellDelegate,LSAppointmentDetailCellDelegate>

@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;


@end

@implementation LSAppointmentDetailViewController

#pragma mark - ||========== LifeCycle ===========||
// 视图加载完毕
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self.style isEqualToString:@"1"]) {
       self.title = @"我发起的";
    }
    if ([self.style isEqualToString:@"2"]) {
        self.title = @"我收到的";
    }
    self.dataSourceArr = [NSMutableArray arrayWithCapacity:0];
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSAppointmentDetailCell" bundle:nil] forCellReuseIdentifier:CELL_AppointmentDetailt];
    
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSMyReceiveAppontmentDetailCell" bundle:nil] forCellReuseIdentifier:CELL_MyReceiveAppontmentDetail];
    
    
    [self DataHTTPS];
    
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



#pragma mark @ UITableViewDataSource && UITableViewDelegate @

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
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
    
    if ([self.style isEqualToString:@"1"]){
        
        LSAppointmentDetailCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_AppointmentDetailt forIndexPath:indexPath];
        
        cell.delegate = self;
        
        //cell点击变色
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        //去掉分割线
        self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        if (self.dataSourceArr.count > 0) {
            if ([self.style isEqualToString:@"1"]) {
                LSFaQiDetailModel *model1 = self.dataSourceArr[indexPath.row];
                [cell buildFaQiDetailWithFaQiDetailModel:model1];
            }

        }
        
        
        return cell;

    }else if ([self.style isEqualToString:@"2"]){
        
        LSMyReceiveAppontmentDetailCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_MyReceiveAppontmentDetail forIndexPath:indexPath];
        
        cell.delegate = self;
        
        //cell点击变色
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        //去掉分割线
        self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        if (self.dataSourceArr.count > 0) {

            if ([self.style isEqualToString:@"2"]) {
                LSShouDaoDetailModel *model2 = self.dataSourceArr[indexPath.row];
                [cell buildShouDaoDetailWithShouDaoDetailModel:model2];
                
            }
            
        }

        return cell;
        
    }
    
    
    
    return nil;
}


//代理方法 --- 跳转界面
-(void)pushToDetailController:(LSShouDaoDetailModel *)model{

    LSCultureFinanceProductDetailViewController *product = [[LSCultureFinanceProductDetailViewController alloc]initWithNibName:@"LSCultureFinanceProductDetailViewController" bundle:nil];
    
    LSCultureFinanceDetailViewController *finacan = [[LSCultureFinanceDetailViewController alloc]initWithNibName:@"LSCultureFinanceDetailViewController" bundle:nil];
    
    LSNeedOfficeRentDetaiViewController *needRent = [[LSNeedOfficeRentDetaiViewController alloc]initWithNibName:@"LSNeedOfficeRentDetaiViewController" bundle:nil];
    
    LSOfficeRentDetailViewController *officeRent = [[LSOfficeRentDetailViewController alloc]initWithNibName:@"LSOfficeRentDetailViewController" bundle:nil];
    
        switch ([model.fujianItemTypeId integerValue]) {
            case 1:
                
                product.Id = model.fujianItemId;
                product.itemTypeId = model.fujianItemTypeId;
                
                product.isHidden = 153;
                
                [self.navigationController pushViewController:product animated:YES];
                
                break;
            case 2:
                
                finacan.Id = model.fujianItemId;
                finacan.itemTypeId = model.fujianItemTypeId;
                
                finacan.isHidden = 51;
                [self.navigationController pushViewController:finacan animated:YES];
                
                break;
            case 4:
                
                needRent.Id = model.fujianItemId;
                needRent.itemTypeId = model.fujianItemTypeId;
                needRent.hiddenLowView = 415;
                [self.navigationController pushViewController:needRent animated:YES];
                
                break;
            case 3:
                
                officeRent.Id = model.fujianItemId;
                officeRent.itemTypeId = model.fujianItemTypeId;
                officeRent.hiddenLowView = 456;
                [self.navigationController pushViewController:officeRent animated:YES];
                
                break;
            default:
                break;
        }
    
    
}


-(void)pushToDetailViewController:(LSFaQiDetailModel *)model{
    
    LSCultureFinanceProductDetailViewController *product = [[LSCultureFinanceProductDetailViewController alloc]initWithNibName:@"LSCultureFinanceProductDetailViewController" bundle:nil];
    
    LSCultureFinanceDetailViewController *finacan = [[LSCultureFinanceDetailViewController alloc]initWithNibName:@"LSCultureFinanceDetailViewController" bundle:nil];
    
    LSNeedOfficeRentDetaiViewController *needRent = [[LSNeedOfficeRentDetaiViewController alloc]initWithNibName:@"LSNeedOfficeRentDetaiViewController" bundle:nil];
    
    LSOfficeRentDetailViewController *officeRent = [[LSOfficeRentDetailViewController alloc]initWithNibName:@"LSOfficeRentDetailViewController" bundle:nil];
    
    switch ([model.fujianItemTypeId integerValue]) {
        case 1:
            
            product.Id = model.fujianItemId;
            product.itemTypeId = model.fujianItemTypeId;
            
            product.isHidden = 153;
            
            [self.navigationController pushViewController:product animated:YES];
            
            break;
        case 2:
            
            finacan.Id = model.fujianItemId;
            finacan.itemTypeId = model.fujianItemTypeId;
            
            finacan.isHidden = 51;
            [self.navigationController pushViewController:finacan animated:YES];
            
            break;
        case 4:
            
            needRent.Id = model.fujianItemId;
            needRent.itemTypeId = model.fujianItemTypeId;
            needRent.hiddenLowView = 415;
            [self.navigationController pushViewController:needRent animated:YES];
            
            break;
        case 3:
            
            officeRent.Id = model.fujianItemId;
            officeRent.itemTypeId = model.fujianItemTypeId;
            officeRent.hiddenLowView = 456;
            [self.navigationController pushViewController:officeRent animated:YES];
            
            break;
        default:
            break;
    }

    
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%@",indexPath);
    
    
}

- (void)DataHTTPS {
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    NSString *pathStr = [NSString string];
    if ([self.style isEqualToString:@"1"]) {//我发起的详情
        [para setObject:self.meetId forKey:@"meetId"];
        pathStr = PATH_GetUserSendMeetModel;
        
        
    }
    if ([self.style isEqualToString:@"2"]) {//我收到的详情
        [para setObject:self.itemId forKey:@"itemId"];
        [para setObject:self.itemTypeId forKey:@"itemTypeId"];
        
        [para setObject:self.chuanruCanshuShoudaoYueTan.userId forKey:@"userId"];
        pathStr = PATH_GetUserMeetModel;
        
        
    }
    
    [[HRRequestManager manager]POST_PATH:pathStr para:para success:^(id responseObject) {

        NSInteger success = [responseObject[@"success"] integerValue];
        
        if (success == 1) {
            
            NSDictionary *jsonDic = responseObject[@"ds"];

                
                if ([self.style isEqualToString:@"1"]) {
                    //我发起的详情
                    LSFaQiDetailModel *model1 = [[LSFaQiDetailModel alloc]initWithDictionary:jsonDic];
                    [self.dataSourceArr addObject:model1];
                }
                
                if ([self.style isEqualToString:@"2"]) {
                    //我收到的详情
                    
                    LSShouDaoDetailModel *model2 = [[LSShouDaoDetailModel alloc]initWithDictionary:jsonDic];
                    [self.dataSourceArr addObject:model2];
                }
            
                [self.myCustomTableView reloadData];

        }else{
            NSString *errMsg = responseObject[@"errMsg"];
            NSLog(@"错误数据:%@",errMsg);
            [self promptBox_YTC_GeneralWithWords_epinasty:errMsg];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self promptBox_YTC_GeneralWithWords:responseObject[@"errMsg"]];
                
//                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        
       
    } failure:^(NSError *error) {
        
    }];
    
}








@end
