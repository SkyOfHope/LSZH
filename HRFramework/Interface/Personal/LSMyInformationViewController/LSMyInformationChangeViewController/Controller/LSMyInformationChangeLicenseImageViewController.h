//
//  LSMyInformationChangeLicenseImageViewController.h
//  LSZH
//
//  Created by apple  on 16/8/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "HRBaseViewController.h"


@protocol LSMyInformationChangeLicenseImageViewControllerDelegate <NSObject>

-(void)getImage:(UIImage*)image ORImagePath:(NSString*)imagePath;


@end




@interface LSMyInformationChangeLicenseImageViewController : HRBaseViewController


@property (strong, nonatomic) NSString *orginImageUrl;


@property (weak, nonatomic) id<LSMyInformationChangeLicenseImageViewControllerDelegate> delegate;

@end
