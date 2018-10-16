//
//  LSMyInfomationViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/19.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSMyInfomationViewController.h"

#import "LSMyInformationCell.h"
#define CELL_MyInformation  @"MyInformationCell"

#import "LSMyInformationChangeViewController.h"

#import "LSMyInformationChangeSencondViewController.h"

#import "LSMyInformationThirdTableViewCell.h"

#import "LSChangeHeaderView.h"

#import "LSMyInformationChangeLicenseImageViewController.h"

#import "LSMyInformationChangeAddressViewController.h"

@interface LSMyInfomationViewController ()<UITableViewDelegate,LSMyInformationChangeViewControllerDelegate,LSMyInformationChangeSencondViewControllerDelegate,LSMyInformationThirdTableViewCellDelegate,LSMyInformationChangeLicenseImageViewControllerDelegate,LSMyInformationChangeAddressViewControllerDelegate>



@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;

/**
 *  tableView 数据源
 */
@property (strong, nonatomic) NSMutableArray *dataSourceArr;
@property (strong,nonatomic) NSArray *AdataSourceArr;
@property (strong,nonatomic) NSArray *BdataSourceArr;
@property (strong,nonatomic) NSArray *CdataSourceArr;
@property (strong,nonatomic) NSArray *DdataSourceArr;

@property (strong,nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) NSString *imgPathStr;

@end

@implementation LSMyInfomationViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的资料";
    
    [self requestGetUserInfo];
    
    self.dataArray = [NSMutableArray array];
    
    //取出用户类型,根据用户类型判断进入那种界面
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    
    NSInteger userTypeId = [[userdefault objectForKey:@"userTypeId"] integerValue];

    if (userTypeId == 1) {
        //园区
        self.AdataSourceArr = @[@"园区名称",@"组织机构代码",@"机构负责人"];
        self.BdataSourceArr = @[@"园区注册地区",@"邮箱"];
        self.CdataSourceArr = @[@"园区介绍"];
        self.DdataSourceArr = @[@"营业执照副本或组织机构代码证"];
    }else if (userTypeId == 2){
        //企业
        self.AdataSourceArr = @[@"企业名称",@"营业执照注册号",@"企业负责人"];
        self.BdataSourceArr = @[@"企业注册地区",@"邮箱"];
        self.CdataSourceArr = @[@"企业介绍"];
        self.DdataSourceArr = @[@"营业执照副本或组织机构代码证"];
    }else if (userTypeId == 3){
        //金融
        self.AdataSourceArr = @[@"机构名称",@"组织机构代码",@"机构负责人"];
        self.BdataSourceArr = @[@"机构注册地区",@"邮箱"];
        self.CdataSourceArr = @[@"企业介绍"];
        self.DdataSourceArr = @[@"营业执照副本或组织机构代码证"];
    }else{
        return;
    }
    
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSMyInformationCell" bundle:nil] forCellReuseIdentifier:CELL_MyInformation];
    
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSMyInformationThirdTableViewCell" bundle:nil] forCellReuseIdentifier:identifierForThirdCell];
    
    
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


#pragma mark @ UITableViewDataSource && UITableViewDelegate @
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return self.AdataSourceArr.count;
    }else if (section == 1){
        
        return self.BdataSourceArr.count;
    }else if (section == 2){
        
        return self.CdataSourceArr.count;
    }else if (section == 3){
        return self.DdataSourceArr.count;
    }
    
    return section;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2 ) {
        
//        NSArray *dataArray = self.totalArray[indexPath.section];
//        
//        NSString *temp = dataArray[0];
//        
//        CGFloat guding = 76 + 27;
//        
//        CGSize sizeForL = [temp boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - guding, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size;
//        
//        
//        return sizeForL.height + 2 * 18;
        
        return 50;
        
    }else if (indexPath.section == 3){
        
        return 70;
    }else{
        
        return 50;
    }
    
}


static NSString *identifierForThirdCell = @"thirdCellIdeitifier";

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section >= 0 && indexPath.section < 3) {
    
        LSMyInformationCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_MyInformation forIndexPath:indexPath];
        
