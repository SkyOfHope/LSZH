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
#import "LSAboutMineController.h"

@interface LSPersonalSetViewController ()


@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;
/**
 *  tableView 数据源
 */
@property (strong,nonatomic) NSArray *dataSourceArr;

@property (assign,nonatomic) NSInteger isShangXian;


@end

@implementation LSPersonalSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置";

    //判断是否上线
    [self requestIsShangxian];
    
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSPersonalSetTableViewCell" bundle:nil] forCellReuseIdentifier:CELL_PersonalSet];
    
    [self configUI];
    
}




- (void)configUI {
    
    [self configLeftBarButton];
    
    if (self.isShangXian == 1) {
        self.dataSourceArr = @[@"修改密码",@"关于我们",@"版本检测",@"清除缓存"];
    }else{
        self.dataSourceArr = @[@"修改密码",@"关于我们",@"清除缓存"];
    }
    
}
- (void)configLeftBarButton {
    [self navigationLeftBarButtonImageNames:@[@"返回"] click:^(NSInteger buttonTag) {
        NSLog(@"dahjkda");
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
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
    
    //去掉分割线
    self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
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
            
//            LSAboutMineViewController *aboutMineVC = [[LSAboutMineViewController alloc] initWithNibName:@"LSAboutMineViewController" bundle:nil];
            
            LSAboutMineController *aboutMineVC = [[LSAboutMineController alloc] initWithNibName:@"LSAboutMineController" bundle:nil];
            
            [self.navigationController pushViewController:aboutMineVC animated:nil];
        }
            break;
        case 2:
            NSLog(@"123");
            if (self.isShangXian == 1) {
                return;
            }else{
                [self PromptAfterClean];
                
                [[SDImageCache sharedImageCache]clearMemory];
            }
            break;
        case 3:
            NSLog(@"12345");
            
            [self PromptAfterClean];
            
            [[SDImageCache sharedImageCache]clearMemory];

            break;
            
        default:
            
            break;
    }
    
}
//点击登出 删除用户数据 并 返回登录页
- (IBAction)LogOffBtn:(id)sender {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setObject:nil forKey:@"userId"];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

//点击清除缓存后出现的提示框

-(void)PromptAfterClean{
    
    //获取缓存大小并换算为M单位
    NSInteger cacheSizeByte =   [[SDImageCache sharedImageCache]getSize];
    NSInteger cacheSizeM = cacheSizeByte / 1024 / 1024;
    
    
    //创建提示框Label进行提示
    CGFloat width = SCREEN_WIDTH * 0.8;
    CGFloat hight = width * 0.2;
    
    //创建提示框并在清除缓存后显示
    UILabel *tapLabel =  [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - width)/2, SCREEN_HEIGHT / 2 + 100, width, hight)];
    
    if (cacheSizeM == 0) {
        tapLabel.text = @"已经清理过了呦";
    }else{
        tapLabel.text = [NSString stringWithFormat:@"已经清除%zdM缓存",cacheSizeM];
    }

    tapLabel.backgroundColor = [UIColor blackColor];
    tapLabel.alpha = 0;
    tapLabel.textColor = [UIColor whiteColor];
    tapLabel.textAlignment = NSTextAlignmentCenter;
    
    tapLabel.layer.cornerRadius = 10;
    tapLabel.layer.masksToBounds = YES;
    
    
    [self.view addSubview:tapLabel];
    
    [UIView animateWithDuration:1 animations:^{
        tapLabel.alpha = 0.8;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1 animations:^{
            tapLabel.alpha = 0;
        } completion:^(BOOL finished) {
            [tapLabel removeFromSuperview];
        }];
        
    }];

    //手动清除本机图片数据
    [[SDImageCache sharedImageCache]clearDisk];
    
}

#pragma mark ----------- 网络请求 -----------
-(void)requestIsShangxian{
    
    [[HRRequestManager manager] GET_PATH:Path_IsShangxian para:nil success:^(id responseObject) {
        
        if ([responseObject[@"success"] boolValue ] == 1) {
            
            self.isShangXian = [responseObject[@"ds"][@"shangxian"]intValue];
            
            NSLog(@"🌹🌹🌹🌹🌹🌹%ld",(long)self.isShangXian);
            
            
//            if ([responseObject[@"ds"][@"shangxian"]intValue] == 1) {
//                
//                self.dataSourceArr = @[@"修改密码",@"关于我们",@"版本检测",@"清除缓存"];
//                
//            }else{
//                NSLog(@"%d",[responseObject[@"ds"][@"shangxian"]intValue]);
//                self.dataSourceArr = @[@"修改密码",@"关于我们",@"清除缓存"];
//                
//
//            }
            
        }
        
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
