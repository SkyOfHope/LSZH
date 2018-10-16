//
//  LSBaseInformationViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/6/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSBaseInformationViewController.h"

#import "LSBaseInformtionCell.h"
#import "LStotalCompeleteModel.h"
#define CELL_BaseInformtion  @"BaseInformtionCell"

@interface LSBaseInformationViewController ()<jibenxinxiDelegate>

@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;
@property (nonatomic, strong) LStotalCompeleteModel *totalmodel;

@end

@implementation LSBaseInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"基本信息";
    
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSBaseInformtionCell" bundle:nil] forCellReuseIdentifier:CELL_BaseInformtion];
    
    
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
    
    LSBaseInformtionCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_BaseInformtion forIndexPath:indexPath];
    cell.delegate = self;
    //去掉分割线
    self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //cell点击变色
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    LStotalCompeleteModel *model = [LStotalCompeleteModel shareInstance];
    
    
    if (model.louyu.length > 0) {
        cell.louyuTF.text = model.louyu;
        if (model.louhao.length > 0){
            cell.louhaotf.text = model.louhao;
            if (model.louceng.length > 0){
                cell.loucengTF.text = model.louceng;
                if (model.mianji.length > 0){
                    cell.mianjiTF.text = model.mianji;
                    if (model.chaoxiang.length > 0){
                        cell.chaoxiangTF.text = model.chaoxiang;
                        if (model.zhuangxiu.length > 0){
                            cell.zhuangxiuTF.text = model.zhuangxiu;
                            if (model.qizu.length > 0){
                                cell.qizuTF.text = model.qizu;
                                if (model.rizujin.length > 0){
                                    cell.rizujinTF.text = model.rizujin;
                                    if (model.yuezujin.length > 0){
                                        cell.yuezujinTF.text = model.yuezujin;
                                        if (model.mianzuqi.length > 0){
                                            cell.mianzuqiTF.text = model.mianzuqi;
                                            if (model.sheshi.length > 0){
                                                cell.sheshiTF.text = model.sheshi;
                                                if (model.diliweizhi.length > 0) {
                                                    cell.diliweizhi.text = model.diliweizhi;
                                                    if (model.detailAddress.length > 0) {
                                                        cell.detailAddress.text = model.detailAddress;
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

- (void)jibenxinxi:(LStotalCompeleteModel *)model {
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
