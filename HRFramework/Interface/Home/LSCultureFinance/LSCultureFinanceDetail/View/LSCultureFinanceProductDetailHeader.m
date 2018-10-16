
//
//  LSCultureFinanceProductDetailHeader.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSCultureFinanceProductDetailHeader.h"

#import "LSShareView.h"
#import "LMADView.h"


@interface LSCultureFinanceProductDetailHeader ()

@property (strong, nonatomic) LSShareView *shareView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *regDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *productNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *productTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *unitLabel;
@property (strong, nonatomic) IBOutlet UILabel *unitTypeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (strong, nonatomic) NSArray *imgArray;


@end

@implementation LSCultureFinanceProductDetailHeader

-(instancetype)init{
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"LSCultureFinanceProductDetailHeader" owner:self options:nil]lastObject];
    
    if (self) {
        
        self.imgArray = [NSArray array];
        
    }
 
    return self;
}

-(void)buildingWithArray:(NSMutableArray *)imgArr{
    
    self.imgArray = imgArr;
    
    [self addLMADView];
}


#pragma mark --无限轮播
-(void)addLMADView
{
    
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    
    CGRect frame = CGRectMake(0, 0, screenFrame.size.width, 225);
    
    LMADView *imageViewDisplay = [[LMADView alloc] initWithFrame:frame withURLStrings:self.imgArray withTitles:nil];
    imageViewDisplay.backgroundColor = [UIColor clearColor];
    
    [imageViewDisplay openTimerWithAnimationDuration:
     
     3.0];
    
    //把该视图添加到相应的父视图上
    [self addSubview:imageViewDisplay];
    
    //    self.imgView.backgroundColor = [UIColor purpleColor];
}


-(void)buildingWithModel:(LSGetItemJinRongModel *)model{
    
    self.titleLabel.text = model.title;
    self.regDateLabel.text = [self cutAndReplaceDate:model.regDate][0];
    self.viewCountLabel.text = model.viewCount;
    self.productNameLabel.text = model.title;
    self.productTypeLabel.text = model.productType;
    self.unitLabel.text = model.unit;
    self.unitTypeLabel.text = model.unitType;
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"暂无图片"]];
}


- (IBAction)shareBtnAction:(UIButton *)sender {
    
    NSLog(@"分享分享分享");
    
//    if (_delegate && [_delegate respondsToSelector:@selector(shareBtn)]) {
//        [_delegate shareBtn];
//    }

    self.shareView = [[LSShareView alloc]init];
    self.shareView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
    //    self.alertView.backgroundColor = RGBColor(0, 0, 0, .5);
    self.shareView.layer.cornerRadius = 5;
    self.shareView.layer.masksToBounds = YES;
    [AppDelegate.window addSubview:self.shareView];
    
    self.shareView.frame = SCREEN_BOUNDS;
    
    NSLog(@"123456");

    
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
