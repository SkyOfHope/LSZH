//
//  LSOfficeRentDetailCell.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/23.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSOfficeRentDetailCell.h"

#import <MapKit/MapKit.h>

#import "LSShareView.h"
#import "LMADView.h"


@interface LSOfficeRentDetailCell()

@property (strong, nonatomic) LSShareView *shareView;


@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *regDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *louyuLabel;
@property (strong, nonatomic) IBOutlet UILabel *louhaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *loucengLabel;
@property (strong, nonatomic) IBOutlet UILabel *chaoxiangLabel;
@property (strong, nonatomic) IBOutlet UILabel *zhuangxiuLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *peitaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *qizuDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *sizeLabel;
@property (strong, nonatomic) IBOutlet UILabel *rizujinLabel;
@property (strong, nonatomic) IBOutlet UILabel *yuezujinLabel;
@property (strong, nonatomic) IBOutlet UILabel *mianzuqiLabel;
@property (strong, nonatomic) IBOutlet UILabel *jianzhuTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *jianzhuSizeLabel;
@property (strong, nonatomic) IBOutlet UILabel *jingcenggaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *kaifashangLabel;
@property (strong, nonatomic) IBOutlet UILabel *shejiDanweiLabel;
@property (strong, nonatomic) IBOutlet UILabel *shigongDanweiLabel;
@property (strong, nonatomic) IBOutlet UILabel *wuyeJibieLabel;
@property (strong, nonatomic) IBOutlet UILabel *ruzhuDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *louneiPeitaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *zhoubianPeitaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *jiaotongPeitaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *remarkLabel;

@property (weak, nonatomic) IBOutlet UILabel *mapDixia;


//地图 相关属性
@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@property (strong, nonatomic) NSArray *imgArray;


@end

@implementation LSOfficeRentDetailCell
- (void)awakeFromNib {
    
    self.imgArray = [NSArray array];
    
    
    self.titleLabel.text = @"";
    self.louyuLabel.text = @"";
    self.qizuDateLabel.text = @"";
    self.sizeLabel.text = @"";
    self.rizujinLabel.text = @"";
    self.yuezujinLabel.text = @"";
    self.mianzuqiLabel.text = @"";
    self.louhaoLabel.text = @"";
    self.loucengLabel.text = @"";
    self.chaoxiangLabel.text = @"";
    self.peitaoLabel.text = @"";
    self.addressLabel.text = @"";
    self.jianzhuTypeLabel.text = @"";
    self.jianzhuSizeLabel.text = @"";
    self.jingcenggaoLabel.text = @"";
    self.wuyeJibieLabel.text = @"";
    self.kaifashangLabel.text = @"";
    self.shejiDanweiLabel.text = @"";
    self.shigongDanweiLabel.text = @"";
    self.ruzhuDateLabel.text = @"";
    self.louneiPeitaoLabel.text = @"";
    self.zhoubianPeitaoLabel.text = @"";
    self.jiaotongPeitaoLabel.text = @"";
    self.remarkLabel.text = @"";
    self.viewCountLabel.text = @"";
    self.regDateLabel.text = @"";
    self.mapDixia.text = @"";

    
    
    
}


-(void)buildingWithArray:(NSMutableArray *)imgArr{
    
    self.imgArray  = imgArr;
    
    [self addLMADView];
}


#pragma mark --无限轮播
-(void)addLMADView
{
    
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    
    CGRect frame = CGRectMake(0, 0, screenFrame.size.width, 225);
    
    LMADView *imageViewDisplay = [[LMADView alloc] initWithFrame:frame withURLStrings:self.imgArray withTitles:nil];
//    imageViewDisplay.backgroundColor = [UIColor redColor];
    
    [imageViewDisplay openTimerWithAnimationDuration:
     
     3.0];
    
    
    
    //把该视图添加到相应的父视图上
    [self addSubview:imageViewDisplay];
    
    
//    self.blockForCell();
    
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

-(void)buildingWithModel:(LSGetItemRentHouseModel *)model{
    
//    self.img = 
    self.titleLabel.text = model.title;
    self.louyuLabel.text = model.louyu;
    self.qizuDateLabel.text = [self cutAndReplaceDate:model.qizuDate][0];
    self.sizeLabel.text = [self formatter:model.size andStr:@"m²"];
    self.rizujinLabel.text = [self formatter:model.rizujin andStr:@"元"];
    self.yuezujinLabel.text = [self formatter:model.yuezujin andStr:@"元"];
    self.mianzuqiLabel.text = [self formatter:model.mianzuqi andStr:@"天"];
    self.louhaoLabel.text = model.louhao;
    self.loucengLabel.text = [self formatter:model.louceng andStr:@"层"];
    self.chaoxiangLabel.text = model.chaoxiang;
    self.zhuangxiuLabel.text = model.zhuangxiu;
    self.peitaoLabel.text = model.peitao;
    self.addressLabel.text = model.city;
    self.jianzhuTypeLabel.text = model.jianzhuType;
    self.jianzhuSizeLabel.text = [self formatter:model.jianzhuSize andStr:@"m²"];
    self.jingcenggaoLabel.text = [self formatter:model.jingcenggao andStr:@"m"];
    self.wuyeJibieLabel.text = model.wuyeJibie;
    self.kaifashangLabel.text = model.kaifashang;
    self.shejiDanweiLabel.text = model.shejiDanwei;
    self.shigongDanweiLabel.text = model.shigongDanwei;
    self.ruzhuDateLabel.text = [self cutAndReplaceDate:model.ruzhuDate][0];
    self.louneiPeitaoLabel.text = model.louneiPeitao;
    self.zhoubianPeitaoLabel.text = model.zhoubianPeitao;
    self.jiaotongPeitaoLabel.text = model.jiaotongPeitao;
    self.remarkLabel.text = model.remark;
    self.viewCountLabel.text = model.viewCount;
    self.regDateLabel.text = [self cutAndReplaceDate:model.regDate][0];
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"暂无图片"]];
    
    self.mapDixia.text = model.address;
    
    
    //获取经纬度
    
    if (model.mapXY_gaode.length > 03) {
        
        NSArray *LongAndLat = [model.mapXY_gaode componentsSeparatedByString:@","];
        
        CGFloat longitude = [LongAndLat[0] floatValue];
        
        CGFloat latitude = [LongAndLat[1] floatValue];
        
        if (longitude > 0 && longitude < 180 && latitude > 0 && latitude < 90) {
            
            //测试用经纬度
//                CGFloat longitude = 120.2;
//                CGFloat latitude = 30.465;
            
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude,longitude);
            // 显示尺寸span
            MKCoordinateSpan span = MKCoordinateSpanMake(0.04, 0.04);
            self.mapView.region = MKCoordinateRegionMake(coordinate, span);
            
            //添加大头针
            MKPointAnnotation * ann = [[MKPointAnnotation alloc]init];
            //设置大头针坐标
            ann.coordinate=CLLocationCoordinate2DMake(latitude,longitude);
            ann.title=model.address;
            //    ann.subtitle=;
            
            [self.mapView addAnnotation:ann];

        }else{
            NSLog(@"经纬度错误");
        }
 
    }else{
        return;
    }

}


//formatter
-(NSString*)formatter:(NSString*)str1 andStr:(NSString*)str2{
    
    NSString *newStr = [NSString stringWithFormat:@"%@%@",str1,str2];
    
    return newStr;
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




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
