//
//  LSMyInformationThirdTableViewCell.m
//  LSZH
//
//  Created by apple  on 16/8/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSMyInformationThirdTableViewCell.h"

@interface LSMyInformationThirdTableViewCell ()


@property (weak, nonatomic) IBOutlet UIButton *imageButton;


@end




@implementation LSMyInformationThirdTableViewCell

- (void)awakeFromNib {
    
    
    [self.imageButton addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
    
    
}


-(void)selectImage:(UIButton*)sender{
    
    if ([self.delegate respondsToSelector:@selector(openPhotoLabiary)]) {
        [self.delegate openPhotoLabiary];
    }
}


-(void)setIMageWithControllerSource:(UIImage *)image{
    
    [self.imageButton setBackgroundImage:image forState:UIControlStateNormal];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
