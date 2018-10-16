//
//  LSHomeViewController.m
//  LSZH
//
//  Created by 穆英波 on 16/5/18.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSHomeViewController.h"

#import "LMADView.h"
#import "LSCultureFinanceViewController.h"
#import "LSOfficeRentViewController.h"
#import "LSPolicyInformationViewController.h"
#import "LSTestDynamicViewController.h"
#import "LSGetBannerModel.h"
#import "HRBaseNavigationController.h"
#import "LSHomeSearchViewController.h"
#import "LSHomeTitleSearchView.h"
#import "LSTestDynamicDetailViewController.h"//点击轮播图跳转界面
#import "LSLoginViewController.h"

@interface LSHomeViewController ()

@property (strong, nonatomic) NSMutableArray *pictureArr;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
/**
 *  tableView 数据源
 */
@property (strong, nonatomic) NSMutableArray *dataSourceArr;
@property (weak, nonatomic) IBOutlet UIView *bgview;


/*~!
 *  Func 导航条搜索框
 *  Auth muyingbo
 *  Time 2016-06-07
 *  Brif
 */
@property (nonatomic, strong)LSHomeTitleSearchView *titleView;


@end

@implementation LSHomeViewController
#pragma mark - ||========== Lazy loading ===========||
- (LSHomeTitleSearchView *)titleView {
    if (!_titleView) {
        _titleView = LoadXib(LSHomeTitleSearchView);
        _titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH + 20, 44);
        weakSelf(weakSelf);
        [_titleView seacrch:^{
            LSHomeSearchViewController *searchcntl = [[LSHomeSearchViewController alloc]init];
            [weakSelf.navigationController pushViewController:searchcntl animated:NO];
            
        }];
    }
    return _titleView;
}

#pragma mark - ||========== LifeCycle ===========||

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self configNavigationTitle];
}


#pragma mark 导航条
- (void)configNavigationTitle {
    
    self.tabBarController.navigationItem.titleView = self.titleView;
    
    self.tabBarController.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:245.0 green:245.0 blue:245.0 alpha:1];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    self.pictureArr = [NSMutableArray array];
    self.dataSourceArr = [NSMutableArray array];
    
    //数据请求
    [self requestGetBanner];
    
}

#pragma mark --无限轮播
-(void)addLMADView
{
    
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    
    CGRect frame = CGRectMake(0, 0, screenFrame.size.width, screenFrame.size.width/320*177);
    
    NSMutableArray *imgIdArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *titleArr = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<self.dataSourceArr.count; i++) {
        LSGetBannerModel *model = self.dataSourceArr[i];
        [self.pictureArr addObject:model.imgPath];
        [imgIdArr addObject:model.articleId];
        if (model.title.length > 20) {
            NSString *subStr = [NSString stringWithFormat:@"%@...",[model.title substringToIndex:20]];
            [titleArr addObject:subStr];
        }else{
            [titleArr addObject:model.title];
        }
    }
    
    
    
    LMADView *imageViewDisplay = [[LMADView alloc] initWithFrame:frame withURLStrings:self.pictureArr withTitles:titleArr];

    
    [imageViewDisplay openTimerWithAnimationDuration:

     3.0];
    
    //点击每张图片
    [imageViewDisplay imageViewTap:^(NSInteger imageViewTag)
     {
         NSLog(@"imageViewTag%ld",imageViewTag);
         LSTestDynamicDetailViewController *testDetailcntl = [[LSTestDynamicDetailViewController alloc]init];
         testDetailcntl.Id = imgIdArr[imageViewTag];
         [self.navigationController pushViewController:testDetailcntl animated:YES];
         
     }];
    //把该视图添加到相应的父视图上
    [self.imgView addSubview:imageViewDisplay];
    
    self.imgView.backgroundColor = [UIColor purpleColor];
    
    CGRect tempRect= imageViewDisplay.frame;
    tempRect.size = self.imgView.frame.size;
    imageViewDisplay.frame = tempRect;
    
    
}


#pragma mark - ||========== IBActions ===========||
- (IBAction)ButtonAction:(UIButton *)sender {
    
    LSLoginViewController *LoginVC = [[LSLoginViewController alloc]initWithNibName:@"LSLoginViewController" bundle:nil];
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    
    NSString *userId = [userdefault objectForKey:@"userId"];
    
    switch (sender.tag) {
        case 1:{
            NSLog(@"文化金融");
            
            if (userId == nil) {
                [self presentViewController:LoginVC animated:YES completion:nil];
                
            }else{
                
                LSCultureFinanceViewController *cultureFinanceVC = [[LSCultureFinanceViewController alloc] initWithNibName:@"LSCultureFinanceViewController" bundle:nil];
                
                [self.navigationController pushViewController:cultureFinanceVC animated:YES];
            }
            
            
            
            break;
        }
        case 2:{
            NSLog(@"办公租赁");
            
            if (userId == nil) {
                [self presentViewController:LoginVC animated:YES completion:nil];
                
            }else{
                
                LSOfficeRentViewController *officeRentVC = [[LSOfficeRentViewController alloc] initWithNibName:@"LSOfficeRentViewController" bundle:nil];
                
                [self.navigationController pushViewController:officeRentVC animated:YES];
            }
            
            break;
        }
        case 3:{
            NSLog(@"政策咨询");
            
            LSPolicyInformationViewController *PolicyVC = [[LSPolicyInformationViewController alloc] initWithNibName:@"LSOfficeRentViewController" bundle:nil];
            
            [self.navigationController pushViewController:PolicyVC animated:YES];
            break;
        }
            
        case 4:{
            NSLog(@"实验区动态");
            LSTestDynamicViewController *testVC = [[LSTestDynamicViewController alloc] initWithNibName:@"LSTestDynamicViewController" bundle:nil];
            
            [self.navigationController pushViewController:testVC animated:YES];
            break;
        }
        default:
            break;
    }
    
}

#pragma mark - ||==========数据请求===========||

-(void)requestGetBanner{
    
    [[HRRequestManager manager] POST_PATH:GetBanner para:nil success:^(id responseObject) {
        
        for (NSDictionary *dic in responseObject[@"ds"])
        {
            LSGetBannerModel *model = [[LSGetBannerModel alloc]initWithDictionary:dic];
            [self.dataSourceArr addObject:model];
            
        }
        //加载轮播图
        [self addLMADView];

        
    } failure:^(NSError *error) {
        
        
    }];
    
    
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
