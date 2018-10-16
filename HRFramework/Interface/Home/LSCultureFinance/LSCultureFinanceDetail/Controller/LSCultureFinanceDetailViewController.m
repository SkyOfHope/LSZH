//
//  LSCultureFinanceDetailViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/23.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSCultureFinanceDetailViewController.h"

#import "LSCultureFinanceDetailCell.h"
#define CELL_CultureFinanceDetail  @"CultureFinanceDetailCell"

#import "LSCultureFinanceDetailHeaderView.h"
#import "LSLoginViewController.h"
#import "LSGetItemImgModel.h"
#import "LSRegistDataModel.h"
#import "LSSendAppointmentViewController.h"
#import "LSCustomBtn.h"


@interface LSCultureFinanceDetailViewController ()<UITableViewDelegate,UITableViewDataSource,LSCultureFinanceDetailHeaderViewDelegate>
{
    UIAlertView *alertView;
}



@property (strong, nonatomic) LSCultureFinanceDetailHeaderView *detailHeader;
@property (strong, nonatomic) UIButton *selectBtn;

@property (strong, nonatomic) NSArray *nameArr;

@property (nonatomic, strong)   NSMutableArray *footerArr;

/**
 *  tableView 数据源
 */
@property (strong, nonatomic) NSMutableArray *dataSourceArr;
@property (strong, nonatomic) NSMutableArray *GetImgArr;

//下方约谈视图
@property (weak, nonatomic) IBOutlet UIView *belowView;
//tableView下方约束

//下方两个按钮


@property (weak, nonatomic) IBOutlet UIButton *yuetan;

@property (weak, nonatomic) IBOutlet UIButton *collection;

@property (assign, nonatomic) NSInteger collectionNumber;

//被收藏的数量
@property (assign, nonatomic) NSInteger collectionCount;

@property (assign, nonatomic) BOOL isC;

//补充 tableView
@property (strong, nonatomic) UITableView *customTableView;


@end

@implementation LSCultureFinanceDetailViewController





#pragma mark - ||========== Lazy loading ===========||

-(UITableView *)customTableView{
    
    if (!_customTableView) {
        if (self.isHidden != 0) {
            _customTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT -64) style:UITableViewStylePlain];
            [self.belowView setHidden:YES];
        }else{
            _customTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - self.belowView.frame.size.height - self.belowView.frame.size.height) style:UITableViewStylePlain];
        }
    }
 
    return _customTableView;
}



-(LSCultureFinanceDetailHeaderView *)detailHeader{
    if (!_detailHeader) {
        
//        _detailHeader = [[NSBundle mainBundle] loadNibNamed:@"LSCultureFinanceDetailHeaderView" owner:nil options:nil].lastObject;
        _detailHeader = [[LSCultureFinanceDetailHeaderView alloc] init];
        
        _detailHeader.delegate = self;
    }
    
    return _detailHeader;
}


#pragma mark - ||========== LifeCycle ===========||
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"融资需求详情";
//    self.customTableView.tableHeaderView.frame = CGRectMake(0, 0, 100, 800);
    [self.view addSubview:self.customTableView];
    self.customTableView.delegate = self;
    self.customTableView.dataSource = self;
    
    //先设置下方两个按钮的分别数据
    [self requestNumberOfCollection];
   
    self.dataSourceArr = [NSMutableArray array];
    self.GetImgArr = [NSMutableArray array];

    self.nameArr = @[@"可提供材料",@"项目概述",@"项目优势",@"备注信息"];
    alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                          message:@"收藏"
                                         delegate:nil
                                cancelButtonTitle:@"确定"
                                otherButtonTitles:nil];
    
    //注册cell
    [self.customTableView registerNib:[UINib nibWithNibName:@"LSCultureFinanceDetailCell" bundle:nil] forCellReuseIdentifier:CELL_CultureFinanceDetail];
    
    
    self.customTableView.tableHeaderView = self.detailHeader;
    
    [self requestGetItemFinancingModel];
    [self requestGetItemImg];
    
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
- (IBAction)appointmentBtnAction:(UIButton *)sender {
    
    LSSendAppointmentViewController *sendVC = [[LSSendAppointmentViewController alloc]initWithNibName:@"LSSendAppointmentViewController" bundle:nil];
    
    NSMutableDictionary *paraDict =[NSMutableDictionary dictionary];
    [paraDict setObject:self.Id forKey:@"itemId"];
    [paraDict setObject:self.itemTypeId forKey:@"itemTypeId"];
    [paraDict setObject:self.userId forKey:@"toUserId"];
    
    sendVC.paraDict = paraDict;
    
    
    [self.navigationController pushViewController:sendVC animated:YES];
}



