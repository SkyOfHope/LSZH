//
//  LSOfficeRentNewSizeView.m
//  LSZH
//
//  Created by risenb-ios5 on 16/6/8.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSOfficeRentNewSizeView.h"

#import "LSPublishCommenCell.h"
#define CELL_PublishCommen  @"PublishCommenCell"


@interface LSOfficeRentNewSizeView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray *dataSource;
@property (strong, nonatomic) IBOutlet UITableView *customTableview;

//@property (nonatomic, strong)NSIndexPath *selectedPath;//单选
@property (nonatomic, strong)NSMutableArray *selectedPathArr;

@property (nonatomic, copy) NSString *Type;
@property (nonatomic, strong)LSPublishCommenCell *cell;

//indexArray
@property (nonatomic,strong) NSMutableArray *indexArray;

@end

@implementation LSOfficeRentNewSizeView

#pragma mark - ||========== Lazy loading ===========||
-(NSMutableArray *)selectedPathArr {
    if (!_selectedPathArr) {
        _selectedPathArr  =[NSMutableArray array];
    }
    return _selectedPathArr;
}

// 初始化
- (instancetype)initType:(NSString *)type
{
    self = [[[NSBundle mainBundle]loadNibNamed:@"LSOfficeRentNewSizeView" owner:self options:nil]lastObject];
    if (self) {
        
        [self.customTableview setDataSource:self];
        [self.customTableview setDelegate:self];
        //去掉分割线
        self.customTableview.separatorStyle = UITableViewCellSelectionStyleNone;
        
//        UIView
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        [headerView setBackgroundColor:[UIColor whiteColor]];
        [self.customTableview setTableHeaderView:headerView];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, headerView.width, 1)];
        [lineView setBackgroundColor:RGB(245, 245, 245)];
        [headerView addSubview:lineView];
        
        
        NSLog(@"#################%f",self.customTableview.width);
        
        UILabel *label = [[UILabel alloc] init];
        
        label.width = headerView.width / 2;
        label.height = headerView.height - 10;
        label.centerX = headerView.width / 2 + 20;
        label.centerY = headerView.centerY;
        
        label.textAlignment = UITextAlignmentCenter;
        
        [headerView addSubview:label];
        
        
        //注册cell-one
        [self.customTableview registerNib:[UINib nibWithNibName:@"LSPublishCommenCell" bundle:nil] forCellReuseIdentifier:CELL_PublishCommen];
        
        self.Type = type;
        
        switch ([type integerValue]) {
            case 1:
                
                label.text = @"请选择所属行业";
                [self configDataSource:[@[@"文化艺术服务",@"新闻出版及发行服务",@"广播电视电影服务",@"软件和信息技术服务",@"广告和会展服务",@"艺术品生产与销售服务",@"设计服务",@"文化休闲娱乐服务",@"文化用品设备生产销售及其他辅助服务"] mutableCopy] isMutiSelected:NO];//NO表示非多选
                
                break;
                
            case 2:
                label.text = @"请选择意向资金";
                [self configDataSource:[@[@"不限",@"个人资金",@"企业资金",@"天使投资",@"基金公司",@"商业银行",@"小额贷款",@"PE投资",@"VC投资",@"其他投资"] mutableCopy] isMutiSelected:NO];
                
                break;
                
            case 3:
                
                label.text = @"请选择融资方式";
                
                [self configDataSource:[@[@"债权融资",@"股权融资",@"信托融资",@"银行贷款",@"小额贷款",@"整体转让",@"其他融资"] mutableCopy] isMutiSelected:NO];
                
                break;
            case 4:
                label.text = @"请选择产品类型";
                
                [self configDataSource:[@[@"信贷产品",@"担保品",@"债券",@"信托产品",@"小额贷产品",@"融资租赁",@"私募股权",@"基金",@"互联网金额"] mutableCopy] isMutiSelected:NO];
                
                break;
                
                
            case 5:
                label.text = @"请选择建筑类型";
                
                [self configDataSource:[@[@"单纯性写字楼",@"商住型写字楼",@"综合性写字楼"] mutableCopy] isMutiSelected:NO];
                break;
                
            case 6:
                label.text = @"请选物业级别";
                
                [self configDataSource:[@[@"甲级",@"乙级",@"丙级"] mutableCopy] isMutiSelected:NO];
                break;
            case 7:
                label.text = @"请选机构类型";
                
                [self configDataSource:[@[@"商业银行",@"信托公司",@"担保公司",@"小额贷款公司",@"风投机构",@"其他投资公司",@"其他"] mutableCopy] isMutiSelected:NO];
                break;
            case 8:
                label.text = @"请选择融资主体";
                
                [self configDataSource:[@[@"个人",@"公司"] mutableCopy] isMutiSelected:NO];
                break;
            case 9:
                label.text = @"请选所在地区";
                
                [self configDataSource:[@[@"东城区",@"西城区",@"海淀区",@"朝阳区",@"丰台区",@"石景山区",@"通州区",@"顺义区",@"房山区",@"大兴区",@"昌平区",@"怀柔区",@"平谷区",@"门头沟区",@"密云区",@"延庆区"] mutableCopy] isMutiSelected:NO];
                break;
            case 10:
                label.text = @"请选择地理位置";
                
                [self configDataSource:[@[@"朝阳门",@"东大桥",@"国贸",@"CBD",@"大望路",@"双井",@"八里庄",@"十里堡",@"青年路",@"定福庄",@"双桥",@"常营",@"管庄",@"其他"] mutableCopy] isMutiSelected:NO];
                break;
                

                
        }
        
    }
    return self;
}


