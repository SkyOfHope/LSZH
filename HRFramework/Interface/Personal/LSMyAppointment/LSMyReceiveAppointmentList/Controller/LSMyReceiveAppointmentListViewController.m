
//
//  LSMyReceiveAppointmentListViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSMyReceiveAppointmentListViewController.h"

#import "LSMyReceiveAppointmentListCell.h"
#define CELL_MyReceiveAppointmentList  @"MyReceiveAppointmentListCell"

#import "LSAppointmentDetailViewController.h"
#import "LSShouDaoYueTanModel.h"

@interface LSMyReceiveAppointmentListViewController ()<LSMyReceiveAppointmentListCellDelegate,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;
@property (nonatomic, strong) NSMutableArray *DataArr;

@end

@implementation LSMyReceiveAppointmentListViewController

#pragma mark - ||========== LifeCycle ===========||
// 视图加载完毕
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"我收到的";
    
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSMyReceiveAppointmentListCell" bundle:nil] forCellReuseIdentifier:CELL_MyReceiveAppointmentList];
    self.DataArr = [NSMutableArray array];
    [self DataHTTPS];
    
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.DataArr.count;
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
    
    LSMyReceiveAppointmentListCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_MyReceiveAppointmentList forIndexPath:indexPath];
    
    //cell点击变色
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //去掉分隔线
    self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    cell.delegate = self;
    
    
    cell.shoudaoyuetan = self.DataArr[indexPath.row];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    


    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    LSShouDaoYueTanModel *yuetan = self.DataArr[indexPath.row];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];

    [para setObject:self.itemId forKey:@"itemId"];
    [para setObject:self.itemTypeId forKey:@"itemTypeId"];
    [para setObject:yuetan.userId forKey:@"userId"];
    
    [[HRRequestManager manager] GET_PATH:PATH_DeleteAppointmentITake para:para success:^(id responseObject) {
        
        if ([responseObject[@"success"] boolValue] == 1) {
            NSLog(@"删除成功");
        }else{
            NSLog(@"删除失败");
        }
    } failure:^(NSError *error) {
        NSLog(@"网络问题");
    }];
    
    [self.DataArr removeObjectAtIndex:indexPath.row];
    
    [self.myCustomTableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationLeft];

}


- (void) DataHTTPS {
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    
    [para setObject:userId forKey:@"userId"];
    [para setObject:self.itemTypeId forKey:@"itemTypeId"];
    [para setObject:self.itemId forKey:@"itemId"];
    
    [[HRRequestManager manager] GET_PATH:PATH_GetUserMeetUsers para:para success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            /*
             {
             ds =     (
             {
             headImg = "http://www.wcsyq.gov.cnhttp://www.wcsyq.gov.cn/upload/2016-06/20160608180731271.jpeg";
             maxDate = "2016/6/3 17:01:07";
             mobile = 13311242565;
             name = "";
             organizationName = "";
             userId = 4;
             userTypeId = 4;
             userTypeName = "个人";
             }
             );
             errMsg = "";
             success = 1;
             }
             */
            
            if ([responseObject[@"success"] boolValue] == 1) {
                
                [self.DataArr removeAllObjects];
                
                NSArray *data = [responseObject objectForKey:@"ds"];
            
                for (NSDictionary *dataDic in data) {
                    LSShouDaoYueTanModel *shoudaoModel = [[LSShouDaoYueTanModel alloc]initWithDictionary:dataDic];
                    [self.DataArr addObject:shoudaoModel];
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [_myCustomTableView reloadData];//刷新
                    
                });
            }
            
        }
        
    } failure:^(NSError *error) {
        
        
    }];


}


//详情按钮 点击后进入详情页

-(void)toDetailContrillerWithModel:(LSShouDaoYueTanModel *)model{
    
    LSAppointmentDetailViewController *appointmentDetail = [[LSAppointmentDetailViewController alloc] initWithNibName: @"LSAppointmentDetailViewController" bundle:nil];
    
    appointmentDetail.itemTypeId = self.itemTypeId;
    appointmentDetail.itemId = self.itemId;
    appointmentDetail.style = @"2";
    appointmentDetail.chuanruCanshuShoudaoYueTan = model;
    
    [self.navigationController pushViewController:appointmentDetail animated:nil];
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    self.reloadRedPointBlock();
    
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