//收藏方法
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
//取消方法
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
- (IBAction)collectionActiom:(id)sender {

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

//点击之后只改变按钮的状态,在退出界面的时候发送请求进行收藏

#pragma mark @ UITableViewDataSource && UITableViewDelegate @
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.nameArr.count;
}

//返回cell高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.customTableView.estimatedRowHeight = self.customTableView.rowHeight;
    self.customTableView.rowHeight = UITableViewAutomaticDimension;
    return self.customTableView.rowHeight + 49;
}




-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSCultureFinanceDetailCell *cell = [self.customTableView dequeueReusableCellWithIdentifier:CELL_CultureFinanceDetail forIndexPath:indexPath];
    
    cell.nameLabel.text = self.nameArr[indexPath.row];
    
    if (self.dataSourceArr.count > 0) {
        
        cell.contentLabel.text = self.dataSourceArr[indexPath.row];
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





#pragma mark - ||==========代理方法===========||

-(void)updateDataWithHeight:(CGFloat)height{
    
    self.detailHeader.height = height ;
    [self.customTableView reloadData];
}

-(void)updateData{
    
    [self.customTableView reloadData];
    
}


#pragma mark - ||==========数据请求===========||
-(void)requestGetItemFinancingModel{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:self.Id forKey:@"Id"];
    
    
    [[HRRequestManager manager] GET_PATH:PATH_GetItemFinancingModel para:para success:^(id responseObject) {
        
        if ([responseObject[@"success"] boolValue] == 1) {
            
            
            
//            self.footerArr = [NSMutableArray array];
//            [self.footerArr removeAllObjects];
            [self.dataSourceArr removeAllObjects];
            
            NSDictionary *data = [responseObject objectForKey:@"ds"];
            
            LSGetItemFinancingModel *model = [[LSGetItemFinancingModel alloc] initWithDictionary:data];
            [self.detailHeader buildingWithModel:model];
            
            [self.dataSourceArr addObject:model.tigongZiliao];
            [self.dataSourceArr  addObject:model.xiangmuGaishu];
            [self.dataSourceArr addObject:model.xiangmuYoushi];
            [self.dataSourceArr addObject:model.remark];
//            NSString *xiangmuGaishu = data[@"xiangmuGaishu"];
            
//            [self.footerArr addObject:xiangmuGaishu];
            
        }
        
    } failure:^(NSError *error) {
        
        
        
    }];
    
}

//十七、	查询项目详情页图片列表
-(void)requestGetItemImg{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:self.Id forKey:@"itemId"];
    [para setObject:@"2" forKey:@"itemTypeId"];
    
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
                
                
//                LSGetItemImgModel *model = [[LSGetItemImgModel alloc]initWithDictionary:dic];
//                [self.GetImgArr addObject:model];
                
            }
            
            
            [self.detailHeader buildingWithArray:imgArr];
        }
        
//        [self.detailHeader buildingWithArray:self.GetImgArr];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    if ([self.delegate respondsToSelector:@selector(requestMoreData)]) {
        [self.delegate requestMoreData];
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
