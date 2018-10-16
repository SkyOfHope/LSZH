
//
//  LSCultureFinanceDetailHeaderView.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/23.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSCultureFinanceDetailHeaderView.h"

#import "LSShareView.h"
#import "LMADView.h"


@interface  LSCultureFinanceDetailHeaderView()

@property (strong, nonatomic) LSShareView *shareView;

@property (strong, nonatomic) IBOutlet UIImageView *img;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *regDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *areaLabel;
@property (strong, nonatomic) IBOutlet UILabel *financeThemesLabel;
@property (strong, nonatomic) IBOutlet UILabel *suoShuHangYeLabel;
@property (strong, nonatomic) IBOutlet UILabel *keyWordLabel;
@property (strong, nonatomic) IBOutlet UILabel *financeUseLabel;
@property (strong, nonatomic) IBOutlet UILabel *financeMoneyLabel;
@property (strong, nonatomic) IBOutlet UILabel *allMoney;
@property (strong, nonatomic) IBOutlet UILabel *yiXiangTouZiLabel;
@property (strong, nonatomic) IBOutlet UILabel *financeWayLabel;


@property (strong, nonatomic) NSArray *imgArray;
//@property (strong, nonatomic) NSArray *imgArray;

@end

@implementation LSCultureFinanceDetailHeaderView

-(instancetype)init
{
    self = [[[NSBundle mainBundle]loadNibNamed:@"LSCultureFinanceDetailHeaderView" owner:self options:nil]lastObject];
    if (self)
    {
        self.imgArray = [NSArray array];
//        self.imgArray = @[@"蓝色智慧引导页0",@"蓝色智慧引导页0",@"蓝色智慧引导页1"];
        
    }
    
    return self;
}

-(void)buildingWithArray:(NSMutableArray *)imgArr{
    
    self.imgArray = imgArr.copy;
    
    [self addLMADView];
}

#pragma mark --无限轮播
-(void)addLMADView
{
    
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    
    CGRect frame = CGRectMake(0, 0, screenFrame.size.width, 225);
    
//    NSMutableArray *imgIdArr = [NSMutableArray arrayWithCapacity:0];
////
//    for (int i=0; i<self.dataSourceArr.count; i++) {
//        
//        LSGetBannerModel *model = self.dataSourceArr[i];
////        [self.pictureArr addObject:model.imgPath];
////        [imgIdArr addObject:model.articleId];
////        [titleArr addObject:model.title];
//        
//    }
    
    //    NSMutableString *temp = [NSMutableString string];
    //    NSLog(@"%@",titleArr);
    //    for (NSString *str in titleArr) {
    //        [temp appendFormat:@"%@",str];
    //    }
    //    NSLog(@"%@",temp);
    
    //    LMADView *imageViewDisplay = [[LMADView alloc] initWithFrame:frame withURLStrings:self.pictureArr];
    
    
//    LMADView *imageViewDisplay = [[LMADView alloc] initWithFrame:frame withImageNames:self.imgArray withtitles:nil];
    LMADView *imageViewDisplay = [[LMADView alloc] initWithFrame:frame withURLStrings:self.imgArray withTitles:nil];
    imageViewDisplay.backgroundColor = [UIColor clearColor];
    
    
    [imageViewDisplay openTimerWithAnimationDuration:
     
     3.0];
    
//    //点击每张图片
//    [imageViewDisplay imageViewTap:^(NSInteger imageViewTag)
//     {
//         NSLog(@"imageViewTag%ld",imageViewTag);
//         LSTestDynamicDetailViewController *testDetailcntl = [[LSTestDynamicDetailViewController alloc]init];
//         testDetailcntl.Id = imgIdArr[imageViewTag];
//         [self.navigationController pushViewController:testDetailcntl animated:YES];
//         
//     }];
    //把该视图添加到相应的父视图上
    [self addSubview:imageViewDisplay];
    
//    self.imgView.backgroundColor = [UIColor purpleColor];
}


- (IBAction)shareBtnAction:(UIButton *)sender {
    
    NSLog(@"分享分享分享");
    
    self.shareView = [[LSShareView alloc]init];
    self.shareView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
    //    self.alertView.backgroundColor = RGBColor(0, 0, 0, .5);
    self.shareView.layer.cornerRadius = 5;
    self.shareView.layer.masksToBounds = YES;
    [AppDelegate.window addSubview:self.shareView];
    
    self.shareView.frame = SCREEN_BOUNDS;
    
}

-(void)buildingWithModel:(LSGetItemFinancingModel *)model{
    
    self.titleLabel.text = model.title;
    
    self.regDateLabel.text = [self cutAndReplaceDate:model.regDate][0];
    self.viewCountLabel.text = model.viewCount;
    self.areaLabel.text = model.city;
    self.financeThemesLabel.text = model.rongziZhuti;
    self.suoShuHangYeLabel.text = model.suoshuHangye;
    self.keyWordLabel.text = model.keyword;
    self.financeUseLabel.text = model.rongziYongtu;
        //finaceMoneylabel由融资金额转换为总投资额 另一个相反
    
    self.financeMoneyLabel.text = [NSString stringWithFormat:@"%@万元",model.totalMoney];
    self.allMoney.text = [NSString stringWithFormat:@"%@万元",model.rongziMoneyStart];
    
    
//    self.yiXiangTouZiLabel.text = model.yixiangZijin;
    self.financeWayLabel.text = model.rongziWay;
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"暂无图片"]];
    
    
//    [self contentSize:model.title withtosize:self.titleLabel.frame];
    
    
    
    
    CGFloat titleHeight = [self getHeightWith:self.titleLabel.width andFont:15 andContent:model.title] + 10;
    
    CGFloat keyWordLabelHeight = [self getHeightWith:self.keyWordLabel.width andFont:12 andContent:model.keyword];
    
    CGFloat financeUseLabelHeight = [self getHeightWith:self.financeUseLabel.width andFont:12 andContent:model.rongziYongtu];
    
    CGFloat headerHeight = 695 + titleHeight + keyWordLabelHeight + financeUseLabelHeight - 15 - self.keyWordLabel.height - self.financeUseLabel.height;
    
    //代理方法
    if (_delegate && [_delegate respondsToSelector:@selector(updateDataWithHeight:)]) {
        [_delegate updateDataWithHeight:headerHeight];
    }
    
    
    
}



-(CGFloat)getHeightWith:(CGFloat)width andFont:(NSInteger)font andContent:(NSString*)content{
    
    CGFloat height = [content boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSForegroundColorAttributeName : [UIFont systemFontOfSize:font]} context:nil].size.height;
    
    return height;
}

//截取时间字符串
//0为日期 1为时间
-(NSMutableArray*)cutAndReplaceDate:(NSString *)date{
    
    NSArray *arr = [date componentsSeparatedByString:@" "];
    
    NSString *dateStr = [arr[0] stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    NSMutableArray *dateArr = [NSMutableArray arrayWithArray:arr];
    
    [dateArr replaceObjectAtIndex:0 withObject:dateStr];
    
    return dateArr;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
