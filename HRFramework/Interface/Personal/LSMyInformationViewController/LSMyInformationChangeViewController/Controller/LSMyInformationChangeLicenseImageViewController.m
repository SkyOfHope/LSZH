//
//  LSMyInformationChangeLicenseImageViewController.m
//  LSZH
//
//  Created by apple  on 16/8/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSMyInformationChangeLicenseImageViewController.h"


#import "LSChangeHeaderView.h"

@interface LSMyInformationChangeLicenseImageViewController ()<changeIconDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    LSMyHUD *_window;
}

@property (weak, nonatomic) IBOutlet UIButton *imageButton;

@property (weak, nonatomic) IBOutlet UIButton *sureChange;


@property (strong, nonatomic) LSChangeHeaderView *chooseView;

@property (strong, nonatomic) NSString *imgPathStr;

@property (strong, nonatomic) UIImage *selectImage;

@end

@implementation LSMyInformationChangeLicenseImageViewController

- (LSChangeHeaderView *)chooseView {
    if (!_chooseView) {
        _chooseView = [[LSChangeHeaderView alloc]init];
        _chooseView.backgroundColor = RGBA(0, 0, 0, 0.5);
        
        _chooseView.delegate = self;
        _chooseView.hidden = YES;
        _chooseView.layer.cornerRadius = 5;
        _chooseView.layer.masksToBounds = YES;
        [AppDelegate.window addSubview:_chooseView];
        
        _chooseView.frame = SCREEN_BOUNDS;
    }
    return _chooseView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"修改营业执照照片";
    
    
        UIImageView *img = [[UIImageView alloc]init];
        [img sd_setImageWithURL:[NSURL URLWithString:self.orginImageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [self.imageButton setBackgroundImage:img.image forState:UIControlStateNormal];
        }];

    self.sureChange.layer.cornerRadius = 20;
    self.sureChange.layer.masksToBounds = YES;
    
    [self.imageButton addTarget:self action:@selector(selecteImageForLicenseImage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.sureChange addTarget:self action:@selector(sureChangeActioc) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

-(void)sureChangeActioc{
    
    if (self.imgPathStr) {
        [self changeInformationAction];
        
        if ([self.delegate respondsToSelector:@selector(getImage:ORImagePath:)]) {
            [self.delegate getImage:self.selectImage ORImagePath:self.imgPathStr];
        }
        
    }else{
        NSLog(@"没有图片");
    }
}

-(void)selecteImageForLicenseImage{
    
    [self.chooseView setHidden:NO];
    
}



- (void)takePhotoAction {
    self.chooseView.hidden = YES;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"该设备无相机！"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)localPhotoAction {
    self.chooseView.hidden = YES;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
//    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
    
}


#pragma mark - ---------- 图片相关 ----------

//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self tipLabelAnimationWith:@"取消选择图片"];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        CGSize imagesize = image.size;
        imagesize.height = SCREEN_WIDTH;
        imagesize.width = SCREEN_HEIGHT;
        
        //对图片大小进行压缩--
        image = [self imageWithImage:image scaledToSize:imagesize];
        
        self.selectImage = image;
        
        [self.imageButton setBackgroundImage:image forState:UIControlStateNormal];
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 0.5);
        }
        else {
            data = UIImageJPEGRepresentation(image, 0.5);
            
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/touImage.png"] contents:data attributes:nil];
        
        //背景图
        NSArray *PicPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *PicDocumentsDirectory = [PicPaths objectAtIndex:0];
        NSString *PicFullPathToFile = [PicDocumentsDirectory stringByAppendingPathComponent:@"touImage.png"];
        NSLog(@"=======  PicFullPathToFile   ==========%@",PicFullPathToFile);
        //                [_table reloadData];//刷新
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self shangchuanfuwuqi:image andshu:1];
            
        });
        
    }
}


