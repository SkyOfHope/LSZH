
//
//  LSTestDynamicHeaderView.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/23.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSTestDynamicHeaderView.h"

#import "LSTestDynamicDetailViewController.h"


@interface LSTestDynamicHeaderView()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *FirstBackViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomBackViewHeight;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bigImgAspect;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *summeryLabel;

@property (copy, nonatomic) NSString *articleId;

@end

@implementation LSTestDynamicHeaderView


-(void)buildingWithModel:(LSGetSyqdtTopModel *)model{
    
    self.titleLabel.text = model.title;
//    self.titleLabel.text = @"全国首个文化企业信用促进会成立大会于朝阳规划艺术馆举行全国首个文化企业信用促进会成立大会于朝阳规划艺术馆举行全国首个文化企业信用促进会成立大会于朝阳规划艺术馆举行";
//    self.dateLabel.text = model.publishdate;
    self.summeryLabel.text = model.summary;
//    self.summeryLabel.text = @"全国首个文化企业信用促进会成立大会于朝阳规划艺术馆举行全国首个文化企业信用促进会成立大会于朝阳规划艺术馆举行全国首个文化企业信用促进会成立大会于朝阳规划艺术馆举行";
    
    self.img.contentMode = UIViewContentModeScaleAspectFit;
//    self.img.clipsToBounds = YES;
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"暂无图片"]];
    
   
    
    self.articleId = model.articleId;
    
    self.dateLabel.text = [self cutAndReplaceDate:model.publishdate][0];
    
    
    
    CGSize tenpSize = [self.titleLabel.text boundingRectWithSize:CGSizeMake(SCREEN_BOUNDS.size.width - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
    
    CGSize summarySize = [self.summeryLabel.text boundingRectWithSize:CGSizeMake(SCREEN_BOUNDS.size.width - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
    
//    self.headerHeight += self.img.height;
//    self.FirstBackViewHeight.constant = tenpSize.height + 45+10;
//    self.bottomBackViewHeight.constant = summarySize.height + 20;
//    
//    self.headerHeight += tenpSize.height + 45+10;
//    self.headerHeight += summarySize.height + 10;
//    
//    self.backBlock();

    
    UIImageView *imageV = [[UIImageView alloc]init];
    
    [imageV sd_setImageWithURL:[NSURL URLWithString:model.imgPath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        
        UIImage *bigImage = imageV.image;
        
        CGFloat rate = bigImage.size.width*1.0/bigImage.size.height;
        
        CGFloat imgHeight = (SCREEN_BOUNDS.size.width - 20)*1.0/rate;
        
        self.headerHeight += imgHeight;
        
        self.FirstBackViewHeight.constant = tenpSize.height + 45+10;
        self.bottomBackViewHeight.constant = summarySize.height + 20;
        
        self.headerHeight += tenpSize.height + 45+10;
        self.headerHeight += summarySize.height + 10;
        
        self.backBlock();
       
    }];
        
}


    
    
    
//    UIImageView *imageV = [[UIImageView alloc]init];
//    [imageV sd_setImageWithURL:[NSURL URLWithString:model.imgPath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    
    
//        UIImage *img1 = self.img.image;
//        NSLog(@" #@#@#@#@#@#@#@#@#@#@#@#@#@#@#    %zd     %zd",self.img.image.size.height,self.img.image.size.width);
//        
////        CGFloat rate = img.size.width*1.0/img.size.height;
//         CGFloat rate = self.img.image.size.width*1.0/self.img.image.size.height;
//        
//        NSLog(@"@￥￥@￥@￥@￥@￥@￥@   %zd    ",rate);
//        
////        self.bigImgAspect.constant = img.size.width*1.0/img.size.height;
//        CGFloat imgHeight = (SCREEN_BOUNDS.size.width - 20)*1.0/rate;
////        self.headerHeight += img.size.height/2;
//        self.headerHeight += imgHeight;
//        
////        NSLog(@"🌹🌹🌹🌹🌹🌹🌹%zd",img.size.height);
//        self.headerHeight += self.img.height;
//        
//        self.FirstBackViewHeight.constant = tenpSize.height + 45+10;
//        
//        self.headerHeight += tenpSize.height + 45+10;
//        self.headerHeight += summarySize.height + 10;
//        
//        self.backBlock();
//    }];

//}


- (IBAction)buttonAction:(UIButton *)sender {
    
    LSTestDynamicDetailViewController *detailVC = [[LSTestDynamicDetailViewController alloc] initWithNibName:@"LSTestDynamicDetailViewController" bundle:nil];
    
    detailVC.Id = self.articleId;
    detailVC.titles = self.titleLabel.text;
    
    [self.viewController.navigationController pushViewController:detailVC animated:nil];
    
    
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
