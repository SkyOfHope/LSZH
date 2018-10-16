//
//  LSOfficeRentDetailViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/23.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSOfficeRentDetailViewController.h"

#import "LSOfficeRentDetailCell.h"
#define CELL_OfficeRentDetail  @"OfficeRentDetailCell"

#import "LSSendAppointmentViewController.h"

@interface LSOfficeRentDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIAlertView *alertView;
}


@property (strong, nonatomic) NSMutableArray *dataSourceArr;
@property (weak, nonatomic) IBOutlet UIView *lowView;

@property (strong, nonatomic) NSMutableArray *imgArr;



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

@implementation LSOfficeRentDetailViewController

-(UITableView *)customTableView{
    
    if (!_customTableView) {
        if (self.hiddenLowView != 0) {
            _customTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
            
            [self.lowView setHidden:YES];
        }else{
            
            _customTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - self.lowView.frame.size.height) style:UITableViewStylePlain];
            
            [self.lowView setHidden:NO];
        }
    }
    return _customTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view addSubview:self.customTableView];
    self.customTableView.delegate = self;
    self.customTableView.dataSource = self;
    
    
    [self requestNumberOfCollection];
    
    //标题设置注册cell
    self.title= @"办公出租";
    
    self.dataSourceArr = [NSMutableArray array];
    
    //注册cell
    [self.customTableView registerNib:[UINib nibWithNibName:@"LSOfficeRentDetailCell" bundle:nil] forCellReuseIdentifier:CELL_OfficeRentDetail];
    
    [self requestGetItemRentHouseModel];
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

//收藏按钮
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
    
    if (self.dataSourceArr.count > 0) {
        return self.dataSourceArr.count;
    }else{
        return 1;
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
    
    LSOfficeRentDetailCell *cell = [self.customTableView dequeueReusableCellWithIdentifier:CELL_OfficeRentDetail forIndexPath:indexPath];
    
    //去掉分割线
    self.customTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //cell点击变色
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (self.dataSourceArr.count > 0) {
        [cell buildingWithModel:self.dataSourceArr[indexPath.row]];
    }
    
    
//    [cell buildingWithArray:self.imgArr];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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

#pragma mark - ||==========数据请求===========||
-(void)requestGetItemRentHouseModel{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:self.Id forKey:@"Id"];
    
    weakSelf(weakSelf);
    
    [weakSelf.dataSourceArr removeAllObjects];
    
    [[HRRequestManager manager] GET_PATH:PATH_GetItemRentHouseModel para:para success:^(id responseObject) {

        if ([responseObject [@"success"] boolValue] == 1) {
            NSDictionary *data = [responseObject objectForKey:@"ds"];
            
            LSGetItemRentHouseModel *model = [[LSGetItemRentHouseModel alloc] initWithDictionary:data];
            
            [weakSelf.dataSourceArr addObject:model];
            
            [weakSelf.customTableView reloadData];
            [self requestGetItemImg];

        }else{
            
            [self promptBox_YTC_GeneralWithWords:responseObject[@"errMsg"]];
        }
        
    
    
    
    } failure:^(NSError *error) {
        
        
    }];
    
    
}


//十七、	查询项目详情页图片列表
-(void)requestGetItemImg{
    
    NSMutableArray *imgArr = [NSMutableArray array];
    [imgArr removeAllObjects];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:self.Id forKey:@"itemId"];
    [para setObject:@"3" forKey:@"itemTypeId"];
    
    [[HRRequestManager manager] GET_PATH:PATH_GetItemImg para:para success:^(id responseObject) {
        
        if ([responseObject [@"success"] boolValue] == 1) {
            
            NSLog(@"请求成功请求成功请求成功请求成功请求成功");
            
            
            NSString *imgPathStr;
            for (NSDictionary *dic in responseObject[@"ds"])
            {
                
                for (NSString *key in [dic allKeys]) {
                    
                    if ([key isEqual:@"imgPath"]) {
                        
                        imgPathStr = [dic objectForKey:@"imgPath"];
                    }
                }
                [imgArr addObject:imgPathStr];
                
            }
            
            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
            
            LSOfficeRentDetailCell *cell = [self.customTableView cellForRowAtIndexPath:index];
            
            [cell buildingWithArray:imgArr];
            
//            cell.blockForCell = ^(){
//                
//                [self.customTableView reloadData];
//                
//            };
            
            
            
            
        }
        
//        [self.detailHeader buildingWithArray:self.GetImgArr];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    if ([self.delegate respondsToSelector:@selector(requestMoreDataOfficeRentDetailViewController)]) {
        [self.delegate requestMoreDataOfficeRentDetailViewController];
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
