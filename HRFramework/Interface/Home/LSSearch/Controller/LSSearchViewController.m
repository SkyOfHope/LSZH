

//
//  LSSearchViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/26.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSSearchViewController.h"

//#import "LSSearchTableViewCell.h"
//#define CELL_Search  @"SearchCell"

#import "LSCultureFinanceCell.h" //融资需求和金融产品
#define LSCultureFinanceCellsearch  @"LSCultureFinanceCellsearch"

#import "LSOfficeRentCell.h"//办公出租
#define LSOfficeRentCellsearch  @"LSOfficeRentCellsearch"

#import "LSNeedOfficeRentCell.h"//办公求租
#define LSNeedOfficeRentCellsearch  @"LSNeedOfficeRentCellsearch"

#import "LSPolicyInformationCell.h"//政策资讯
#define LSPolicyInformationCellsearch @"LSPolicyInformationCellsearch"

#import "LSTestDynamicCell.h"//实验区动态
#define LSTestDynamicCellsearch @"LSTestDynamicCellsearch"

#import "LSTestDynamicNoImageTableViewCell.h"//试验区动态没有图片
static NSString *const CELL_TestDynamicNoImage = @"LSTestDynamicNoImageTableViewCell";




#import "LSCultureFinanceDetailViewController.h"//r融资需求详情
#import "LSCultureFinanceProductDetailViewController.h"// 金融产品详情
#import "LSOfficeRentDetailViewController.h"//出租详情
#import "LSNeedOfficeRentDetaiViewController.h"//求租详情
#import "LSTestDynamicDetailViewController.h"//实验区动态详情
#import "LSTestDynamicDetailViewController.h"//政策资讯详情

@interface LSSearchViewController ()
{
    NSInteger ty;
}

@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;
//@property (strong, nonatomic) IBOutlet UIView *noSearchResult;
@property (weak, nonatomic) IBOutlet UIButton *quxiaoBtn;
@property (weak, nonatomic) IBOutlet UITextField *sousuoTf;
//@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (nonatomic, strong) NSMutableArray *idsArr;



@property (strong, nonatomic) NSMutableArray *dataSourceArr;
@property (nonatomic, copy) NSString *pathStr;
@end

@implementation LSSearchViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self.navigationItem.backBarButtonItem setTitle:@""];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [self selectCellType];
    self.dataSourceArr = [NSMutableArray arrayWithCapacity:0];
    self.idsArr = [NSMutableArray arrayWithCapacity:0];
    self.myCustomTableView.hidden = YES;
//    self.
    UIView *TFLeftV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 30)];
    
    UIView *LeftSpaceV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 30)];
    [TFLeftV addSubview:LeftSpaceV];
    
    UIImageView *searchImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"搜索"]];
    searchImgV.frame = CGRectMake(5, 8, 15, 15);
    [TFLeftV addSubview:searchImgV];
    
    self.sousuoTf.leftView = TFLeftV;
    _sousuoTf.leftViewMode = UITextFieldViewModeAlways;
    
    
    //去掉分割线
    self.myCustomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
