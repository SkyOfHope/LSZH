//
//  LSMyAppointmetViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/20.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSMyAppointmetViewController.h"

#import "LSMyAppointmentCell.h"
#define CELL_MyAppointment  @"MyAppointmentCell"

#import "LSAppointmentDetailViewController.h"
#import "LSMyReceiveAppointmentListViewController.h"
#import "LSyuetanModel.h"
#import "LSSendYueTanModel.h"

@interface LSMyAppointmetViewController ()<UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;
@property (nonatomic, copy)NSString *MeetStr;
@property (nonatomic, strong) NSMutableArray *DataArr;

/**
 *  tableView 数据源
 */
@property (strong,nonatomic) NSArray *imgArr;

@property (strong, nonatomic) UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIButton *theOneBtn;



@end

@implementation LSMyAppointmetViewController

#pragma mark - ||========== LifeCycle ===========||
// 视图加载完毕
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"我的约谈"; 
    
    self.selectBtn = self.theOneBtn;
    self.selectBtn.selected = YES;
    
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSMyAppointmentCell" bundle:nil] forCellReuseIdentifier:CELL_MyAppointment];
    
    self.DataArr = [NSMutableArray arrayWithCapacity:10];
    self.MeetStr = PATH_GetUserMeetItem;
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
    
    LSMyAppointmentCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_MyAppointment forIndexPath:indexPath];
    //cell点击变色
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //去掉分隔线
    self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    
//    LSyuetanModel *model = self.DataArr[indexPath.row];
    
//    LSSendYueTanModel *model1 = self.DataArr[indexPath.row];
    
    //两种根据不同的选择 不同请求 返回不同类型的字段 不同的模型 对应不同的cell 因此报错
    
    //将两者区分即可
    
    if ([self.MeetStr isEqualToString: PATH_GetUserMeetItem]) {
        NSLog(@"我收到的");
        [cell buildingShouDaoYueTanWithModle:self.DataArr[indexPath.row]];
    }
    if ([self.MeetStr isEqualToString: PATH_GetUserSendMeet]) {
        NSLog(@"我发起的");
//        [cell buildingShouDaoYueTanWithModle:self.DataArr[indexPath.row]];
        [cell buildingfaqiYueTanWithModel:self.DataArr[indexPath.row]];
    }
    
   
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%@",indexPath);
    
    //需要区分添加点击事件 否则一样会报错
    
    if ([self.MeetStr isEqualToString: PATH_GetUserMeetItem]) {
        LSyuetanModel *ShouDaoModel = self.DataArr[indexPath.row];
        
        NSLog(@"我收到的--->列表");
        LSMyReceiveAppointmentListViewController *ListCntl = [[LSMyReceiveAppointmentListViewController alloc] init];
        ListCntl.itemId = ShouDaoModel.itemId;
        ListCntl.itemTypeId = ShouDaoModel.itemTypeId;
        
        //刷新数据之后取消小红点
        weakSelf(weakSelf);
        
        ListCntl.reloadRedPointBlock = ^{
            
            [weakSelf DataHTTPS];
            
        };

        [self.navigationController pushViewController:ListCntl animated:YES];
        
        
    }
    if ([self.MeetStr isEqualToString: PATH_GetUserSendMeet]) {
        LSSendYueTanModel *FaQiModel = self.DataArr[indexPath.row];
        
        NSLog(@"我发起的--->详情");
        LSAppointmentDetailViewController *DetailCntl = [[LSAppointmentDetailViewController alloc] init];
        DetailCntl.style = @"1";
        DetailCntl.meetId = FaQiModel.meetId;
        DetailCntl.itemId = FaQiModel.itemId;
        DetailCntl.itemTypeId = FaQiModel.itemTypeId;
        
        //刷新数据之后取消小红点
        weakSelf(weakSelf);
        DetailCntl.appointmentBlock = ^{
            
            [weakSelf DataHTTPS];
            
        };
    
        [self.navigationController pushViewController:DetailCntl animated:YES];
        
    }
    
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.MeetStr isEqualToString: PATH_GetUserSendMeet]) {
        return UITableViewCellEditingStyleDelete;
    }else{
        return UITableViewCellEditingStyleNone;
    }
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    NSLog(@"准备删除");

    if ([self.MeetStr isEqualToString: PATH_GetUserSendMeet]) {
        
        LSSendYueTanModel *FaQiModel = self.DataArr[indexPath.row];
        
        NSLog(@"我发起的--->详情");
        
        NSMutableDictionary *para = [NSMutableDictionary dictionary];
        
        NSInteger meetid = [FaQiModel.meetId integerValue];
        
        NSNumber *meetId = [NSNumber numberWithInteger:meetid];
        
        [para setObject:meetId forKey:@"meetId"];
        
        [[HRRequestManager manager]POST_PATH:PATH_DeleteAppoinmentFromMe para:para success:^(id responseObject) {
            
            if ([responseObject[@"success"] boolValue] == 1) {
                NSLog(@"删除成功");
            }else{
                NSLog(@"删除失败");
            }

        } failure:^(NSError *error) {
            
        }];
        
        [self.DataArr removeObjectAtIndex:indexPath.row];
        
        [self.myCustomTableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationLeft];
    }
    
}

