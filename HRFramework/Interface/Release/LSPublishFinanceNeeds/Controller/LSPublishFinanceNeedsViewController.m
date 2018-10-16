//
//  LSPublishFinanceNeedsViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSPublishFinanceNeedsViewController.h"
#import "LSInsdustryViewController.h"
#import "AFNetworking.h"
#import "LSPublishFinanceNeedsCell.h"
#import "LSOfficeRentNewSizeView.h"
#import "ZYQAssetPickerController.h"//第三方本地相册上传
//#import "MBProgressHUD.h"
#import "LSMyHUD.h"
#define CELL_PublishFinanceNeeds  @"PublishFinanceNeedsCell"

@interface LSPublishFinanceNeedsViewController () <uploadImgDelegate, UIActionSheetDelegate, UIAlertViewDelegate, UINavigationControllerDelegate, ZYQAssetPickerControllerDelegate,sureDelegate>
{
    NSString *PicFilePath;
    LSMyHUD *_window;

}
@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;

@property (strong, nonatomic) NSMutableDictionary *para;
@property (nonatomic, strong) UIAlertView *alretV;
@property (nonatomic, strong) NSMutableArray *selectimgArr;
@property (nonatomic, strong) NSMutableArray *imgURLsARR;

@property (nonatomic, assign) CGPoint offsetP;

@property (assign, nonatomic) BOOL isBigger;

@property (strong,nonatomic) MBProgressHUD *hud;

@end

@implementation LSPublishFinanceNeedsViewController


#pragma mark - ||========== LifeCycle ===========||

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    
    
    
    
}


// 视图加载完毕
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"发布融资需求信息";
    
    self.para = [NSMutableDictionary dictionary];
    self.selectimgArr = [NSMutableArray arrayWithCapacity:0];
    self.imgURLsARR = [NSMutableArray arrayWithCapacity:0];
    self.selectimgArr = [NSMutableArray arrayWithCapacity:0];
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSPublishFinanceNeedsCell" bundle:nil] forCellReuseIdentifier:CELL_PublishFinanceNeeds];
    
    self.alretV = [[UIAlertView alloc]initWithTitle:@"发布"
                                            message:nil
                                           delegate:self
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil, nil];
    
    self.isBigger = NO;
    
    [self configUI];

}

- (void)configUI {
    
    [self configLeftBarButton];
    
}
- (void)configLeftBarButton {
    [self navigationLeftBarButtonImageNames:@[@"返回"] click:^(NSInteger buttonTag) {
        NSLog(@"dahjkda");
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
}



- (void)handleSelectArr:(NSMutableArray *)selectedArr {
    

}


//代理方法

-(void)getOffset{
    
    self.offsetP = self.myCustomTableView.contentOffset;
    
}

-(void)setOffset{
    
    self.myCustomTableView.contentOffset = self.offsetP;
    
}



- (void)reloadData {
//    [self.myCustomTableView reloadData];
    [self.myCustomTableView beginUpdates];
    [self.myCustomTableView endUpdates];
    
}

-(void)deleteImage:(NSInteger)index{
    
    [self.selectimgArr removeObjectAtIndex:index];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LSPublishFinanceNeedsCellreceiveImages" object:_selectimgArr];

    
}


#pragma mark @ UITableViewDataSource && UITableViewDelegate @


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    if (self.isBigger == NO) {
        return 870;
    }else{
        
        return 970;
    }
    
}

////返回cell高度
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    self.myCustomTableView.estimatedRowHeight = self.myCustomTableView.rowHeight;
//    self.myCustomTableView.rowHeight = UITableViewAutomaticDimension;
//    return self.myCustomTableView.rowHeight;
//}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSPublishFinanceNeedsCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_PublishFinanceNeeds forIndexPath:indexPath];
    cell.delegate = self;
    
    
    
    weakSelf(weakSelf);
    [cell prepareNetRequest:^(LSPublishFinanceModel *model) {
//        26
        //  imgPaths  上传的图片集合（用英文,隔开。如“图片1地址,图片2地址, 图片3地址,…”）
        
        NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
        
        [self.para setObject:userId forKey:@"userId"];
        [self.para setObject:model.title forKey:@"title"];
        [self.para setObject:model.keyWord forKey:@"keyword"];
        [self.para setObject:model.financeUse forKey:@"rongziYongtu"];
        [self.para setObject:model.financeMoney forKey:@"rongziMoneyStart"];
        [self.para setObject:model.allmoney forKey:@"totalMoney"];
        [self.para setObject:model.provideMaterial forKey:@"tigongZiliao"];
        [self.para setObject:model.projectDescripe forKey:@"xiangmuGaishu"];
        [self.para setObject:model.projectGood forKey:@"xiangmuYoushi"];
        
#pragma mark  未完成。。。
//        [self.para setObject:model.area forKey:@"county"];
//        [self.para setObject:model.area forKey:@"province"];
//        [self.para setObject:model.area forKey:@"city"];
        [self.para setObject:model.insdustry forKey:@"suoshuHangye"];
//        [self.para setObject:model.intentional forKey:@"yixiangZijin"];
        [self.para setObject:model.financingMode forKey:@"rongziWay"];
        [self.para setObject:model.financeTheme forKey:@"rongziZhuti"];
        [self.para setObject:model.remark forKey:@"remark"];
    
        if (self.imgURLsARR.count>0) {
            NSString *urlStr = [self.imgURLsARR componentsJoinedByString:@","];
            [self.para setObject:urlStr forKey:@"imgPaths"];
        }
        
        [weakSelf requestAddJinRong];
    }];
    
    
    cell.blockForSuccess = ^(BOOL isbigger){
        
        self.isBigger = isbigger;
        [self.myCustomTableView reloadData];
    };
    
    return cell;
}

