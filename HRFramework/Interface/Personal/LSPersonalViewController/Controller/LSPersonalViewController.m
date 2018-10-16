//
//  LSPersonalViewController.m
//  LSZH
//
//  Created by 穆英波 on 16/5/18.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSPersonalViewController.h"

#import "LSPersonalTableViewCell.h"
#define CELL_Personal  @"PersonalCell"

#import "LSPersonalHeaderView.h"
#import "LSPersonalSetViewController.h"
#import "LSChangeHeaderView.h"
#import "LSMyInfomationViewController.h"
#import "LSMyPersonalPublishViewController.h"
#import "LSMyMailboxViewController.h"
#import "LSSendAppointmentViewController.h"
#import "LSMyCollectionViewController.h"
#import "UIImageView+WebCache.h"
#import "LSMyHUD.h"
#import "LSLoginViewController.h"
#import "LSMyInfomationPersonalViewController.h"

@interface LSPersonalViewController ()<changeIconDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,LSLoginViewControllerDelegate>
{
    LSMyHUD *_window;
}
@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;

@property (strong, nonatomic) LSChangeHeaderView *chooseView;
@property (strong, nonatomic) LSPersonalHeaderView * personalHeader;
@property (nonatomic, copy) NSString *imgPathStr;
@property (nonatomic, strong) UIImage *headimg;
/**
 *  tableView 数据源
 */
@property (strong,nonatomic) NSArray *imgArr;



@end

@implementation LSPersonalViewController
#pragma mark - ||========== Lazy loading ===========||

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


-(LSPersonalHeaderView *)personalHeader{
    if (!_personalHeader)
    {
        _personalHeader = [[NSBundle mainBundle] loadNibNamed:@"LSPersonalHeaderView" owner:nil options:nil].lastObject;
        
        [_personalHeader chooseHeaderView:^{
            self.chooseView.hidden = NO;
            [AppDelegate.window bringSubviewToFront:self.chooseView];
            
        }];
    }
    return _personalHeader;
}

#pragma mark - ||========== LifeCycle ===========||
// 视图加载完毕
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(personalPost:) name:@"personalPost" object:nil];
    
    
    self.imgArr = [[NSArray alloc] init];
    
    self.imgArr = @[@"我的资料",@"我的收藏",@"我的发布",@"设置"];
    
    
    [self configUI];
}

-(void)personalPost:(NSNotification*)notic{
    
    NSLog(@"%@",notic);
    
    NSMutableDictionary *dict = (NSMutableDictionary*)[notic userInfo];
    
    LSLoginViewController *loginVC = [[LSLoginViewController alloc]initWithNibName:@"LSLoginViewController" bundle:nil];
    loginVC.delegate = self;
    loginVC.dict = dict;
    loginVC.registtype = registType_presonal;

    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [self presentViewController:loginVC animated:YES completion:nil];
    
        
    
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


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];

    [self configNavigationTitle];
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    
    NSString *userId = [userdefault objectForKey:@"userId"];
    
    if (userId == nil) {
        
        LSLoginViewController *loginVC = [[LSLoginViewController alloc]initWithNibName:@"LSLoginViewController" bundle:nil];
        loginVC.delegate = self;
        
//        loginVC.registtype = registType_other;
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    else{
        [self loadPersonalController];
    }
    self.myCustomTableView.bounces = NO;
    
    [self loadPersonalController];
}

//个人页面登录后调用代理方法刷新界面
-(void)LoadPersonalControllerAfterLogin{
    [self loadPersonalController];
    [self.myCustomTableView reloadData];
}

//个人页面数据加载
-(void)loadPersonalController{
    
    [self configNavigationTitle];
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSPersonalTableViewCell" bundle:nil] forCellReuseIdentifier:CELL_Personal];
    
    self.myCustomTableView.tableHeaderView = self.personalHeader;
    
    self.imgArr = [[NSArray alloc] init];
    
    self.imgArr = @[@"我的资料",@"我的收藏",@"我的发布",@"设置"];
    self.imgPathStr = [NSString string];

    [self infoHTTPS];
    
}