//        if (!cell) {
//            cell = [[[NSBundle mainBundle]loadNibNamed:@"LSMyInformationCell" owner:nil options:nil]lastObject];
//        }
        
        
        
        //    cell.name.text = self.dataSourceArr[indexPath.row];
        switch (indexPath.section) {
            case 0:{
                NSLog(@"企业名称,营业执照注册号,机构负责人");
                
                cell.leftLabel.text = self.AdataSourceArr[indexPath.row];
                
                NSArray *dataArray = self.totalArray[indexPath.section];
                
                cell.rightLabel.text = dataArray[indexPath.row];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
                break;
            case 1:{
                NSLog(@"园区注册地,邮箱");
                
                cell.leftLabel.text = self.BdataSourceArr[indexPath.row];
                
                NSArray *dataArray = self.totalArray[indexPath.section];
                
                cell.rightLabel.text = dataArray[indexPath.row];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
                break;
            case 2:{
                NSLog(@"园区介绍");
                cell.leftLabel.text = self.CdataSourceArr[indexPath.row];
                
                NSArray *dataArray = self.totalArray[indexPath.section];
                
                cell.rightLabel.text = dataArray[indexPath.row];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                ;
            }
                break;
                
            default:
                break;
        }
        
        return cell;

        
    }else{
    
        
        LSMyInformationThirdTableViewCell *cellT = [self.myCustomTableView dequeueReusableCellWithIdentifier:identifierForThirdCell forIndexPath:indexPath];
        
        cellT.delegate = self;
        
        UIImageView *imageView = [[UIImageView alloc]init];
        
        if (self.totalArray.count > indexPath.section) {
            
            NSURL *urlForImage = [NSURL URLWithString:self.totalArray[indexPath.section][indexPath.row]];
            
            [imageView sd_setImageWithURL:urlForImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [cellT setIMageWithControllerSource:imageView.image];
            }];

        }

        return cellT;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%@",indexPath);
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                LSMyInformationChangeViewController *changeInformationVC = [[LSMyInformationChangeViewController alloc] initWithNibName:@"LSMyInformationChangeViewController" bundle:nil];
                
                NSString *detail = self.totalArray[indexPath.section][indexPath.row];
                
                changeInformationVC.detailtext = detail;
                changeInformationVC.changeId = 11;
                changeInformationVC.delegate = self;
                changeInformationVC.hiddenWaringLabel = 5;
                [self.navigationController pushViewController:changeInformationVC animated:YES];
            
            }
                break;
            case 1:{
                LSMyInformationChangeViewController *changeInformationVC = [[LSMyInformationChangeViewController alloc] initWithNibName:@"LSMyInformationChangeViewController" bundle:nil];
                
                NSString *detail = self.totalArray[indexPath.section][indexPath.row];
                
                changeInformationVC.detailtext = detail;
                changeInformationVC.changeId = 12;
                changeInformationVC.delegate = self;
                changeInformationVC.hiddenWaringLabel = 5;
                [self.navigationController pushViewController:changeInformationVC animated:YES];
            }
                break;
            case 2:{
                NSLog(@"园区介绍");
                LSMyInformationChangeViewController *changeInformationVC = [[LSMyInformationChangeViewController alloc] initWithNibName:@"LSMyInformationChangeViewController" bundle:nil];
                
                NSString *detail = self.totalArray[indexPath.section][indexPath.row];
                
                changeInformationVC.detailtext = detail;
                changeInformationVC.changeId = 13;
                changeInformationVC.delegate = self;
                [self.navigationController pushViewController:changeInformationVC animated:YES];
            }
                break;
            default:
                break;
        }

        
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:{
                NSLog(@"企业名称,营业执照注册号,机构负责人");
                LSMyInformationChangeAddressViewController *changeInformationVC = [[LSMyInformationChangeAddressViewController alloc] initWithNibName:@"LSMyInformationChangeAddressViewController" bundle:nil];
                
                NSString *detail = self.totalArray[indexPath.section][indexPath.row];
                
//                changeInformationVC.passArea =
//                changeInformationVC.passCity =
//                changeInformationVC.passProvince =
                changeInformationVC.passAddress = self.dataArray;
                
                
                changeInformationVC.detailtext = detail;
                changeInformationVC.delegate = self;
                [self.navigationController pushViewController:changeInformationVC animated:YES];
            }
                break;
            case 1:{
                NSLog(@"园区注册地,邮箱");
                LSMyInformationChangeViewController *changeInformationVC = [[LSMyInformationChangeViewController alloc] initWithNibName:@"LSMyInformationChangeViewController" bundle:nil];
                
                NSString *detail = self.totalArray[indexPath.section][indexPath.row];
                
                changeInformationVC.detailtext = detail;
                changeInformationVC.changeId = 22;
                changeInformationVC.delegate = self;
                [self.navigationController pushViewController:changeInformationVC animated:YES];

            }
                break;
            
            default:
                break;
        }

        
    }else if (indexPath.section == 2){
        
        switch (indexPath.row) {
            case 0:{
                NSLog(@"企业名称,营业执照注册号,机构负责人");
                LSMyInformationChangeSencondViewController *changeInformationVC = [[LSMyInformationChangeSencondViewController alloc] initWithNibName:@"LSMyInformationChangeSencondViewController" bundle:nil];
                
                NSString *detail = self.totalArray[indexPath.section][indexPath.row];
                
                changeInformationVC.detailtext = detail;
                
                changeInformationVC.delegate = self;
                
                [self.navigationController pushViewController:changeInformationVC animated:YES];
            }
                break;
            
            default:
                break;
        }

    }else if (indexPath.section == 3){
        
        LSMyInformationChangeLicenseImageViewController *licenseVC = [[LSMyInformationChangeLicenseImageViewController alloc]initWithNibName:@"LSMyInformationChangeLicenseImageViewController" bundle:nil];
        if (self.imgPathStr.length > 0) {
            licenseVC.orginImageUrl = self.imgPathStr;
        }
    
        licenseVC.delegate = self;
        
        [self.navigationController pushViewController:licenseVC animated:YES];
        
    }
    
}