-(void)shangchuanfuwuqi:(UIImage *)img andshu:(int )Num {
    
    NSData *data;
    if (_window == nil) {
        _window = [[LSMyHUD alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_window];
    }
    
    if (UIImagePNGRepresentation(img) == nil) {
        data = UIImageJPEGRepresentation(img, 0.5);
    }
    else {
        data = UIImageJPEGRepresentation(img, 0.5);
    }
    NSString *str = [NSString stringWithFormat:@"http://www.wcsyq.gov.cn/API/UploadImg.ashx"];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    //    [parameters setObject:@"image" forKey:@"fileType"];//文件类型
    [parameters setObject:data forKey:@"imgPath"]; // 二进制传输文件
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:str parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png",str];
        [formData appendPartWithFileData:data name:@"imgPath" fileName:fileName mimeType:@"image/png"];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        // This is not called back on the main queue.
        // You are responsible for dispatching to the main queue for UI updates
        dispatch_async(dispatch_get_main_queue(), ^{
            //Update the progress view 上传进度
            //            [progressView setProgress:uploadProgress.fractionCompleted];
        });
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"error%@",error);
            
            if (_window) {
                [_window removeFromSuperview];
                _window = nil;
            }
        }
        else {
            id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"result%@",result);
            
            if ([result isKindOfClass:[NSDictionary class]]) {
                NSDictionary *resultDic = (NSDictionary *)result;
                NSDictionary *dsDic = resultDic[@"ds"];
                self.imgPathStr = dsDic[@"imgPath"];
                if (_window) {
                    [_window removeFromSuperview];
                    _window = nil;
                }
            }
            NSLog(@"imgPathStr=======%@",self.imgPathStr);
        }
        
        //修改服务器数据
    }];
    
    [uploadTask resume];
}



-(void)changeInformationAction{
    
    //获取参数
    
    
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    
    //创建参数字典
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithObject:userId forKey:@"userId"];
    
    //其他参数
    
    [para setObject:self.imgPathStr forKey:@"licenseImg"];
    
    //网络修改数据
    [[HRRequestManager manager]POST_PATH:PATH_UpdateUser para:para success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            
            NSLog(@"修改成功");
            
            //提示成功
            [self promptBox_YTC_GeneralWithWords_epinasty:@"修改成功"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                
                [userDefault setObject:nil forKey:@"userId"];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
                
                UINavigationController *navi = (UINavigationController *)[[UIApplication sharedApplication].delegate window].rootViewController;
                
                UITabBarController *tabBarVC = [navi.viewControllers firstObject];
                tabBarVC.selectedIndex = 0;
                
            });
            
            
        }else{
            [self promptBox_YTC_GeneralWithWords_epinasty:@"修改失败"];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}




//提示框

-(void)tipLabelAnimationWith:(NSString*)tip{
    
    UILabel *promptLabel = [[UILabel alloc]init];
    
    CGFloat width = SCREEN_WIDTH / 2 * 1.4;
    CGFloat height = width * 0.2;
    
    promptLabel.alpha = 0;
    
    promptLabel.frame = CGRectMake(SCREEN_WIDTH / 2 - width/2 , SCREEN_WIDTH / 2 * 1.4 + 200, width, height);
    promptLabel.backgroundColor = [UIColor blackColor];
    promptLabel.textColor = [UIColor whiteColor];
    promptLabel.layer.cornerRadius = height / 2;
    promptLabel.layer.masksToBounds = YES;
    
    promptLabel.textAlignment = 1;
    
    promptLabel.layer.cornerRadius = 25;
    promptLabel.layer.masksToBounds = YES;
    
    promptLabel.text = tip;
    
    [self.view addSubview:promptLabel];
    
    [UIView animateWithDuration:1.5 animations:^{
        promptLabel.alpha = 0.8;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:3 animations:^{
            promptLabel.alpha = 0;
        } completion:^(BOOL finished) {
 
        }];
        
    }];
    
}




@end
