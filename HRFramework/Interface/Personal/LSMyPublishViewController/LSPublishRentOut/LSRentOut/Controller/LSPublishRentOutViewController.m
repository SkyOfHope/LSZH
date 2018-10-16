//
//  LSPublishRentOutViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/20.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSPublishRentOutViewController.h"

#import "LSPublishRentOutCell.h"
#define CELL_PublishRentOut  @"PublishRentOutCell"

#import "LSPublishRentOutHeaderView.h"
#import "LSPublishRentOutFooterView.h"

@interface LSPublishRentOutViewController ()

@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;

@property (strong, nonatomic) LSPublishRentOutHeaderView *rentOutHeader;
@property (strong, nonatomic) LSPublishRentOutFooterView *rentOutFooter;

/**
 *  tableView 数据源
 */
@property (strong,nonatomic) NSArray *dataSourceArr;


@end

@implementation LSPublishRentOutViewController

-(LSPublishRentOutHeaderView *)rentOutHeader{
    if (!_rentOutHeader) {
        _rentOutHeader = [[NSBundle mainBundle] loadNibNamed:@"LSPublishRentOutHeaderView" owner:nil options:nil].lastObject;
    }
    
    return _rentOutHeader;
}

-(LSPublishRentOutFooterView *)rentOutFooter{
    if (!_rentOutFooter) {
        _rentOutFooter = [[NSBundle mainBundle] loadNibNamed:@"LSPublishRentOutFooterView" owner:nil options:nil].lastObject;
    }
    
    return _rentOutFooter;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.dataSourceArr = @[@"基本信息",@"建筑信息",@"设施配套信息",@"交通配套信息",@"备注信息"];
    
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSPublishRentOutCell" bundle:nil] forCellReuseIdentifier:CELL_PublishRentOut];
    
    self.myCustomTableView.tableHeaderView = self.rentOutHeader;
    self.myCustomTableView.tableFooterView = self.rentOutFooter;
    
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
    
    LSPublishRentOutCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_PublishRentOut forIndexPath:indexPath];
    
    cell.leftLabel.text = self.dataSourceArr[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
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