-(void)getImage:(UIImage *)image ORImagePath:(NSString *)imagePath{
    
    if (image) {
        
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:3];
        
        LSMyInformationThirdTableViewCell *cell = [self.myCustomTableView cellForRowAtIndexPath:index];
        
        [cell setIMageWithControllerSource:image];
    }
    
    if (imagePath.length > 0) {
        self.imgPathStr = imagePath;
    }
    
    
}

#pragma mark - ||==========数据请求===========||



-(void)requestGetUserInfo{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    
    [para setObject:userId forKey:@"userId"];
    
    
    [[HRRequestManager manager] GET_PATH:PATH_GetUserInfo para:para success:^(id responseObject) {
        
        if ([responseObject[@"success"] boolValue] == 1) {
            
            NSLog(@"%@",responseObject);
            NSLog(@"请求成功");
            
            NSDictionary *totalDataDict = responseObject[@"ds"];
            
            NSArray *array1 = [NSArray arrayWithObjects:totalDataDict[@"organizationName"],totalDataDict[@"licenseCode"] ,totalDataDict[@"principalName"],nil];
            
            NSString *cityAndAera = [NSString stringWithFormat:@"%@%@%@",totalDataDict[@"province"],totalDataDict[@"city"],totalDataDict[@"county"]];
            
            self.dataArray = [NSMutableArray arrayWithObjects:totalDataDict[@"province"],totalDataDict[@"city"] ,totalDataDict[@"county"],totalDataDict[@"address"],nil];
            
            
            NSArray *array2 = [NSArray arrayWithObjects:cityAndAera,totalDataDict[@"email"], nil];
            
            NSArray *array3 = [NSArray arrayWithObject:totalDataDict[@"remark"]];
            
            NSArray *array4 = [NSArray arrayWithObject:totalDataDict[@"licenseImg"]];
            
            self.imgPathStr = totalDataDict[@"licenseImg"];
            
            self.totalArray = [NSArray arrayWithObjects:array1,array2,array3,array4, nil];
            
            
            [self.myCustomTableView reloadData];
            
            
        }else{
            NSLog(@"请求失败");
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

#pragma mark --- 修改数据后返回刷新

-(void)reloadNewinformation{
    [self requestGetUserInfo];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