- (IBAction)ButtonAction:(UIButton *)sender {
    
    self.selectBtn.selected = NO;
    self.selectBtn = sender;
    sender.selected = YES;
    
    switch (sender.tag) {
        case 1:{
            NSLog(@"我收到的");
            
            self.MeetStr = PATH_GetUserMeetItem;
            
            [self DataHTTPS];
            break;
        }
        case 2:{
            NSLog(@"我发起的");
            self.MeetStr = PATH_GetUserSendMeet;
          
            [self DataHTTPS];
            break;
        }

        default:
            break;
    }
    
    
}

- (void) DataHTTPS {
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    
    [para setObject:userId forKey:@"userId"];
    
    [[HRRequestManager manager] GET_PATH:self.MeetStr para:para success:^(id responseObject) {
        
        
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            /*
             {
             isWeiDu = 1;
             itemId = 1;
             itemTypeId = 1;
             maxDate = "2016/5/18 15:09:54";
             regDate = "2016/5/17 13:51:10";
             title = "测试数据";
             userTypeName = "园区";
             ziduan1 = "发行单位";
             ziduan2 = "关键词";
             ziduan3 = "";
             }
             */
            /*
             {
             fujianItemId = 1;
             fujianItemTypeId = 0;
             imgPath = "http://www.wcsyq.gov.cn/upload/2015-12/2015122522223.jpg";
             itemId = 13;
             itemTypeId = 2;
             meetId = 17;
             regDate = "2016/6/2 17:09:15";
             state = "\U672a\U67e5\U770b";
             title = ssss;
             ziduan1 = "\U662f\U7684\U662f";
             ziduan2 = "\U9a71\U868a\U5668";
             ziduan3 = "";
             }
             */
            if ([responseObject[@"success"] boolValue] == 1) {
                
                [self.DataArr removeAllObjects];
                
                NSArray *data = [responseObject objectForKey:@"ds"];
                
          
                for (NSDictionary *dataDic in data) {
                  
                    if ([self.MeetStr isEqualToString: PATH_GetUserMeetItem]) {
                        NSLog(@"我收到的");
                        LSyuetanModel *model = [[LSyuetanModel alloc]initWithDictionary:dataDic];
                        [self.DataArr addObject:model];
                    }
                    if ([self.MeetStr isEqualToString: PATH_GetUserSendMeet]) {
                        NSLog(@"我发起的");
                        LSSendYueTanModel *model = [[LSSendYueTanModel alloc]initWithDictionary:dataDic];
                        [self.DataArr addObject:model];
                    }
                    
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_myCustomTableView reloadData];//刷新
                });
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