- (void)infoHTTPS {
    
    weakSelf(weakSelf);
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    
    if (userId.length > 0) {
        
        [para setObject:userId forKey:@"userId"];
    }
    
    [[HRRequestManager manager] GET_PATH:PATH_GetUserInfo para:para success:^(id responseObject) {
       
        NSDictionary * dic = (NSDictionary *)responseObject;
        NSString *success = [dic objectForKey:@"success"];
        
        if ([success isEqualToString:@"1"])
        {
            /*
             {
             ds =     {
             address = "";
             city = "";
             county = "";
             email = 45615613;
             headImg = "http://www.wcsyq.gov.cnhttp://www.wcsyq.gov.cn/upload/2016-06/20160608095439979.png";
             licenseCode = 256wrgaer211111;
             licenseImg = "http://www.wcsyq.gov.cn/upload/123.jpg";
             mobile = 18903264623;
             nickname = "";
             organizationName = 111;
             principalName = 45641561361435;
             province = "拉胡";
             realname = "";
             remark = asgeroahgoea;
             sex = "";
             userTypeName = "园区";
             };
             errMsg = "";
             success = 1;
             }
             */
            NSDictionary *dsDic = dic[@"ds"];
            NSString *headImgStr = dsDic[@"headImg"];
            dispatch_async(dispatch_get_main_queue(), ^{
                //换头像
                [weakSelf.personalHeader.headerIconImg sd_setImageWithURL:[NSURL URLWithString:headImgStr]placeholderImage:[UIImage imageNamed:@"头像" ]];
                
                weakSelf.personalHeader.headerIconImg.layer.cornerRadius = 40;
                weakSelf.personalHeader.headerIconImg.layer.masksToBounds = YES;
                //根据不同类型的用户设置不同的名称
                if ([dsDic[@"userTypeName"] isEqualToString:@"个人"]) {
                    weakSelf.personalHeader.nameLab.text = dsDic[@"nickname"];
                }else{
                    weakSelf.personalHeader.nameLab.text = dsDic[@"organizationName"];
                }
                //设置右上角类型label的显示
                                
                weakSelf.personalHeader.phoneLab.text = dsDic[@"mobile"];
//                weakSelf.personalHeader.qiyeLab.text = dsDic[@"userTypeName"];
                
                weakSelf.personalHeader.qiyeLab.text = [NSString stringWithFormat:@" %@  ",dsDic[@"userTypeName"]];
                
            });
            
            
        } else {
            
        }
        
    } failure:^(NSError *error) {
        
        
    }];

}

#pragma mark - ||========= 通知方法 =========||

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
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];

}

#pragma mark - ---------- Private Methods ----------

- (void)configNavigationTitle {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    titleLabel.text = @"个人中心";
    titleLabel.textColor = RGB_0X(0x333333);
    titleLabel.font = FONT(17);
    self.tabBarController.navigationItem.titleView = titleLabel;
    
}


#pragma mark @ UITableViewDataSource && UITableViewDelegate @

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.imgArr.count;
}


//返回cell高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.myCustomTableView.estimatedRowHeight = self.myCustomTableView.rowHeight;
    self.myCustomTableView.rowHeight = UITableViewAutomaticDimension;
    return self.myCustomTableView.rowHeight;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSPersonalTableViewCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_Personal forIndexPath:indexPath];
    
    cell.imageName.text = self.imgArr[indexPath.row];