- (IBAction)backAction:(id)sender {
    
    [self.navigationController.navigationItem setHidesBackButton:YES];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
    
    [self.navigationItem.backBarButtonItem setTitle:@""];
    self.navigationItem.titleView = nil;
    self.navigationItem.hidesBackButton = YES;
    
    [self.navigationItem setHidesBackButton:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}

//- (IBAction)sureAction:(id)sender {
//    [self DataHTTPS:self.sousuoTf.text];
//}


- (void) selectCellType {
    ty = [self.type integerValue];
    
    switch (ty) {
        case 1:
        {
            //注册cell
            [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSCultureFinanceCell" bundle:nil] forCellReuseIdentifier:LSCultureFinanceCellsearch];//融资需求
            self.pathStr = GetItemFinancing;//融资需求
            
            
            
        }
            break;
        case 2:
        {
            //注册cell
            [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSCultureFinanceCell" bundle:nil] forCellReuseIdentifier:LSCultureFinanceCellsearch];//金融产品
            self.pathStr = GetItemJinRong;//金融产品
            
        }
            break;
        case 3:
        {
            //注册cell
            [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSOfficeRentCell" bundle:nil] forCellReuseIdentifier:LSOfficeRentCellsearch];//办公出租
            self.pathStr = PATH_GetItemRentHouse;//办公出租
            
        }
            break;
        case 4:
        {
            //注册cell
            [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSNeedOfficeRentCell" bundle:nil] forCellReuseIdentifier:LSNeedOfficeRentCellsearch];//办公求租
            self.pathStr = PATH_GetItemWantHouse;//办公求租
           
        }
            break;
        case 5:
        {
            //注册cell
            [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSPolicyInformationCell" bundle:nil] forCellReuseIdentifier:LSPolicyInformationCellsearch];//政策资讯
            self.pathStr = PATH_GetArticle;//政策资讯
            
            
        }
            break;
        case 6:
        {
            //注册cell
            [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSTestDynamicCell" bundle:nil] forCellReuseIdentifier:LSTestDynamicCellsearch];//实验区动态
            
            //注册cell没图片
            [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSTestDynamicNoImageTableViewCell" bundle:nil] forCellReuseIdentifier:CELL_TestDynamicNoImage];
            
            
            self.pathStr = GetSyqdt;//实验区动态
            
        }
            break;
            
        default:
            break;
    }

}

#pragma mark @ UITableViewDataSource && UITableViewDelegate @
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSourceArr.count;
}


//返回cell高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.myCustomTableView.estimatedRowHeight = self.myCustomTableView.rowHeight;
    self.myCustomTableView.rowHeight = UITableViewAutomaticDimension;
    return self.myCustomTableView.rowHeight;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    switch (ty) {
        case 1:
        {
            LSCultureFinanceCell *cell1 = [self.myCustomTableView dequeueReusableCellWithIdentifier:LSCultureFinanceCellsearch forIndexPath:indexPath];//融资需求
            
            [cell1 buildingGetItemFinancingWithModel:self.dataSourceArr[indexPath.row]];
            
            //去掉分割线
            self.myCustomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            return cell1;
        }
            break;
        case 2:
        {
            LSCultureFinanceCell *cell2 = [self.myCustomTableView dequeueReusableCellWithIdentifier:LSCultureFinanceCellsearch forIndexPath:indexPath];
            [cell2 buildingGetItemJinRongWithModel:self.dataSourceArr[indexPath.row]];
            
            //去掉分割线
            self.myCustomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [cell2 setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            return cell2; //金融产品
        }
            break;
        case 3:
        {
            LSOfficeRentCell *cell3 = [self.myCustomTableView dequeueReusableCellWithIdentifier:LSOfficeRentCellsearch forIndexPath:indexPath];
            [cell3 buildingWithModel:self.dataSourceArr[indexPath.row]];
            
            //去掉分割线
            self.myCustomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [cell3 setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            return cell3;//办公出租
        }
            break;
        case 4:
        {
            LSNeedOfficeRentCell *cell4 = [self.myCustomTableView dequeueReusableCellWithIdentifier:LSNeedOfficeRentCellsearch forIndexPath:indexPath];
            [cell4 buildingGetItemWantHouseWithModle:self.dataSourceArr[indexPath.row]];
            
            //去掉分割线
            self.myCustomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [cell4 setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            return cell4;//办公求租
        }
            break;
        case 5:
        {
            LSPolicyInformationCell *cell5 = [self.myCustomTableView dequeueReusableCellWithIdentifier:LSPolicyInformationCellsearch forIndexPath:indexPath];
            [cell5 buildingWithModel:self.dataSourceArr[indexPath.row]];
            
            //去掉分割线
            self.myCustomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [cell5 setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            return cell5;//政策资讯
        
        }
            break;
        case 6:
        {
            
//            LSGetSyqdtModel
            
            LSGetSyqdtModel *model = self.dataSourceArr[indexPath.row];
            
            if (model.imgPath.length > 0) {
                
                LSTestDynamicCell *cell6 = [self.myCustomTableView dequeueReusableCellWithIdentifier:LSTestDynamicCellsearch forIndexPath:indexPath];
                [cell6 buildingWithModel:self.dataSourceArr[indexPath.row]];
                
                //去掉分割线
                self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
                [cell6 setSelectionStyle:UITableViewCellSelectionStyleNone];
                
                return cell6;
                
            }else{
                
                LSTestDynamicNoImageTableViewCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_TestDynamicNoImage forIndexPath:indexPath];
                
                [cell buildingSecondCellWithModel:self.dataSourceArr[indexPath.row]];
                
                //去掉分割线
                self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                
                return cell;
                
            }

            return nil;//实验区动态
        }
            break;
            
        default:
            break;
    }
//    LSSearchTableViewCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_Search forIndexPath:indexPath];
    
    
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *markId = self.idsArr[indexPath.row];
    switch (ty) {
        case 1:
        {
            LSCultureFinanceDetailViewController *cntl1 = [[LSCultureFinanceDetailViewController alloc]init];
            cntl1.Id = markId;
            cntl1.itemTypeId = @"2";
            [self.navigationController pushViewController:cntl1 animated:YES];//融资需求
            
        }
            break;
        case 2:
        {
            LSCultureFinanceProductDetailViewController *cntl2 = [[LSCultureFinanceProductDetailViewController alloc]init];
            cntl2.Id = markId;
            cntl2.itemTypeId = @"1";
            [self.navigationController pushViewController:cntl2 animated:YES]; //金融产品
        }
            break;
        case 3:
        {
            LSOfficeRentDetailViewController *cntl3 = [[LSOfficeRentDetailViewController alloc]init];
            cntl3.Id = markId;
            cntl3.itemTypeId = @"3";
            [self.navigationController pushViewController:cntl3 animated:YES];//办公出租
        }
            break;
        case 4:
        {
            LSNeedOfficeRentDetaiViewController *cntl4 = [[LSNeedOfficeRentDetaiViewController alloc]init];
            cntl4.Id = markId;
            cntl4.itemTypeId = @"4";
            [self.navigationController pushViewController:cntl4 animated:YES];//办公求租
        }
            break;
        case 5:
        {
            LSTestDynamicDetailViewController *cntl5 = [[LSTestDynamicDetailViewController alloc]init];
            cntl5.Id = markId;
            [self.navigationController pushViewController:cntl5 animated:YES];//政策资讯
            
        }
            break;
        case 6:
        {
            LSTestDynamicDetailViewController *cntl6 = [[LSTestDynamicDetailViewController alloc]init];
            cntl6.Id = markId;
            [self.navigationController pushViewController:cntl6 animated:YES];//实验区动态
        }
            break;
            
        default:
            break;
    }
    
}


#pragma mark  ========UITextFieldDelegate============

//开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.returnKeyType = UIReturnKeySearch;
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self DataHTTPS:textField.text];
    return YES;
}


- (void) DataHTTPS:(NSString *)searchkey {
    
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithCapacity:0];
    [para setObject:searchkey forKey:@"keyword"];
    
    NSNumber *pageNo = [NSNumber numberWithInt:1];
    [para setObject:pageNo forKey:@"pageNo"];
    NSNumber *pageSize = [NSNumber numberWithInt:20];
    [para setObject:pageSize forKey:@"pageSize"];
    
    [[HRRequestManager manager] GET_PATH:self.pathStr para:para success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            NSDictionary * dic = (NSDictionary *)responseObject;
            NSString *success = [dic objectForKey:@"success"];
            
            if ([success isEqualToString:@"1"])
            {
                [self.dataSourceArr removeAllObjects];
                [self.idsArr removeAllObjects];
                NSArray *dsArr = dic[@"ds"];
                if (dsArr.count > 0) {
                    for (NSDictionary *dataDic in dsArr) {
                            switch (ty) {
                                case 1:
                                {//融资需求
                                    LSGetItemFinancingListModel *model1 = [[LSGetItemFinancingListModel alloc]initWithDictionary:dataDic];
                                    [self.dataSourceArr addObject:model1];
                                    [self.idsArr addObject:model1.financingId];
                                }
                                    break;
                                case 2:
                                {//金融产品
                                    LSGetItemJinRongListModel *model2 = [[LSGetItemJinRongListModel alloc]initWithDictionary:dataDic];
                                    [self.dataSourceArr addObject:model2];
                                    [self.idsArr addObject:model2.jinrongId];
                                }
                                    break;
                                case 3:
                                {//办公出租
                                    LSGetItemRentHouseListModel *model3 = [[LSGetItemRentHouseListModel alloc]initWithDictionary:dataDic];
                                    [self.dataSourceArr addObject:model3];

                                    [self.idsArr addObject:model3.rentId];
                                }
                                    break;
                                case 4:
                                {//办公求租
                                    LSGetItemWantHouseListModel *model4 = [[LSGetItemWantHouseListModel alloc]initWithDictionary:dataDic];
                                    [self.dataSourceArr addObject:model4];
                                    [self.idsArr addObject:model4.wantId];
                                }
                                    break;
                                case 5:
                                {//政策资讯
                                    LSGetArticleListModel *model5 = [[LSGetArticleListModel alloc]initWithDictionary:dataDic];
                                    [self.dataSourceArr addObject:model5];
                                    [self.idsArr addObject:model5.articleId];
                                    
                                }
                                    break;
                                case 6:
                                {//实验区动态
                                    LSGetSyqdtModel *model6 = [[LSGetSyqdtModel alloc]initWithDictionary:dataDic];
                                    [self.dataSourceArr addObject:model6];
                                    [self.idsArr addObject:model6.articleId];
                                }
                                    break;
                                    
                                default:
                                    break;
                            }

                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.myCustomTableView.hidden = NO;
                        [_myCustomTableView reloadData];
                    });
                    
                } else {
                    self.myCustomTableView.hidden = YES;
                    NSLog(@"没有数据");
                }
                
            }
            
        }
        
    } failure:^(NSError *error) {
        
        
    }];

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