//代理方法:决定控制器弹窗内容
-(void)promptForCell:(NSString *)prompt{
    
    if (prompt.length > 0) {
        
//        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        
//        self.hud.mode = MBProgressHUDModeText;
//        self.hud.labelText = prompt;
//        self.hud.labelFont = [UIFont systemFontOfSize:19];
//        [self.hud show:YES];
//        
//        [self.hud hide:YES afterDelay:3];
        
        [self promptBox_YTC_GeneralWithWords_epinasty:prompt];

    }else{
        return;
    }
}

#pragma mark - ||==========数据请求===========||
-(void)requestAddJinRong {

    [[HRRequestManager manager] POST_PATH:PATH_AddFinancing para:self.para success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            NSDictionary * dic = (NSDictionary *)responseObject;
            NSString *success = [dic objectForKey:@"success"];
            
            if ([success isEqualToString:@"1"])
            {
                
                [self.alretV setTitle:@"发布成功！"];
                [_alretV show];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            } else {
                [self.alretV setTitle:@"发布失败"];
                [_alretV show];
            }
            
        }
        
    } failure:^(NSError *error) {
        [self.alretV setTitle:@"发布失败"];
        [_alretV show];
        
    }];
    
}

//代理方法
- (void)uploadAction {
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:nil
                                                     delegate:self
                                            cancelButtonTitle:@"取消"
                                       destructiveButtonTitle:nil
                                            otherButtonTitles:@"从手机相册选择",@"拍照",nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;//设置样式
    sheet.tag = 622016;
    [sheet showInView:self.view];

}

- (void)industrySelectAction {

    LSInsdustryViewController *insdustryCntl = [[LSInsdustryViewController alloc]init];
    [self.navigationController pushViewController:insdustryCntl animated:YES];

}

#pragma mark - ||==========UIActionSheetDelegate===========||

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 622016) {
        if (buttonIndex==0) {
            [self LocalPhoto];
        } else if (buttonIndex ==1){
            
            [self takePhoto];
            
        } else {
            
            NSLog(@"取消");
            
        }

    }
    
}

- (void) LocalPhoto {
    
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = 5 - self.selectimgArr.count;
    picker.showCancelButton = YES;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups = NO;
    picker.delegate = self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 3;
        } else {
            return YES;
        }
    }];
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void) takePhoto {
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    } else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }

}

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
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)assetPickerControllerDidMaximum:(ZYQAssetPickerController *)picker {
    picker.maximumNumberOfSelection = 3;
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
//    if (!_window) {
//        _window =[[LSMyHUD alloc] initWithFrame:self.view.bounds];
//        [self.view addSubview:_window];
//    }
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
        
        //得到选择后沙盒中图片的完整路径
        PicFilePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath, @"/touImage.png"];
        NSLog(@"%@",PicFilePath);
        
        
        //背景图
        NSArray *PicPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *PicDocumentsDirectory = [PicPaths objectAtIndex:0];
        NSString *PicFullPathToFile = [PicDocumentsDirectory stringByAppendingPathComponent:@"touImage.png"];
        NSLog(@"=======  PicFullPathToFile   ==========%@",PicFullPathToFile);
        //                [_table reloadData];//刷新
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.selectimgArr addObject:image];
            
            [self shangchuanfuwuqi:image andshu:1];
            
        });
        
    }

}

#pragma mark - ZYQAssetPickerController Delegate 一张图片
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
    
//    [self.selectimgArr removeAllObjects];
    
    for (int i=0; i<assets.count; i++) {
        ALAsset *asset = assets[i];
        
        
        UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        
        CGSize imagesize = tempImg.size;
        if (_selectimgArr.count > 4) {
//            _selectimgArr.count = 8;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"添加图片不可多于3张，超出第三张不做显示！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        } else {
            //对图片大小进行压缩--
            tempImg = [self imageWithImage:tempImg scaledToSize:imagesize];
            
            [self shangchuanfuwuqi:tempImg andshu:i+1];
            
           
            [self.selectimgArr addObject:tempImg];
        
        }
    }
   
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LSPublishFinanceNeedsCellreceiveImages" object:_selectimgArr];
   
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
                NSString *imgPathStr = [NSString string];
                imgPathStr = dsDic[@"imgPath"];
                [self.imgURLsARR addObject:imgPathStr];
                
                if (_window) {
                    [_window removeFromSuperview];
                    _window = nil;
                }
            }
            NSLog(@"imgURLsARR=======%@",self.imgURLsARR);
        
        }
    }];

    [uploadTask resume];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LSPublishFinanceNeedsCellreceiveImages" object:_selectimgArr];
    
}





@end
