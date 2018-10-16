//
//  LSSendAppointmentViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/20.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSSendAppointmentViewController.h"

#import "LSAppointmentChooseViewController.h"

#import "LSAppointmentChooseCell.h"

#import "LSGetItemJinRongListModel.h"
#import "LSGetItemFinancingListModel.h"

#import "LSSelectMeetItemListModel.h"

#import "LSNeedOfficeRentCell.h"

#import "LSAppointmentSelectedChooseCellTableViewCell.h"

#import "LSAppointmentSelectedChooseCellTableViewCellTwoTableViewCell.h"

@interface LSSendAppointmentViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,LSAppointmentSelectedChooseCellTableViewCellDelegate,LSNeedOfficeRentCellDelegate,LSAppointmentSelectedChooseCellTwoTableViewCellDelegate,UIAlertViewDelegate>
{
    
}
@property (strong, nonatomic) IBOutlet UIButton *addProjectBtn;

@property (weak, nonatomic) IBOutlet UITableView *tableForProduction;
@property (strong ,nonatomic) NSMutableArray *dataARR;

//输入框相关属性
@property (strong, nonatomic) IBOutlet UITextView *contentTextField;

@property (strong, nonatomic) IBOutlet UILabel *textLabel;

@property (weak, nonatomic) IBOutlet UILabel *wordCount;

//提取传入的model的类型,根据类型返回cell
@property (assign, nonatomic) NSInteger itemTypeId;

@end

@implementation LSSendAppointmentViewController
#pragma mark - ||========== LifeCycle ===========||
// 视图加载完毕
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"发送约谈";
    
    [self CellForProduction];
    
    [self configUI];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.contentTextField.delegate = self;
    
    self.textLabel.hidden = NO;
    
    

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

#pragma mark @ UITextViewDelegate Methods @

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    self.textLabel.hidden = YES;
    
}

-(void)textViewDidChangeSelection:(UITextView *)textView{
    
    NSInteger wordCount = textView.text.length;
    
    self.wordCount.text = [NSString stringWithFormat:@"%zd/100字",wordCount];
    
}

- (void)textViewDidChange:(UITextView *)textView{
    
    NSString *string = textView.text;
    if ([string length] > 100)
        
    {
        
        string = [string substringToIndex:100];
        
        self.contentTextField.text = string;
    }

}

//- (void)textViewDidChange:(UITextView *)textView
//{
//    
//    NSString *string = textView.text;
//    if ([string length] > 100)
//        
//    {
//        
//        string = [string substringToIndex:500];
//        
//        textView.text = string;
//    }
//    
//}


//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    
//    if (range.location >= 100) {
//        return NO;
//    }else{
//        return YES;
//    }
//}
//

#pragma mark - ||========== IBActions ===========||
- (IBAction)addProjectBtnClick:(UIButton *)sender {
    
    NSLog(@"123456");
    
    LSAppointmentChooseViewController *ChooseViewController = [[LSAppointmentChooseViewController alloc] init];
    
    ChooseViewController.sendCellModle = ^(LSSelectMeetItemListModel*cellmodel){
        
        //移除数据,并且设置cell类型为0
        [self.dataARR removeAllObjects];
        
        self.itemTypeId = 0;
        //得到数据并重新设置cell类型
        [self.dataARR addObject:cellmodel];
        
        [self.tableForProduction setHidden:NO];
        
        LSSelectMeetItemListModel *model = self.dataARR[0];
 
        self.itemTypeId = [model.itemTypeId integerValue];

        [self.tableForProduction reloadData];
        
        [self CellForProduction];
        
    };
    
    [self.navigationController pushViewController:ChooseViewController animated:YES];
    
}

- (IBAction)sendYueTanAction:(id)sender {

    
        //判断字数之后在发送请求
    if (self.contentTextField.text.length >= 1 || self.dataARR.count > 0 ) {
        
        //获取参数
        //接受上层传入的model
        
        NSString * itemId = [self.paraDict objectForKey:@"itemId"];
        NSString * itemTypeId = [self.paraDict objectForKey:@"itemTypeId"];
        
        //  PATH_SendMeet
        NSMutableDictionary *para = [NSMutableDictionary dictionary];
        [para setObject:itemTypeId forKey:@"itemTypeId"];
        
        //判断是userID 还是 toUserId
        NSString * toUserId = [self.paraDict objectForKey:@"userId"];
        if (toUserId.length > 0) {
            [para setObject:toUserId forKey:@"toUserId"];
        }else{
            NSString *toUserIdT = [self.paraDict objectForKey:@"toUserId"];
            [para setObject:toUserIdT forKey:@"toUserId"];
        }

        [para setObject:itemId forKey:@"itemId"];
        [para setObject:_contentTextField.text forKey:@"remark"];
        //添加约谈内容
        [para setObject:self.contentTextField.text forKey:@"remark"];
        
        NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        [para setObject:userId forKey:@"userId"];
        
        
        //如果有自选参数添加参数 如果没有就不添加参数
        if (self.dataARR.count > 0) {
            
            //自选项目的参数
            
            LSSelectMeetItemListModel *model = self.dataARR[0];
            NSString * fujianItemTypeId = model.itemTypeId;
            NSString * fujianItemId = model.itemId;
            [para setObject:fujianItemTypeId forKey:@"fujianItemTypeId"];
            [para setObject:fujianItemId forKey:@"fujianItemId"];
            
        }
        
        [[HRRequestManager manager] GET_PATH:PATH_SendMeet para:para success:^(id responseObject) {
            
            if ([responseObject isKindOfClass:[NSDictionary class]])
            {
                NSDictionary * dic = (NSDictionary *)responseObject;
                
                if ([dic[@"success"] boolValue] == 1) {
                    NSLog(@"发送成功");
                    NSLog(@"############################################################");
                    
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                       message:dic[@"errMsg"]
                                                                      delegate:nil
                                                             cancelButtonTitle:@"确定"
                                                             otherButtonTitles:nil];
                    alertView.delegate = self;
                    
                    [alertView show];
                    
                    
                    
                }else{
                    NSLog(@"请求失败");
                    
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:dic[@"errMsg"]delegate:nil
                                                             cancelButtonTitle:@"确定"
                                                             otherButtonTitles:nil];
                    
                    alertView.delegate = self;
                    [alertView show];
                    
                }
            }
            
        } failure:^(NSError *error) {
            
        }];

    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"请至少输入一项"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
        [alertView show];
    }

}

