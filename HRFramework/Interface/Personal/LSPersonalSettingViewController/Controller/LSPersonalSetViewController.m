//
//  LSPersonalSetViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/19.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSPersonalSetViewController.h"

#import "LSPersonalSetTableViewCell.h"
#define CELL_PersonalSet  @"PersonalSetCell"

#import "LSChangePasswordViewController.h"
#import "LSAboutMineViewController.h"

@interface LSPersonalSetViewController ()


@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;
/**
 *  tableView 数据源
 */
@property (strong,nonatomic) NSArray *dataSourceArr;


@end

@implementation LSPersonalSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置";
    
    self.dataSourceArr = @[@"修改密码",@"关于我们",@"版本检测",@"清除缓存"];
    
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSPersonalSetTableViewCell" bundle:nil] forCellReuseIdentifier:CELL_PersonalSet];
    
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
    
    LSPersonalSetTableViewCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_PersonalSet forIndexPath:indexPath];
    
    cell.name.text = self.dataSourceArr[indexPath.row];
       
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%@",indexPath);
    
    switch (indexPath.row) {
        case 0:{
            NSLog(@"修改密码");
            
            LSChangePasswordViewController *changePasswordVC = [[LSChangePasswordViewController alloc] initWithNibName:@"LSChangePasswordViewController" bundle:nil];
            
            [self.navigationController pushViewController:changePasswordVC animated:nil];
        }
            break;
        case 1:{
            NSLog(@"关于我们");
            
            LSAboutMineViewController *aboutMineVC = [[LSAboutMineViewController alloc] initWithNibName:@"LSAboutMineViewController" bundle:nil];
            
            [self.navigationController pushViewController:aboutMineVC animated:nil];
        }
            break;
        case 2:
            NSLog(@"123");
            break;
        case 3:
            NSLog(@"12345");
            break;
            
        default:
            break;
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
