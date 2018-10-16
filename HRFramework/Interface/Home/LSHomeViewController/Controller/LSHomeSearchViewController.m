//
//  LSHomeSearchViewController.m
//  LSZH
//
//  Created by posco imac4 on 16/6/6.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSHomeSearchViewController.h"
#import "LSHomeSearchTableViewCell.h"
#import "LSCultureFinanceDetailViewController.h"//r融资需求详情
#import "LSCultureFinanceProductDetailViewController.h"// 金融产品详情
#import "LSOfficeRentDetailViewController.h"//出租
#import "LSNeedOfficeRentDetaiViewController.h"//求租
#import "LSTestDynamicDetailViewController.h"//实验区动态
#import "LSPolicyInformationViewController.h"//政策资讯



#define LSHomeSearchTableViewCellID @"LSHomeSearchTableViewCellid"

@interface LSHomeSearchViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *MyTableV;
@property (weak, nonatomic) IBOutlet UIView *searchV;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@end

@implementation LSHomeSearchViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    
    // Do any additional setup after loading the view from its nib.
    self.dataSourceArr = [NSMutableArray arrayWithCapacity:0];

    self.MyTableV.hidden = YES;
    UIView *TFLeftV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, 30)];
    
    UIView *LeftSpaceV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 30)];
    [TFLeftV addSubview:LeftSpaceV];
    
    UIImageView *searchImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"搜索"]];
    searchImgV.frame = CGRectMake(5, 8, 15, 15);
    [TFLeftV addSubview:searchImgV];
    
    self.searchTF.leftView = TFLeftV;
    _searchTF.leftViewMode = UITextFieldViewModeAlways;
    //注册cell
    [self.MyTableV registerNib:[UINib nibWithNibName:@"LSHomeSearchTableViewCell" bundle:nil] forCellReuseIdentifier:LSHomeSearchTableViewCellID];
    
}

- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark @ UITableViewDataSource && UITableViewDelegate @
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.MyTableV.hidden == YES) {
        return 0;
    } else {
        return self.dataSourceArr.count;
    }
    
}

//返回cell高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.MyTableV.estimatedRowHeight = self.MyTableV.rowHeight;
    self.MyTableV.rowHeight = UITableViewAutomaticDimension;
    return self.MyTableV.rowHeight;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    LSHomeSearchTableViewCell *cell = [self.MyTableV dequeueReusableCellWithIdentifier:LSHomeSearchTableViewCellID forIndexPath:indexPath];
    
    [cell buildingHomeSearchWithModel:self.dataSourceArr[indexPath.row]];
    
    //去掉分割线
    self.MyTableV.separatorStyle = UITableViewCellSelectionStyleNone;
        
    return cell;
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSHomeSearchModel *model = self.dataSourceArr[indexPath.row];
    NSInteger typeid = [model.itemTypeId integerValue];
    switch (typeid) {
        case 1: {
            NSLog(@"文化金融");
            LSCultureFinanceProductDetailViewController *wenhuacntl = [[LSCultureFinanceProductDetailViewController alloc]init];
            wenhuacntl.Id = model.Id;
            wenhuacntl.itemTypeId = @"1";
            [self.navigationController pushViewController:wenhuacntl animated:YES];
        }
            break;
        case 2: {
            NSLog(@"融资");
            LSCultureFinanceDetailViewController *rongzicntl = [[LSCultureFinanceDetailViewController alloc]init];
            rongzicntl.Id = model.Id;
            rongzicntl.itemTypeId = @"2";
            [self.navigationController pushViewController:rongzicntl animated:YES];
        }
            break;
        case 3: {
            NSLog(@"出租");
            LSOfficeRentDetailViewController *chuzucntl = [[LSOfficeRentDetailViewController alloc]init];
            chuzucntl.Id = model.Id;
            chuzucntl.itemTypeId = @"3";
            [self.navigationController pushViewController:chuzucntl animated:YES];
        }
            break;
        case 4: {
            NSLog(@"求租");
            LSNeedOfficeRentDetaiViewController *qiuzucntl = [[LSNeedOfficeRentDetaiViewController alloc]init];
            qiuzucntl.Id = model.Id;
            qiuzucntl.itemTypeId = @"4";
            [self.navigationController pushViewController:qiuzucntl animated:YES];
        }
            break;
        case 5: {
            NSLog(@"实验区动态");
            LSTestDynamicDetailViewController *wenhuacntl = [[LSTestDynamicDetailViewController alloc]init];
            wenhuacntl.Id = model.Id;
            [self.navigationController pushViewController:wenhuacntl animated:YES];
        }
            break;
        case 6: {
            NSLog(@"政策资讯");
            LSTestDynamicDetailViewController *zhencecntl = [[LSTestDynamicDetailViewController alloc]init];
            zhencecntl.Id = model.Id;
            [self.navigationController pushViewController:zhencecntl animated:YES];
        }
            break;
            
        default:
            break;
    }
}


- (void)SearchHTTPS:(NSString *)searchKey {
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:searchKey forKey:@"keyword"];
    [[HRRequestManager manager] GET_PATH:Search para:para success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            
           /*
            {
            ds =     (
            {
            Id = 55;
            itemTypeId = 5;
            publishdate = "2009/12/8 17:03:56";
            title = "\U68a6\U516c\U56ed\U6751\U843d\U6caa\U5317\U4eac \U671d\U9633\U5c06\U5174\U5efa12\U5ea7\U4e3b\U9898\U5267\U573a";
            }
            );
            errMsg = "";
            success = 1;
            totalPageNo = 1;
            }
            */
            NSDictionary * dic = (NSDictionary *)responseObject;
            NSString *success = [dic objectForKey:@"success"];
            
            if ([success isEqualToString:@"1"])
            {
                [self.dataSourceArr removeAllObjects];
                NSArray *dsArr = dic[@"ds"];
                if (dsArr.count > 0) {
                    for (NSDictionary *dataDic in dsArr) {
                        LSHomeSearchModel *model = [[LSHomeSearchModel alloc]initWithDictionary:dataDic];
                        [self.dataSourceArr addObject:model];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        _MyTableV.hidden = NO;
                        [_MyTableV reloadData];
                    });
                    
                } else {
                    self.MyTableV.hidden = YES;
                    NSLog(@"没有数据");
                }
            
            }
            
        }
        
    } failure:^(NSError *error) {
       
        
    }];
}
#pragma mark  ========UITextFieldDelegate============

//开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.returnKeyType = UIReturnKeySearch;
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self SearchHTTPS:textField.text];
    return YES;
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