-(void)configDataSource:(NSMutableArray *)dataSource isMutiSelected:(BOOL)isMutiSelected{
    
    [self.customTableview setAllowsMultipleSelection:isMutiSelected];
    if (isMutiSelected) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.customTableview.width, 50)];
        [view setBackgroundColor:[UIColor whiteColor]];
        [self.customTableview setTableFooterView:view];
        
        NSLog(@"#################%f",self.customTableview.width);
//        CGFloat x = view.width/5;
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn setFrame:CGRectMake(10, 5, 150, 40)];
        leftBtn.backgroundColor = [UIColor lightGrayColor];
        
        [leftBtn  setTitle:@"取消" forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(CancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:leftBtn];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setFrame:CGRectMake(175, 5, 150 , 40)];
        rightBtn.backgroundColor = [UIColor lightGrayColor];
        [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(SureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:leftBtn];
        [view addSubview:rightBtn];
        
        
    }else {
        [self.customTableview setTableFooterView:nil];
    }
    
    
    self.dataSource  = dataSource;
    
    [self.customTableview reloadData];
}


#pragma mark - ||==========点击事件===========||
-(void)CancelBtnClick:(UIButton *)sender{
    
    [self hideContrl];
    [self.selectedPathArr removeAllObjects];

}

-(void)SureBtnClick:(UIButton *)sender{
    
    [self hideContrl];

//    if (_deledate && [_deledate respondsToSelector:@selector(sureAction:)]) {
//        [_deledate sureAction:self.selectedPathArr];
//    }

    
    if (_deledate && [_deledate respondsToSelector:@selector(sureAction: WithType:)]) {
        [_deledate sureAction:self.selectedPathArr WithType:@"1"];
    }
    
    NSLog(@"#$$#$#$#$#$#$#$#$#$#$#$$#$#$$#%@",self.selectedPathArr);
    

}

