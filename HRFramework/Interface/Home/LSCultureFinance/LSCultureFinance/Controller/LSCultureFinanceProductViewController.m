
//
//  LSCultureFinanceProductViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSCultureFinanceProductViewController.h"

#import "LSCultureFinanceCell.h"
#define CELL_CultureFinance  @"CultureFinanceCell"

#import "LSCultureFinanceProductDetailViewController.h"

@interface LSCultureFinanceProductViewController ()

@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;

@property (strong, nonatomic) UIButton *selectBtn;

@end

@implementation LSCultureFinanceProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSCultureFinanceCell" bundle:nil] forCellReuseIdentifier:CELL_CultureFinance];

    
}

#pragma mark - ||========== IBActions ===========||
- (IBAction)ButtonAction:(UIButton *)sender {
    
    self.selectBtn.selected = NO;
    self.selectBtn = sender;
    sender.selected = YES;
    
    switch (sender.tag) {
        case 1:
            NSLog(@"所属行业所属行业所属行业所属行业所属行业所属行业");
            break;
        case 2:
            NSLog(@"所在地区所在地区所在地区所在地区所在地区所在地区");
            break;
        case 3:
            NSLog(@"融资方式融资方式融资方式融资方式融资方式融资方式");
            break;
        case 4:
            NSLog(@"融资金额融资金额融资金额融资金额融资金额融资金额");
            break;
            
        default:
            break;
    }
    
}


#pragma mark @ UITableViewDataSource && UITableViewDelegate @
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
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
    
    LSCultureFinanceCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_CultureFinance forIndexPath:indexPath];
    
    //去掉分割线
    self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSCultureFinanceProductDetailViewController *productDetailVC = [[LSCultureFinanceProductDetailViewController alloc] initWithNibName:@"LSCultureFinanceProductDetailViewController" bundle:nil];
    
    [self.navigationController pushViewController:productDetailVC animated:YES];
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
