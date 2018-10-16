//
//  LSCultureFinanceProductDetailViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSCultureFinanceProductDetailViewController.h"
#import "LSCultureFinanceDetailCell.h"
#define CELL_CultureFinanceDetail  @"CultureFinanceDetailCell"

#import "LSCultureFinanceProductDetailHeader.h"
#import "LSLoginViewController.h"
#import "LSGetItemJinRongModel.h"

#import "LSSendAppointmentViewController.h"
#import "LSCustomBtn.h"

@interface LSCultureFinanceProductDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIAlertView *alertView;
}

@property (strong, nonatomic) LSCultureFinanceProductDetailHeader *productDetailHeader;

@property (strong, nonatomic) NSArray *nameArr;

@property (strong, nonatomic) NSMutableArray *dataSourceArr;

@property (nonatomic, strong)NSIndexPath *selectedPath;


//下方约谈栏不同情况下会隐藏
@property (weak, nonatomic) IBOutlet UIView *lowView;

//检查是否已经收藏
@property (assign, nonatomic) BOOL isCollectTheItem;


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

@implementation LSCultureFinanceProductDetailViewController

-(UITableView *)customTableView{
    
    if (!_customTableView) {
        if (self.isHidden != 0) {
            _customTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
            [self.lowView setHidden:YES];
        }else{
            _customTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - self.lowView.frame.size.height - 64) style:UITableViewStylePlain];
            [self.lowView setHidden:NO];
        }
    }
    
    return _customTableView;
}



-(LSCultureFinanceProductDetailHeader *)productDetailHeader{
    if (!_productDetailHeader) {
        
        _productDetailHeader = [[LSCultureFinanceProductDetailHeader
                                 alloc] init];
    }
    
    return _productDetailHeader;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view addSubview:self.customTableView];
    self.customTableView.delegate = self;
    self.customTableView.dataSource = self;
    
    
    [self requestNumberOfCollection];
    
    
    
    //数据源设置以及注册cell
    self.title = @"金融产品详情";
    
    self.nameArr = @[@"产品说明",@"产品优势",@"适用客户",@"申请条件",@"所需材料",@"办理流程",@"关键词",@"备注"];
    
    self.dataSourceArr = [NSMutableArray array];
    
    
    [self requestGetItemJinRongModel];
    //注册cell
    [self.customTableView registerNib:[UINib nibWithNibName:@"LSCultureFinanceDetailCell" bundle:nil] forCellReuseIdentifier:CELL_CultureFinanceDetail];
    
    self.customTableView.tableHeaderView = self.productDetailHeader;
    
    alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                          message:nil
                                         delegate:nil
                                cancelButtonTitle:@"确定"
                                otherButtonTitles:nil];
    
    [self configUI];
    
    [self requestGetItemImg];

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



//#pragma ========= 代理方法（分享） =========

//约谈点击事件
- (IBAction)appointmentBtnAction:(UIButton *)sender {
    
//    LSLoginViewController *login = [[LSLoginViewController alloc] initWithNibName:@"LSLoginViewController" bundle:nil];
//    
//    [self.navigationController pushViewController:login animated:nil];
    
    LSSendAppointmentViewController *sendVC = [[LSSendAppointmentViewController alloc]initWithNibName:@"LSSendAppointmentViewController" bundle:nil];
    
    NSMutableDictionary *paraDict =[NSMutableDictionary dictionary];
    [paraDict setObject:self.Id forKey:@"itemId"];
    [paraDict setObject:self.itemTypeId forKey:@"itemTypeId"];
    [paraDict setObject:self.userId forKey:@"toUserId"];
    
    sendVC.paraDict = paraDict;
    
    
    [self.navigationController pushViewController:sendVC animated:YES];
    
    
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
    
    return self.dataSourceArr.count;
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
    cell.contentLabel.text = self.dataSourceArr[indexPath.row];
    
    //去掉分割线
    self.customTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //cell点击变色
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"点击cell");
    
}

#pragma mark - ||==========数据请求===========||
-(void)requestGetItemJinRongModel{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:self.Id forKey:@"Id"];
    
    [[HRRequestManager manager] GET_PATH:GetItemJinRongModel para:para success:^(id responseObject) {
        
        if ([responseObject[@"success"] boolValue] == 1) {
            
            //            self.footerArr = [NSMutableArray array];
            //            [self.footerArr removeAllObjects];
            [self.dataSourceArr removeAllObjects];
            
            NSDictionary *data = [responseObject objectForKey:@"ds"];
            
            LSGetItemJinRongModel *model = [[LSGetItemJinRongModel alloc] initWithDictionary:data];
            
            [self.productDetailHeader buildingWithModel:model];
            
            [self.dataSourceArr addObject:model.productSummary];
            [self.dataSourceArr  addObject:model.advantage];
            [self.dataSourceArr addObject:model.client];
            [self.dataSourceArr addObject:model.condition];
            [self.dataSourceArr addObject:model.information];
            [self.dataSourceArr addObject:model.flow];
            [self.dataSourceArr  addObject:model.keyword];
            [self.dataSourceArr addObject:model.remark];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.customTableView  reloadData];
        });
    
    } failure:^(NSError *error) {
        
        
        
    }];
    
}

//十七、	查询项目详情页图片列表
-(void)requestGetItemImg{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:self.Id forKey:@"itemId"];
    [para setObject:@"1" forKey:@"itemTypeId"];
    
    [[HRRequestManager manager] GET_PATH:PATH_GetItemImg para:para success:^(id responseObject) {
        
        if ([responseObject [@"success"] boolValue] == 1) {
            
            NSLog(@"请求成功请求成功请求成功请求成功请求成功");
            
            NSMutableArray *imgArr = [NSMutableArray array];
            [imgArr removeAllObjects];
            
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
            
            
            [self.productDetailHeader buildingWithArray:imgArr];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    if ([self.delegate respondsToSelector:@selector(requestMoreDataCultureFinanceProductDetailViewController)]) {
        [self.delegate requestMoreDataCultureFinanceProductDetailViewController];
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
