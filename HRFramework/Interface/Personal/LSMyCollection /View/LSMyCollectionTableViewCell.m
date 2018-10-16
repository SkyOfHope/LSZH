//
//  LSMyCollectionTableViewCell.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/24.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSMyCollectionTableViewCell.h"

//typedef void(^NetRequestParaModelBlockType)(LSPublishFinanceModel *model);

typedef void(^NetRequestParaModelBlockType)(LSCancelCollectModel *model);


@interface LSMyCollectionTableViewCell()

//@property (nonatomic, copy)NetRequestParaModelBlockType block;

@property (nonatomic, copy)NetRequestParaModelBlockType block;

@property (strong, nonatomic) IBOutlet UIButton *cancelCollectBtn;

@property (strong, nonatomic) IBOutlet UILabel *rongziNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *keyWordNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *sizeNamelable;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *rongziZhutiLabel;
@property (strong, nonatomic) IBOutlet UILabel *keywordLabel;
@property (strong, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *regDateLabel;

@property (strong, nonatomic) LSCancelCollectModel *cancelModel;

//新增属性，用于区分是那种类型的项目被删除，传递给主控制器后重新请求对应数据并刷新table

@property (assign, nonatomic) NSInteger *item;


@end

@implementation LSMyCollectionTableViewCell

-(void)buildingFinancingWithModel:(LSGetCollectFinancingList *)model{

    
    self.cancelModel.itemTypeId = model.financingId;

    self.rongziNameLabel.text = @"融资主体：";
    self.keywordLabel.text = @"关键词：";
    self.sizeNamelable.text = @"";
    self.titleLabel.text = model.title;
    self.rongziZhutiLabel.text = model.rongziZhuti;
    self.keywordLabel.text = model.keyword;
    self.viewCountLabel.text = model.viewCount;
    self.regDateLabel.text = [self cutAndReplaceDate:model.regDate][0];
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"占位"]];
}

-(void)buildingJinRongWithModel:(LSGetCollectJinRongList *)model{

    self.cancelModel.itemTypeId = model.jinrongId;

    self.keyWordNameLabel.text = @"关键词：";
    self.sizeNamelable.text = @"";
    self.rongziNameLabel.text = @"发行单位：";
    self.titleLabel.text = model.title;
    self.rongziZhutiLabel.text = model.unit;
    self.keywordLabel.text = model.keyword;
    self.viewCountLabel.text = model.viewCount;
    //对日期数据修改，只保留日期部分
    self.regDateLabel.text = [self cutAndReplaceDate:model.regDate][0];
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"占位"]];
}

-(void)buildingRentHouseWithModel:(LSGetCollectRentHouseList *)model{
    
    self.rongziNameLabel.text = model.rizujin;
    self.keyWordNameLabel.text = model.address;
    self.titleLabel.text = model.title;
    self.rongziZhutiLabel.text = @"元/日";
    self.keywordLabel.text = @"";
    self.viewCountLabel.text = model.viewCount;
    self.regDateLabel.text = [self cutAndReplaceDate:model.regDate][0];
    self.sizeNamelable.text = model.size;
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"占位"]];
    
}

-(void)buildingWantHouseModel:(LSGetCollectWantHouseList *)model{
    
//        self.img =
    
    self.titleLabel.text = model.title;
//    self.rongziZhutiLabel.text = [NSString stringWithFormat:@"%@-%@元/日",model.rizujinStart,model.rizujinEnd];
    self.rongziZhutiLabel.text = model.rizujinStart;
    self.keywordLabel.text = model.address;
    self.viewCountLabel.text = model.viewCount;
    self.regDateLabel.text = [self cutAndReplaceDate:model.regDate][0];
    
    
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


//取消收藏按钮
- (IBAction)cancelCollectBtn:(UIButton *)sender {
    
    NSLog(@"12345678");

    //得到参数 itemID 以及 itemTypeID
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    [para setObject:self.TypeIdentifier forKey:@"itemTypeId"];
    [para setObject:self.itemIdentifier forKey:@"itemId"];
    
    //得到用户ID
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];

    [para setObject:userId forKey:@"userId"];


    //发送网络请求
    
    [[HRRequestManager manager]POST_PATH:PATH_CancelCollect para:para success:^(id responseObject) {
        //itemId = 2031;
//        itemTypeId = 2;
//        userId = 5026;
        
        
        NSDictionary *dict = responseObject;
        
        if ([dict[@"success"] intValue] == 1) {
        
            [self.delegate cancelCollectWith:[self.TypeIdentifier integerValue] isSuccess:YES];
        
        }else{
            [self.delegate cancelCollectWith:135 isSuccess:NO];
        }
        
        
    } failure:^(NSError *error) {
       
    }];

    
    
}

- (void)prepareNetRequest:(void (^)(LSCancelCollectModel *model))block {
    self.block = block;
    
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