//警告框已经消失时触发的方法
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.navigationController popViewControllerAnimated:YES];
        
    });

    
}

-(void)CellForProduction{
    
    self.tableForProduction.dataSource = self;
    self.tableForProduction.delegate = self;
    
    self.tableForProduction.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableForProduction.showsHorizontalScrollIndicator = NO;
    self.tableForProduction.showsVerticalScrollIndicator = NO;
    
    self.tableForProduction.bounces = NO;
    
    //前三种cell的形式
    [self.tableForProduction registerNib:[UINib nibWithNibName:@"LSAppointmentSelectedChooseCellTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifierOneToThree];
    //4类型cell形式
//    [self.tableForProduction registerNib:[UINib nibWithNibName:@"LSNeedOfficeRentCell" bundle:nil] forCellReuseIdentifier:cellIdentifierFour];
    [self.tableForProduction registerNib:[UINib nibWithNibName:@"LSAppointmentSelectedChooseCellTableViewCellTwoTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifierFour];
    
    
    //根据数组数量决定是否隐藏视图
    
    if (self.dataARR.count == 0) {
        self.tableForProduction.hidden = YES;
    }else{
        self.tableForProduction.hidden = NO;
    }
    
    
}

static NSString *cellIdentifierOneToThree = @"cellIdentifierOneToThree";
static NSString *cellIdentifierFour = @"cellIdentifierFour";

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return    self.dataARR.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.tableForProduction.separatorStyle = UITableViewCellSelectionStyleNone;
    
    switch (self.itemTypeId) {
        case 1:{
            LSAppointmentSelectedChooseCellTableViewCell *cell = [self.tableForProduction dequeueReusableCellWithIdentifier:cellIdentifierOneToThree forIndexPath:indexPath];

            
            [cell buildingFinancingWithModel:self.dataARR[0]];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            return cell;
            break;
        }
        case 2:{
            LSAppointmentSelectedChooseCellTableViewCell *cell = [self.tableForProduction dequeueReusableCellWithIdentifier:cellIdentifierOneToThree forIndexPath:indexPath];

            [cell buildingJinRongWithModel:self.dataARR[0]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            return cell;
            break;
        }
        case 3:{
            
            LSAppointmentSelectedChooseCellTableViewCell *cell = [self.tableForProduction dequeueReusableCellWithIdentifier:cellIdentifierOneToThree forIndexPath:indexPath];

            [cell buildingRentHouseWithModel:self.dataARR[0]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            return cell;
            break;
        }
        case 4:{
            
            LSAppointmentSelectedChooseCellTableViewCellTwoTableViewCell *cell = [self.tableForProduction dequeueReusableCellWithIdentifier:cellIdentifierFour forIndexPath:indexPath];
            
//            [cell buildingWantHouseTwoModel:self.dataARR[0]];
            cell.model = self.dataARR[0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;

            return cell;
            break;
        }
            
        default:
            break;
    }
    
    return nil;
 
}

//返回cell高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tableForProduction.estimatedRowHeight = self.tableForProduction.rowHeight;
    self.tableForProduction.rowHeight = UITableViewAutomaticDimension;
    return self.tableForProduction.rowHeight;
}


-(NSMutableArray *)dataARR{
    
    if (!_dataARR) {
        _dataARR = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _dataARR;
}

#pragma mark - ||==========cell代理方法===========||

-(void)deleteSoureArrayWhichElement{
    
    [self.dataARR removeAllObjects];
    
    [self.tableForProduction reloadData];
    
    [self.tableForProduction setHidden:YES];
}

-(void)deleteCellForSendYueTan{
    
    [self.dataARR removeAllObjects];
    
    [self.tableForProduction reloadData];
    
}


@end
