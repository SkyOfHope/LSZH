//
//  LSPersonalFinaceNeedsViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/24.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSPersonalFinaceNeedsViewController.h"

#import "LSFinanceNeedsCell.h"
#define CELL_FinanceNeeds  @"FinanceNeedsCell"


@interface LSPersonalFinaceNeedsViewController ()

@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;

@end

@implementation LSPersonalFinaceNeedsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"发布的融资需求信息";
    
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSFinanceNeedsCell" bundle:nil] forCellReuseIdentifier:CELL_FinanceNeeds];

    
}

#pragma mark @ UITableViewDataSource && UITableViewDelegate @
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
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
    
    LSFinanceNeedsCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_FinanceNeeds forIndexPath:indexPath];
    
    
    //去掉分割线
    self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //cell点击变色
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%@",indexPath);
    
    
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
