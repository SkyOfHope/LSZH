//
//  LSBuildInformationCell.h
//  LSZH
//
//  Created by risenb-ios5 on 16/6/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "LSjianzhuxinxiModel.h"
#import "LStotalCompeleteModel.h"



@protocol jianzhuxinxiDelegate <NSObject>
- (void)jianzhuxinxi:(LStotalCompeleteModel *)model;

@end

@interface LSBuildInformationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *jianzhuleixingTF;
@property (weak, nonatomic) IBOutlet UITextField *jianzhumianjiTF;
@property (weak, nonatomic) IBOutlet UITextField *jingcenggaoTF;
@property (weak, nonatomic) IBOutlet UITextField *wuyejibieTF;
@property (weak, nonatomic) IBOutlet UITextField *ruzhushijianTF;
@property (weak, nonatomic) IBOutlet UITextField *kaifashangTF;
@property (weak, nonatomic) IBOutlet UITextField *shejidanweiTF;
@property (weak, nonatomic) IBOutlet UITextField *shigongdanweiTF;



@property (nonatomic, assign)id <jianzhuxinxiDelegate> delegate;




@end
