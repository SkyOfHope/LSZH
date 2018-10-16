//
//  LSMyInfomationPersonalViewController.m
//  LSZH
//
//  Created by apple  on 16/6/14.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSMyInfomationPersonalViewController.h"

#import "LSMyInformationCell.h"

#import "LSMyInformationChangeViewController.h"

@interface LSMyInfomationPersonalViewController ()<UITableViewDataSource,UITableViewDelegate,LSMyInformationChangeViewControllerDelegate>


@property (strong, nonatomic) NSArray *dataSource;

@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@property (strong, nonatomic) NSArray *informationArr;

@end

@implementation LSMyInfomationPersonalViewController

static NSString *cellIdentifier = @"MyInformation";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = @[@"真实姓名",@"性别",@"昵称"];
    
    [self.customTableView registerNib:[UINib nibWithNibName:@"LSMyInformationCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    [self requestGetUserInfo];
    
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


//添加数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
    
}


-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];
    
    return view;
}

//返回cell高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.customTableView.estimatedRowHeight = self.customTableView.rowHeight;
    self.customTableView.rowHeight = UITableViewAutomaticDimension;
    return self.customTableView.rowHeight;
    
}



//个人信息数据加载
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSMyInformationCell *cell = [self.customTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
   
    cell.leftLabel.text = self.dataSource[indexPath.row];
    
    cell.rightLabel.text = self.informationArr[indexPath.row];
    
    //去掉分割线
    self.customTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    return cell;
}

//点击cell跳转控制器发送更改请求
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%@",indexPath);
    
    LSMyInformationChangeViewController *changeInformationVC = [[LSMyInformationChangeViewController alloc] initWithNibName:@"LSMyInformationChangeViewController" bundle:nil];
    
    NSString *detail = self.informationArr[indexPath.row];
    
    switch (indexPath.row) {
        case 0:
            changeInformationVC.detailtext = detail;
            changeInformationVC.changeId = 41;
            changeInformationVC.delegate = self;
            [self.navigationController pushViewController:changeInformationVC animated:YES];
            break;
        case 1:
            changeInformationVC.detailtext = detail;
            changeInformationVC.changeId = 42;
            changeInformationVC.delegate = self;
            [self.navigationController pushViewController:changeInformationVC animated:YES];
            break;
        case 2:
            changeInformationVC.detailtext = detail;
            changeInformationVC.changeId = 43;
            changeInformationVC.delegate = self;
            [self.navigationController pushViewController:changeInformationVC animated:YES];
            break;
            
        default:
            break;
    }
    
}


#pragma mark - ||==========数据请求===========||
-(void)requestGetUserInfo{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    
//    [para setObject:@"4" forKey:@"userId"];
    [para setObject:userId forKey:@"userId"];
    
    [[HRRequestManager manager] GET_PATH:PATH_GetUserInfo para:para success:^(id responseObject) {
        
        if ([responseObject[@"success"] boolValue] == 1) {
            
            
            NSLog(@"%@",responseObject);
            NSLog(@"请求成功");
            
            NSDictionary *totalDataDict = responseObject[@"ds"];
            
            self.informationArr = [NSArray arrayWithObjects:totalDataDict[@"realname"],totalDataDict[@"sex"],totalDataDict[@"nickname"], nil];
            
            [self.customTableView reloadData];
            
            
        }else{
            NSLog(@"请求失败");
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

//代理方法,修改成功后返回界面重新请求数据并刷新
-(void)reloadNewinformation{
    [self requestGetUserInfo];
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
