//
//  LSBuildInformationViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/6/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBuildInformationViewController.h"

#import "LSBuildInformationCell.h"
#import "LStotalCompeleteModel.h"
#define CELL_BuildInformation  @"BuildInformationCell"

@interface LSBuildInformationViewController ()<jianzhuxinxiDelegate>
@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;
@property (nonatomic, strong) LStotalCompeleteModel *totalmodel;


@end

@implementation LSBuildInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"建筑信息";
    
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSBuildInformationCell" bundle:nil] forCellReuseIdentifier:CELL_BuildInformation];

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

//返回cell高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.myCustomTableView.estimatedRowHeight = self.myCustomTableView.rowHeight;
    self.myCustomTableView.rowHeight = UITableViewAutomaticDimension;
    return self.myCustomTableView.rowHeight;
}




-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSBuildInformationCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_BuildInformation forIndexPath:indexPath];
    cell.delegate = self;
    //去掉分割线
    self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //cell点击变色
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    /*
     @property (nonatomic, copy)NSString *jianzhuleixing;
     @property (nonatomic, copy)NSString *jianzhumianji;
     @property (nonatomic, copy)NSString *jingcenggao;
     @property (nonatomic, copy)NSString *wuyejibie;
     @property (nonatomic, copy)NSString *ruzhushijian;
     @property (nonatomic, copy)NSString *kaifashang;
     @property (nonatomic, copy)NSString *shejidanwei;
     @property (nonatomic, copy)NSString *shigongdanwei;
     @property (nonatomic, copy)NSString *diliweizhi;
     */
    
    LStotalCompeleteModel *model = [LStotalCompeleteModel shareInstance];
    
    if (model.jianzhuleixing.length > 0) {
        cell.jianzhuleixingTF.text = model.jianzhuleixing;
        if (model.jianzhumianji.length > 0){
            cell.jianzhumianjiTF.text = model.jianzhumianji;
            if (model.jingcenggao.length > 0){
                cell.jingcenggaoTF.text = model.jingcenggao;
                if (model.wuyejibie.length > 0){
                    cell.wuyejibieTF.text = model.wuyejibie;
                    if (model.ruzhushijian.length > 0){
                        cell.ruzhushijianTF.text = model.ruzhushijian;
                        if (model.kaifashang.length > 0){
                            cell.kaifashangTF.text = model.kaifashang;
                            if (model.shejidanwei.length > 0){
                                cell.shejidanweiTF.text = model.shejidanwei;
                                if (model.shigongdanwei.length > 0){
                                    cell.shigongdanweiTF.text = model.shigongdanwei;
                                    if (model.diliweizhi.length > 0){
//                                        cell.diliweizhi.text = model.diliweizhi;
                                        if (model.detailAddress.length > 0) {
                                            cell.detailTextLabel.text = model.detailAddress;
                                        }else{
                                            
                                        }
                                        
                                    }
                                }else{
                                }
                            }else{
                            }
                        }else{
                        }
                    }else{
                    }
                }else{
                }
            }else{
            }
        }else{
        }
    }else{
    }

    return cell;
}

- (void)jianzhuxinxi:(LStotalCompeleteModel *)model {

    [self.navigationController popViewControllerAnimated:YES];
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
