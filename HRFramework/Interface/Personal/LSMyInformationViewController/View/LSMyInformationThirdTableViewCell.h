//
//  LSMyInformationThirdTableViewCell.h
//  LSZH
//
//  Created by apple  on 16/8/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSMyInformationThirdTableViewCellDelegate <NSObject>


-(void)openPhotoLabiary;


@end


@interface LSMyInformationThirdTableViewCell : UITableViewCell

-(void)setIMageWithControllerSource:(UIImage*)image;


@property (weak, nonatomic)id<LSMyInformationThirdTableViewCellDelegate> delegate ;

@end