//    cell.images = [UIImage imageNamed:[self.imgArr [indexPath.row]]];
    cell.images.image = [UIImage imageNamed:self.imgArr[indexPath.row]];
    
    //去掉分割线
    self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //cell点击变色
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"%@",indexPath);
     
    switch (indexPath.row) {
        case 0:{
            NSLog(@"我的资料");
            
            //取出用户类型,根据用户类型判断进入那种界面
            NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];

            NSString *userTypeId = [userdefault objectForKey:@"userTypeId"];
            
//            NSString *userTypeId = @"4";
            //如果是前三种均为同一种格式
            if ([userTypeId isEqualToString:@"1"] || [userTypeId isEqualToString:@"2"] || [userTypeId isEqualToString:@"3"]) {
                LSMyInfomationViewController *myInfomationVC = [[LSMyInfomationViewController alloc] initWithNibName:@"LSMyInfomationViewController" bundle:nil];
                
                [self.navigationController pushViewController:myInfomationVC animated:YES];
                
                //个人模式
            }else if ([userTypeId isEqualToString:@"4"]){
                
                LSMyInfomationPersonalViewController *persionalinformation = [[LSMyInfomationPersonalViewController alloc]initWithNibName:@"LSMyInfomationPersonalViewController" bundle:nil];
                
                [self.navigationController pushViewController:persionalinformation animated:YES];
                
            }else{
                return;
            }
        }
            break;
        case 1:{
            NSLog(@"我的收藏");
            
            LSMyCollectionViewController *myCollectionVC = [[LSMyCollectionViewController alloc] initWithNibName:@"LSMyCollectionViewController" bundle:nil];
            
            [self.navigationController pushViewController:myCollectionVC animated:nil];

        }
            break;
        case 2:{
            NSLog(@"我的发布");
            
            LSMyPersonalPublishViewController *publishVC = [[LSMyPersonalPublishViewController alloc] initWithNibName:@"LSMyPersonalPublishViewController" bundle:nil];
            
            [self.navigationController pushViewController:publishVC animated:nil];
        }
            break;
        case 3:
        {
            NSLog(@"设置");
            LSPersonalSetViewController *personalSetVC = [[LSPersonalSetViewController alloc] initWithNibName:@"LSPersonalSetViewController" bundle:nil];
            
            [self.navigationController pushViewController:personalSetVC animated:YES];
        }
            break;
            
        default:
            break;
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
    [self tipLabelAnimationWith:@"取消选择图片"];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *imgKey;
    UIImage *imageYS;
    imgKey = UIImagePickerControllerEditedImage;
    imageYS=[info objectForKey:imgKey];
    
    UIImage *imgJQ;
    
    imgJQ = [info objectForKey:imgKey];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        

        UIImage* image = imgJQ;
//        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        CGSize imagesize = image.size;
        imagesize.height = SCREEN_WIDTH;
        imagesize.width = SCREEN_HEIGHT;
        
        //对图片大小进行压缩--(图片压缩，因为原图都是很大的，不必要传原图)
        image = [self imageWithImage:image scaledToSize:imagesize];
        
        self.headimg = image;
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            //将图片转换为JPG格式的二进制数据
            data = UIImageJPEGRepresentation(image, 0.5);
        }
        else {
            //将图片转换为PNG格式的二进制数据
//            data = UIImagePNGRepresentation(image);
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
//        PicFilePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath, @"/touImage.png"];
//        NSLog(@"%@",PicFilePath);
        
        //背景图
        NSArray *PicPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *PicDocumentsDirectory = [PicPaths objectAtIndex:0];
        NSString *PicFullPathToFile = [PicDocumentsDirectory stringByAppendingPathComponent:@"touImage.png"];
        NSLog(@"=======  PicFullPathToFile   ==========%@",PicFullPathToFile);
        //                [_table reloadData];//刷新
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.PicFilePathArr addObject:PicFilePath];
            
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

            
            [self changeIconAction];
        }
    }];
    
    [uploadTask resume];
}


- (void)changeIconAction {
//、、  PATH_UpdateUserHeadImg
    
    weakSelf(weakSelf);
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    
    [para setObject:userId forKey:@"userId"];
    [para setObject:self.imgPathStr forKey:@"imgPath"];
    
    [[HRRequestManager manager] GET_PATH:PATH_UpdateUserHeadImg para:para success:^(id responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        NSString *success = [dic objectForKey:@"success"];
        
        if ([success isEqualToString:@"1"])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
//                //换头像
                [weakSelf.personalHeader.headerIconImg sd_setImageWithURL:[NSURL URLWithString:self.imgPathStr]];
                weakSelf.personalHeader.headerIconImg.image = self.headimg;
                weakSelf.personalHeader.headerIconImg.layer.cornerRadius = 40;
                weakSelf.personalHeader.headerIconImg.layer.masksToBounds = YES;
                [weakSelf.myCustomTableView reloadData];
            });
           
            
        } else {
    
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
        
        [UIView animateWithDuration:1 animations:^{
            promptLabel.alpha = 0;
        } completion:nil];
        
    }];
    
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
