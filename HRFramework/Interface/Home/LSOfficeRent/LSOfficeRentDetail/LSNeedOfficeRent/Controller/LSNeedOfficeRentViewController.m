//
//  LSNeedOfficeRentViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/23.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSNeedOfficeRentViewController.h"

#import "LSNeedOfficeRentCell.h"
#define CELL_NeedOfficeRent  @"NeedOfficeRentCell"



@interface LSNeedOfficeRentViewController ()
@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;

@property (strong, nonatomic) UIButton *selectBtn;

@end

@implementation LSNeedOfficeRentViewController

#pragma mark - ||========== LifeCycle ===========||
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSNeedOfficeRentCell" bundle:nil] forCellReuseIdentifier:CELL_NeedOfficeRent];
    
}

#pragma mark - ||========== IBActions ===========||
- (IBAction)ButtonAction:(UIButton *)sender {
    
    self.selectBtn.selected = NO;
    self.selectBtn = sender;
    sender.selected = YES;
    
    switch (sender.tag) {
        case 1:
            NSLog(@"NNNNN地理位置地理位置地理位置地理位置地理位置地理位置");
            break;
        case 2:
            NSLog(@"NNNNN面积面积面积面积面积");
            break;
        case 3:
            NSLog(@"NNNNN日租金日租金日租金日租金日租金");
            break;
        case 4:
            NSLog(@"NNNNN起租日期起租日期起租日期起租日期起租日期");
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
    
    LSNeedOfficeRentCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_NeedOfficeRent forIndexPath:indexPath];
    
    //去掉分割线
    self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //cell点击变色
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"cell点击");
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
