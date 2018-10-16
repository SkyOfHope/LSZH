//
//  LSCultureFinanceViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/21.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSCultureFinanceViewController.h"

#import "LSCultureFinanceCell.h"
#define CELL_CultureFinance  @"CultureFinanceCell"

#import "LSFinanceProductsView.h"



@interface LSCultureFinanceViewController ()

@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;

@property (strong, nonatomic) LSFinanceProductsView *financeView;
@property (strong, nonatomic) UISegmentedControl *segmentedControl;


@end

@implementation LSCultureFinanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.segmentedControl = [ [ UISegmentedControl alloc ] initWithItems:nil];
    [ self.segmentedControl insertSegmentWithTitle:
     @"融资需求" atIndex: 0 animated: NO ];
    [ self.segmentedControl insertSegmentWithTitle:
     @"金融产品" atIndex: 1 animated: NO ];
    //默认选中的按钮索引
    self.segmentedControl.selectedSegmentIndex = 0;
    
    self.navigationItem.titleView = self.segmentedControl;
    
    [self.segmentedControl addTarget: self
                              action: @selector(controllerPressed:)
                    forControlEvents: UIControlEventValueChanged
     ];
    

    
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSCultureFinanceCell" bundle:nil] forCellReuseIdentifier:CELL_CultureFinance];
    
    
    
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
    
        return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



- (void) controllerPressed:(id)sender {
    NSInteger selectedSegment = self.segmentedControl.selectedSegmentIndex;
    if (selectedSegment == 1)
    {
//        [self replaceController:self.orderVC newController:self.integralVC];
        self.financeView = [[LSFinanceProductsView alloc]init];
        self.financeView.backgroundColor = RGBA(0, 0, 0, 0.5);
        
        self.financeView.layer.cornerRadius = 5;
        self.financeView.layer.masksToBounds = YES;
        [AppDelegate.window addSubview:self.financeView];
        
        
        self.financeView.frame = SCREEN_BOUNDS;
        
        
        
    }
    else
    {
//        [self replaceController:self.integralVC newController:self.orderVC];
        
        NSLog(@"asdfgh");
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