//隐藏界面
-(void)hideContrl
{
    [UIView animateWithDuration:.3 animations:^{
        //        self.bottom = self.superview.top;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark @ UITableViewDataSource & UITableViewDelegate @

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.dataSource.count;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 84;
//}

//返回cell高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.customTableview.estimatedRowHeight = self.customTableview.rowHeight;
    self.customTableview.rowHeight = UITableViewAutomaticDimension;
    return self.customTableview.rowHeight;
}




-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _cell = [self.customTableview dequeueReusableCellWithIdentifier:CELL_PublishCommen forIndexPath:indexPath];
    
    //cell点击变色
    [_cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [_cell changeSelectedState:NO];
    _cell.nameLabel.text = self.dataSource[indexPath.row];
    
    for (NSIndexPath *idnex in self.indexArray) {
        
        if (indexPath.row == idnex.row) {
            
            [_cell changeSelectedState:YES];
            
        }
        
    }
    
//    [_cell changeSelectedState:YES];
    
    
    return _cell;
    
}

-(NSMutableArray *)indexArray{
    
    if (!_indexArray) {
        _indexArray = [NSMutableArray array];
    }
    
    return _indexArray;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    [self.indexArray addObject:indexPath];
    
    
    _cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    if (self.customTableview.allowsMultipleSelection) {
        
//        if ([self.selectedPathArr containsObject:self.dataSource[indexPath.row]])
        
        if ([self.selectedPathArr containsObject:self.dataSource[indexPath.row]]) {
            [_cell changeSelectedState:NO];
//            [self.selectedPathArr removeObject:indexPath];
            [self.selectedPathArr removeObject:self.dataSource[indexPath.row]];
            
            return;
        }
    }
    [_cell changeSelectedState:YES];
//    [self.selectedPathArr addObject:indexPath];
    [self.selectedPathArr addObject:self.dataSource[indexPath.row]];
    
    NSLog(@"%@",self.selectedPathArr);
    
    switch ([self.Type integerValue]) {
        case 1:
//            NSLog(@"");
            
            if (_deledate && [_deledate respondsToSelector:@selector(sureAction: WithType:)]) {
                [_deledate sureAction:self.selectedPathArr WithType:self.Type];
            }
            
            [self hideContrl];
            
            NSLog(@"请选择意向资金#$#$#$#$#$#%@",self.selectedPathArr);

            
            break;
        case 2:
            
            if (_deledate && [_deledate respondsToSelector:@selector(sureAction: WithType:)]) {
                [_deledate sureAction:self.selectedPathArr WithType:self.Type];
            }
            
            [self hideContrl];

            NSLog(@"请选择意向资金#$#$#$#$#$#%@",self.selectedPathArr);
            
            break;
        case 3:
            
            if (_deledate && [_deledate respondsToSelector:@selector(sureAction: WithType:)]) {
                [_deledate sureAction:self.selectedPathArr WithType:self.Type];
            }
            
            [self hideContrl];
            
            NSLog(@"请选择融资方式#$#$#$#$#$#$#$#$%@",self.selectedPathArr);
            break;
        case 4:
            
            
            if (_deledate && [_deledate respondsToSelector:@selector(sureAction: WithType:)]) {
                [_deledate sureAction:self.selectedPathArr WithType:self.Type];
            }
            
            [self hideContrl];
            
            NSLog(@"请选择产品类型#$#$#$#$#$#$#$#$%@",self.selectedPathArr);
            break;
        case 5:
            
            if (_deledate && [_deledate respondsToSelector:@selector(sureAction: WithType:)]) {
                [_deledate sureAction:self.selectedPathArr WithType:self.Type];
            }
            
            [self hideContrl];
            
            NSLog(@"请选择建筑类型#$#$#$#$#$#$#$##%@",self.selectedPathArr);
            break;
        case 6:
            
            if (_deledate && [_deledate respondsToSelector:@selector(sureAction: WithType:)]) {
                [_deledate sureAction:self.selectedPathArr WithType:self.Type];
            }
            
            [self hideContrl];
            
            NSLog(@"请选物业级别#$##$##$#$#$#$#$%@",self.selectedPathArr);
            break;
        case 7:
            
            if (_deledate && [_deledate respondsToSelector:@selector(sureAction: WithType:)]) {
                [_deledate sureAction:self.selectedPathArr WithType:self.Type];
            }
            
            [self hideContrl];
            
            NSLog(@"请选机构类型#$##$##$#$#$#$#$%@",self.selectedPathArr);
            break;
        case 8:
            
            if (_deledate && [_deledate respondsToSelector:@selector(sureAction: WithType:)]) {
                [_deledate sureAction:self.selectedPathArr WithType:self.Type];
            }
            
            [self hideContrl];
            
            NSLog(@"请选融资主体#$##$##$#$#$#$#$%@",self.selectedPathArr);
            break;
        case 9:
            
            if (_deledate && [_deledate respondsToSelector:@selector(sureAction: WithType:)]) {
                [_deledate sureAction:self.selectedPathArr WithType:self.Type];
            }
            
            [self hideContrl];
            
            NSLog(@"请选所在地区#$##$##$#$#$#$#$%@",self.selectedPathArr);
            break;
        case 10:
            
            if (_deledate && [_deledate respondsToSelector:@selector(sureAction: WithType:)]) {
                [_deledate sureAction:self.selectedPathArr WithType:self.Type];
            }
            
            [self hideContrl];
            
            NSLog(@"请选所在地区#$##$##$#$#$#$#$%@",self.selectedPathArr);
            break;

            
        default:
            break;
    }

//    if ([self.Type integerValue] != 1) {
//        [self hideContrl];
//    }
    

}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _cell = [tableView cellForRowAtIndexPath:indexPath];
    
    

    [_cell changeSelectedState:NO];
    if ([self.selectedPathArr containsObject:indexPath]) {
        [self.selectedPathArr removeObject:indexPath];
    }
    

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
