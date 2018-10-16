
//
//  LSPublishOfficeToRentViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSPublishOfficeToRentViewController.h"

#import "LSPublishOfficeToRentCell.h"

#define CELL_PublishOfficeToRent  @"PublishOfficeToRentCell"


@interface LSPublishOfficeToRentViewController () <qiuzuDelegate>
@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;
@property (nonatomic, strong) UIAlertView *alertV;

@end

@implementation LSPublishOfficeToRentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"发布办公求租信息";
    
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSPublishOfficeToRentCell" bundle:nil] forCellReuseIdentifier:CELL_PublishOfficeToRent];
    self.alertV = [[UIAlertView alloc]initWithTitle:@"发布"
                                            message:nil
                                           delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil, nil];
    
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
    
    LSPublishOfficeToRentCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_PublishOfficeToRent forIndexPath:indexPath];
    cell.delegate = self;
    //去掉分割线
    self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //cell点击变色
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%@",indexPath);
   
    
}

- (void)qiuzuAction:(LSrentModel *)model{

    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    
    [para setObject:userId forKey:@"userId"];
    
    //判断参数等是否正确
    //判断协议是否遵守
    if (model.title.length > 0 && model.area.length > 0 && model.areaMax.length > 0 && model.areaMin.length > 0 && model.rentMin.length > 0 && model.rentMax.length > 0 && model.peitaoSheshi.length > 0 && model.jiaotong.length > 0 && model.qizuDate.length > 0 && model.rentMax.length > 0) {
        if (model.protocolBtn) {
            
            [para setObject:model.title forKey:@"title"];
            [para setObject:model.area forKey:@"province"];
            [para setObject:model.area forKey:@"city"];
            [para setObject:model.area forKey:@"county"];
            [para setObject:model.area forKey:@"address"];
            
            [para setObject:model.areaMin forKey:@"sizeStart"];
            [para setObject:model.areaMax forKey:@"sizeEnd"];
            [para setObject:model.rentMin forKey:@"rizujinStart"];
            [para setObject:model.rentMax forKey:@"rizujinEnd"];
            [para setObject:model.peitaoSheshi forKey:@"peitaoSheshi"];
            [para setObject:model.jiaotong forKey:@"jiaotong"];
            [para setObject:model.qizuDate forKey:@"qizuDate"];
            [para setObject:model.remark forKey:@"companyRemark"];
            [para setObject:model.tips forKey:@"remark"];
            

            
            
            [[HRRequestManager manager] POST_PATH:PATH_AddWantHouse para:para success:^(id responseObject) {
                if ([responseObject isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary * dic = (NSDictionary *)responseObject;
                    NSString *success = [dic objectForKey:@"success"];
                    
                    if ([success isEqualToString:@"1"])
                    {
                        
                        [self.alertV setTitle:@"发布成功！"];
                        [_alertV show];
                        
                        [self.navigationController popToRootViewControllerAnimated:YES];
                        
                    } else {
                        [self.alertV setTitle:@"发布失败"];
                        [_alertV show];
                    }
                    
                }
                
            } failure:^(NSError *error) {
                [self.alertV setTitle:@"发布失败"];
                [_alertV show];
                
            }];
            
        }else{
            [self promptBox_YTC_GeneralWithWords:@"请勾选 保证上述信息真实有效"];
        }
    }else{
        [self promptBox_YTC_GeneralWithWords:@"请填写所有数据"];
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
