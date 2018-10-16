//
//  LSRegistCompanyViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/27.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSRegistCompanyViewController.h"

#import "LSRegistFinanceOrgnizationCell.h"
#define CELL_RegistFinanceOrgnization  @"RegistFinanceOrgnizationCell"

#import "LSAdressChoicePickView.h"

#import "GGPickerview.h"

#import "ZYQAssetPickerController.h"

@interface LSRegistCompanyViewController ()<LSRegistFinanceOrgnizationCellDelegate,ZYQAssetPickerControllerDelegate,UINavigationControllerDelegate>

{
    LSMyHUD *_window;
}

@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;

@property (strong, nonatomic) NSMutableArray *pickerData;

@property (strong, nonatomic) UIImage *imageUpdate;

@property (strong, nonatomic) UIImage *selectImage;

@end

@implementation LSRegistCompanyViewController

- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.title = @"企业会员";
    
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSRegistFinanceOrgnizationCell" bundle:nil] forCellReuseIdentifier:CELL_RegistFinanceOrgnization];
    
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


#pragma mark @ UITableViewDataSource && UITableViewDelegate @


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 866;
}

//返回cell高度
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    self.myCustomTableView.estimatedRowHeight = self.myCustomTableView.rowHeight;
//    self.myCustomTableView.rowHeight = UITableViewAutomaticDimension;
//    return self.myCustomTableView.rowHeight;
//}




-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSRegistFinanceOrgnizationCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_RegistFinanceOrgnization forIndexPath:indexPath];
    
    cell.delegate = self;
    
    //去掉分割线
    self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //cell点击变色
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.ProvinceArray = self.pickerData;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSLog(@"%@",indexPath);
    [self.view endEditing:YES];
    
}

#pragma mark ---- 代理方法（ 城市选择器 ）
-(void)showProvincePickerView{
    
//    LSAdressChoicePickView *address = [[LSAdressChoicePickView alloc] init];
//    
//    [self.view addSubview:address];
//    
//    weakSelf(weakSelf);
//    address.block = ^(LSAdressChoicePickView *view,UIButton *btn,AreaObject *locate){
//        
//        weakSelf.pickerData = [NSMutableArray arrayWithObjects:locate.province,locate.city,locate.area, nil];
//        
//        [weakSelf.myCustomTableView reloadData];
//        
//    };
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    weakSelf(weakSelf);
    GGPickerview *pickerView = [[GGPickerview alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-260, SCREEN_WIDTH, 260)];
    [pickerView getCityBlock:^(NSString *province, NSString *city, NSString *district) {
        NSLog(@"%@", province);
        weakSelf.pickerData = [NSMutableArray arrayWithObjects:province,city,district, nil];
        [weakSelf.myCustomTableView reloadData];
        [view removeFromSuperview];
        [pickerView removeFromSuperview];
    }];
    [pickerView delCityBlock:^{
        [view removeFromSuperview];
        [pickerView removeFromSuperview];
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:pickerView];
    
}

//代理方法.完成注册后执行弹窗代理方法

-(void)ifSuccessPrompt:(NSString *)word{
    
    [self promptBox_YTC_GeneralWithWords_epinasty:word];
    
    //此处添加判断,如果弹窗信息是"注册成功",三秒后返回登陆页面 如果注册失败,只进行弹窗提示
    
    
    if ([word isEqualToString:@"信息提交成功，请等待管理员审核"]) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UIWindow *window = [[UIApplication sharedApplication].delegate window];
            UINavigationController *navi = (UINavigationController *)window.rootViewController;
            [navi popToRootViewControllerAnimated:NO];
            UITabBarController *tabBar = navi.viewControllers[0];
            [tabBar setSelectedIndex:0];
            [self.presentingViewController.presentingViewController.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:^{

            }];
            
            
            
        });
    }else{
        [self promptBox_YTC_GeneralWithWords:word];
    }
    
}


#pragma mark ----- 代理方法（ 图片选择器 ）

-(void)pickeImageMethod{
    
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = 1;
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



#pragma mark - ZYQAssetPickerController Delegate 一张图片
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
    
    for (int i=0; i<assets.count; i++) {
        ALAsset *asset = assets[i];
        
        
        UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        
        self.imageUpdate = tempImg;
        
        self.selectImage = tempImg;
    }
    
    //结束图片选择将,图片赋值给cell
    //需要刷新cell
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    LSRegistFinanceOrgnizationCell *cell = [self.myCustomTableView cellForRowAtIndexPath:index];
    
    cell.imageUpdate = self.imageUpdate;
    
    [self shangchuanfuwuqi:self.selectImage andshu:1];
    
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
                
                NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
                
                LSRegistFinanceOrgnizationCell *cell = [self.myCustomTableView cellForRowAtIndexPath:index];
                
                cell.imgPathStr = dsDic[@"imgPath"];
                NSLog(@"imgPathStr=======%@",cell.imgPathStr);
                if (_window) {
                    [_window removeFromSuperview];
                    _window = nil;
                }
            }
        }
    }];
    
    [uploadTask resume];
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
