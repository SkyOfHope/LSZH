//
//  LSInsdustryViewController.m
//  LSZH
//
//  Created by xun.liu on 16/6/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSInsdustryViewController.h"
#import "LSInsdustryTableViewCell.h"
#define INSINSDUSTRYCELL @"insdustryTableViewCell"

@interface LSInsdustryViewController ()

@property (weak, nonatomic) IBOutlet UITableView *insdustryTableView;
@property (nonatomic, copy) NSMutableArray *insdustryArr;
@property (nonatomic, strong)NSArray *allindustrtArr;

@end

@implementation LSInsdustryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.allindustrtArr = @[
                            @"软件、网络及计算机服务",
                            @"新闻出版",
                            @"广播电视电影",
                            @"广告会展",
                            @"文化艺术",
                            @"旅游、休闲娱乐",
                            @"艺术品交易",
                            @"设计服务",
                            @"其他辅助服务"
                            ];
    [self.insdustryTableView registerNib:[UINib nibWithNibName:@"LSInsdustryTableViewCell" bundle:nil] forCellReuseIdentifier:INSINSDUSTRYCELL];
    self.insdustryTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.allindustrtArr.count;
}

////返回cell高度
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    self.insdustryTableView.estimatedRowHeight = self.insdustryTableView.rowHeight;
//    self.insdustryTableView.rowHeight = UITableViewAutomaticDimension;
//    return self.insdustryTableView.rowHeight;
//}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     LSInsdustryTableViewCell *cell = [self.insdustryTableView dequeueReusableCellWithIdentifier:INSINSDUSTRYCELL forIndexPath:indexPath];
    
    NSInteger i = indexPath.row;
    
    [cell.titleBtn setTitle:self.allindustrtArr[i] forState:UIControlStateNormal];
    
    if (cell.isSelected == YES) {
        [cell.titleBtn setTintColor:[UIColor blueColor]];
        cell.selectImg.hidden = NO;
    }
    if (cell.isSelected == NO) {
       [cell.titleBtn setTintColor:[UIColor darkGrayColor]];
        cell.selectImg.hidden = YES;
    }
    
    //去掉分割线
    self.insdustryTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSInsdustryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.selected = !cell.selected;
//    [self.insdustryTableView reloadData];
    [self.insdustryTableView setNeedsLayout];

}


//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    LSInsdustryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.selected = NO;
//    [self.insdustryTableView reloadData];
//}

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
