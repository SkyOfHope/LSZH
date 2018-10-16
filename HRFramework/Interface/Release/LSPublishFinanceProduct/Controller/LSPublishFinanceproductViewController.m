
//
//  LSPublishFinanceproductViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/25.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSPublishFinanceproductViewController.h"
#import "LSPublishFinanceProductCell.h"

#import "ZYQAssetPickerController.h"//第三方本地相册上传
#import "LSMyHUD.h"
#define CELL_PublishFinanceProduct  @"PublishFinanceProductCell"

@interface LSPublishFinanceproductViewController ()<publishDelegate, UIAlertViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, ZYQAssetPickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

{
    LSMyHUD *_window;
    NSString *PicFilePath;
}
@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;
@property (nonatomic, strong) UIAlertView *alertV;
@property (nonatomic, strong) NSMutableArray *selectimgArr;
@property (nonatomic, strong) NSMutableArray *imgURLsARR;

@property (nonatomic, assign) CGPoint offsetP;

@property (strong, nonatomic) NSMutableArray *imageArray;

@property (assign, nonatomic) BOOL isBigger;

@end

@implementation LSPublishFinanceproductViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"发布金融产品信息";
    
//    self.myCustomTableView.contentSize = CGSizeMake(SCREEN_WIDTH,MAXFLOAT);
//    self.view.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 10000000);
//    self.view.bounds = self.myCustomTableView.bounds;

    
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSPublishFinanceProductCell" bundle:nil] forCellReuseIdentifier:CELL_PublishFinanceProduct];
    
    self.selectimgArr = [NSMutableArray arrayWithCapacity:0];
    self.imgURLsARR = [NSMutableArray arrayWithCapacity:0];
    self.alertV = [[UIAlertView alloc]initWithTitle:@"发布"
                                            message:nil
                                           delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil, nil];
    self.myCustomTableView.bounces = NO;
    
    [self configUI];
    
    self.imageArray = [NSMutableArray array];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.isBigger = NO;
    
    
    
}

//-(void)sahcnhushuzutupian:(NSNotification*)notic{
//    
//    _selectimgArr removeObject:notic[]
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"LSPublishFinanceProductCellreceiveImages" object:_selectimgArr];
//
//}



- (void)configUI {
    
    [self configLeftBarButton];
    
}
- (void)configLeftBarButton {
    [self navigationLeftBarButtonImageNames:@[@"返回"] click:^(NSInteger buttonTag) {
        NSLog(@"dahjkda");
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
}

#pragma mark @ UITableViewDataSource && UITableViewDelegate @
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    if (self.isBigger == NO) {
        return 881;
    }else{
        
        return 981;
    }
    
}


//返回cell高度
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    self.myCustomTableView.estimatedRowHeight = self.myCustomTableView.rowHeight;
//    self.myCustomTableView.rowHeight = UITableViewAutomaticDimension;
//    
////    if (self.isBigger) {
////        return self.myCustomTableView.rowHeight + 70;
////    }else{
//        return self.myCustomTableView.rowHeight;
////    }
//
//}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSPublishFinanceProductCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_PublishFinanceProduct forIndexPath:indexPath];
    
    cell.delegate = self;

    cell.blockForNew = ^(BOOL isbig){

        
        self.isBigger = isbig;
        
        [self.myCustomTableView reloadData];
        
        
        
    };
    
    //去掉分割线
    self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //cell点击变色
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    return cell;
}



#pragma mark ------代理方法(cell传值)
- (void)uploadImg {
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:nil
                                                     delegate:self
                                            cancelButtonTitle:@"取消"
                                       destructiveButtonTitle:nil
                                            otherButtonTitles:@"从手机相册选择",@"拍照",nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;//设置样式
    sheet.tag = 642016;
    [sheet showInView:self.view];
    
}


-(void)getOffset:(CGFloat)viewY{
    
//    self.offsetP = self.myCustomTableView.contentOffset;
    
    self.myCustomTableView.contentOffset = CGPointMake(0, viewY);
    
}

-(void)setOffset{
    
//    self.myCustomTableView.contentOffset = self.offsetP;
    self.myCustomTableView.contentOffset = CGPointMake(0, 0);
}


-(void)reloadData{
    [self.myCustomTableView beginUpdates];
    
    [self.myCustomTableView endUpdates];

    
}

- (void) publishAction:(LSpublishModel *)model {
    //   PATH_AddJinRong
    

        
        //*productNameTF;//产
        //*productTypeTF;//产
        //*issuerTF; //发行单位
        //*organzationTypeTF;
        //*detailTF;
        //*instructionDetailt
        //*applicableCustomer
        //*requirementTF;
        //*materialTF;//所需材
        //*processTF;//办理流程
        //*keyWordsTF;
        //*remarksTF;
    
    
    if (model.productName.length > 0 && model.productType.length > 0 && model.issuer.length > 0 && model.organzationType.length > 0 && model.detail.length > 0 && model.instructionDetail.length > 0 && model.applicableCustomer.length > 0 && model.requirement.length > 0 && model.material.length > 0 && model.process.length > 0 && model.keyWords.length > 0 && model.remarks.length > 0) {
        if (model.protocolIsSelected) {
            
            NSMutableDictionary *para = [NSMutableDictionary dictionary];
            NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
            
            [para setObject:userId forKey:@"userId"];
            [para setObject:model.productName forKey:@"title"];
            [para setObject:model.productType forKey:@"productType"];
            [para setObject:model.issuer forKey:@"unit"];
            [para setObject:model.organzationType forKey:@"unitType"];
            [para setObject:model.detail forKey:@"productSummary"];
            [para setObject:model.instructionDetail forKey:@"advantage"];
            [para setObject:model.applicableCustomer forKey:@"client"];
            [para setObject:model.requirement forKey:@"condition"];
            [para setObject:model.material forKey:@"information"];
            [para setObject:model.process forKey:@"flow"];
            [para setObject:model.keyWords forKey:@"keyword"];
            [para setObject:model.remarks forKey:@"remark"];
            if (self.imgURLsARR.count>0) {
                NSString *urlStr = [self.imgURLsARR componentsJoinedByString:@","];
                [para setObject:urlStr forKey:@"imgPaths"];
            }
            
            [[HRRequestManager manager] POST_PATH:PATH_AddJinRong para:para success:^(id responseObject) {
                if ([responseObject isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary * dic = (NSDictionary *)responseObject;
                    NSString *success = [dic objectForKey:@"success"];
                    
                    if ([success isEqualToString:@"1"])
                    {
                        
                        [self.alertV setTitle:@"发布成功！"];
                        [_alertV show];
                        
                        [self.navigationController popToRootViewControllerAnimated:YES];
                        
                    } else {
                        [self.alertV setTitle:@"发布失败"];
                        [_alertV show];
                    }
                    
                }
                
            } failure:^(NSError *error) {
                [self.alertV setTitle:@"发布失败"];
                [_alertV show];
                
            }];
            
            
        }else{
            [self promptBox_YTC_GeneralWithWords:@"请勾选 保证上述信息真实有效"];
        }
    }else{
        [self promptBox_YTC_GeneralWithWords:@"请填写所有数据"];
    }
    
}

#pragma mark - ||==========UIActionSheetDelegate===========||
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet.tag == 642016) {
        if (buttonIndex==0) {
            [self LocalPhoto];
        } else if (buttonIndex ==1){
            
            [self takePhoto];
            
        } else {
            
            NSLog(@"取消");
            
        }
        
    }
    
}


//删除照片
-(void)deleteImage:(NSInteger)index{
    
    [self.selectimgArr removeObjectAtIndex:index];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LSPublishFinanceProductCellreceiveImages" object:_selectimgArr];
    
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
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
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
        
        
        
        
        //背景图
        NSArray *PicPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *PicDocumentsDirectory = [PicPaths objectAtIndex:0];
        NSString *PicFullPathToFile = [PicDocumentsDirectory stringByAppendingPathComponent:@"touImage.png"];
        NSLog(@"=======  PicFullPathToFile   ==========%@",PicFullPathToFile);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.selectimgArr addObject:image];

            [self shangchuanfuwuqi:image andshu:1];
            
        });
        
    }
}

#pragma mark - ZYQAssetPickerController Delegate 一张图片
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
    
    for (int i=0; i<assets.count; i++) {
        ALAsset *asset = assets[i];

        UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];

        CGSize imagesize = tempImg.size;
        if (_selectimgArr.count > 4) {

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"添加图片不可多于5张，超出第三张不做显示！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        } else {
            //对图片大小进行压缩--
            tempImg = [self imageWithImage:tempImg scaledToSize:imagesize];
            
            [self shangchuanfuwuqi:tempImg andshu:i+1];
            
            [self.selectimgArr addObject:tempImg];
            
            [self.imageArray addObject:tempImg];
            
        }

    }
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LSPublishFinanceProductCellreceiveImages" object:_selectimgArr];
    
    
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
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LSPublishFinanceProductCellreceiveImages" object:_selectimgArr];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
