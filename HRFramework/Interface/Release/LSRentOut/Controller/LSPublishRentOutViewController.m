//
//  LSPublishRentOutViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/20.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSPublishRentOutViewController.h"

#import "LSPublishRentOutCell.h"
#define CELL_PublishRentOut  @"PublishRentOutCell"

#import "LSPublishRentOutHeaderView.h"
#import "LSPublishRentOutFooterView.h"

#import "LSListGroupSectionHeaderView.h"

#import "LSBaseInformationViewController.h"
#import "LSBuildInformationViewController.h"
#import "LSSheShiInformationViewController.h"
#import "LSTrafficInfomationViewController.h"
#import "LSRemarkInformationViewController.h"

#import "ZYQAssetPickerController.h"//第三方本地相册上传
#import "LSMyHUD.h"
@interface LSPublishRentOutViewController ()<LSListGroupSectionHeaderViewDelegate, totalcompeleteDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, ZYQAssetPickerControllerDelegate>
{
     LSMyHUD*_window;
    NSString *PicFilePath;
}

@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;

@property (strong, nonatomic) LSPublishRentOutHeaderView *rentOutHeader;
@property (strong, nonatomic) LSPublishRentOutFooterView *rentOutFooter;
@property (strong, nonatomic) UIAlertView *alertV;
@property (nonatomic, strong) NSMutableArray *selectimgArr;
@property (nonatomic, strong) NSMutableArray *imgURLsARR;

@property (assign, nonatomic) BOOL isBigger;

/**
 *  tableView 数据源
 */
@property (strong,nonatomic) NSArray *dataSourceArr;


@end

@implementation LSPublishRentOutViewController

-(void)shanchutupianChuzu:(NSInteger)index{
    
    [self.selectimgArr removeObjectAtIndex:index];
    
    if (self.selectimgArr.count < 4 && self.isBigger == YES) {
        self.isBigger = NO;
        CGRect frame = self.rentOutFooter.frame;
        frame.size.height -= 70;
        self.rentOutFooter.frame = frame;
        self.myCustomTableView.tableFooterView = self.rentOutFooter;
        
    }else if (self.selectimgArr.count > 3 && self.isBigger == NO){
        self.isBigger = YES;
        CGRect frame = self.rentOutFooter.frame;
        frame.size.height += 70;
        self.rentOutFooter.frame = frame;
        self.myCustomTableView.tableFooterView = self.rentOutFooter;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LSPublishRentOutFooterViewreceiveImages" object:_selectimgArr];
    
}


-(LSPublishRentOutHeaderView *)rentOutHeader{
    if (!_rentOutHeader) {
        _rentOutHeader = [[NSBundle mainBundle] loadNibNamed:@"LSPublishRentOutHeaderView" owner:nil options:nil].lastObject;
    }
    
    return _rentOutHeader;
}
//footerView
-(LSPublishRentOutFooterView *)rentOutFooter{
    if (!_rentOutFooter) {

        _rentOutFooter = [[[NSBundle mainBundle]loadNibNamed:@"LSPublishRentOutFooterView" owner:nil options:nil]lastObject];
        
        _rentOutFooter.delegate = self;
    }
    return _rentOutFooter;
}
//footerView的代理方法:负责弹窗显示
-(void)promptForCell:(NSString *)prompt{
    [self promptBox_YTC_GeneralWithWords:prompt];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.dataSourceArr = @[@"基本信息",@"建筑信息",@"设施配套信息",@"交通配套信息",@"备注信息"];
    self.selectimgArr = [NSMutableArray arrayWithCapacity:0];
    self.imgURLsARR = [NSMutableArray arrayWithCapacity:0];
    //注册cell
    [self.myCustomTableView registerNib:[UINib nibWithNibName:@"LSPublishRentOutCell" bundle:nil] forCellReuseIdentifier:CELL_PublishRentOut];
    
    self.myCustomTableView.tableHeaderView = self.rentOutHeader;
    self.myCustomTableView.tableFooterView = self.rentOutFooter;
    
    self.alertV = [[UIAlertView alloc]initWithTitle:@"发布"
                                            message:nil
                                           delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil, nil];
    
    [self configUI];
    self.isBigger = NO;
    
    LStotalCompeleteModel *model = [LStotalCompeleteModel shareInstance];
    //基本信息
    model.louyu = nil;
    model.diliweizhi = nil;
    model.louhao = nil;
    model.louceng = nil;
    model.mianji = nil;
    model.chaoxiang = nil;
    model.zhuangxiu = nil;
    model.qizu = nil;
    model.rizujin = nil;
    model.yuezujin = nil;
    model.mianzuqi = nil;
    model.sheshi = nil;
    model.detailAddress = nil;
    
    //建筑信息
    model.jianzhuleixing = nil;
    model.jianzhumianji = nil;
    model.jingcenggao = nil;
    model.wuyejibie = nil;
    model.ruzhushijian = nil;
    model.kaifashang = nil;
    model.shejidanwei = nil;
    model.shigongdanwei = nil;

    //设施配套
    model.shejidanwei1 = nil;
    model.shigongdanwei1 = nil;
    
    //交通配套
    model.jiaotongpeitao = nil;
    
    //备注
    model.beizhu = nil;
    
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
    
//    return 0;
    return self.dataSourceArr.count;
}




//返回cell高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.myCustomTableView.estimatedRowHeight = self.myCustomTableView.rowHeight;
    self.myCustomTableView.rowHeight = UITableViewAutomaticDimension;
    return self.myCustomTableView.rowHeight;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSPublishRentOutCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_PublishRentOut forIndexPath:indexPath];
    
    cell.leftLabel.text = self.dataSourceArr[indexPath.row];
    
    //cell点击变色
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    //去掉分割线
    self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:{
            
            NSLog(@"基本信息");
            LSBaseInformationViewController *baseInformationVC = [[LSBaseInformationViewController alloc] initWithNibName:@"LSBaseInformationViewController" bundle:nil];
            
            [self.navigationController pushViewController:baseInformationVC animated:YES];
            
            break;
        }
        case 1:{
            
            NSLog(@"建筑信息");
            LSBuildInformationViewController *buildInformationVC = [[LSBuildInformationViewController alloc] initWithNibName:@"LSBuildInformationViewController" bundle:nil];
            
            [self.navigationController pushViewController:buildInformationVC animated:YES];

            
            break;
        }
        case 2:{
            
            NSLog(@"设施配套信息");
            LSSheShiInformationViewController *sheShiInformationVC = [[LSSheShiInformationViewController alloc] initWithNibName:@"LSSheShiInformationViewController" bundle:nil];
            
            [self.navigationController pushViewController:sheShiInformationVC animated:YES];
            
            break;
        }
        case 3:{
            NSLog(@"交通配套信息");
            LSTrafficInfomationViewController *trafficInfomationVC = [[LSTrafficInfomationViewController alloc] initWithNibName:@"LSTrafficInfomationViewController" bundle:nil];
            
            [self.navigationController pushViewController:trafficInfomationVC animated:YES];
            
            break;
        }
        case 4:{
            NSLog(@"备注信息");
            LSRemarkInformationViewController *remarkInformationVC = [[LSRemarkInformationViewController alloc] initWithNibName:@"LSRemarkInformationViewController" bundle:nil];
            
            [self.navigationController pushViewController:remarkInformationVC animated:YES];
            
            break;
        }
            
        default:
            break;
    }
}

- (void)totalcompelete {

    LStotalCompeleteModel *model = [LStotalCompeleteModel shareInstance];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    
    [para setObject:userId forKey:@"userId"];
    
    [para setObject:self.rentOutHeader.titleTF.text forKey:@"title"];
    
    if ([self judgement:model.louyu]) {
        
        
//        [para setObject:model.detailAddress forKey:@"city"];
        
        [para setObject:model.louyu forKey:@"louyu"];
        
        if ([self judgement:model.louhao]) {
         [para setObject:model.louhao forKey:@"louhao"];
            if ([self judgement:model.louceng]) {
             [para setObject:model.louceng forKey:@"louceng"];
                if ([self judgement:model.mianji]) {
                    
                    CGFloat sizeT = [model.mianji floatValue];
                    
                    NSNumber *size = [NSNumber numberWithFloat:sizeT];
                    
                    [para setObject:size forKey:@"size"];
                    if ([self judgement:model.chaoxiang]) {
                     [para setObject:model.chaoxiang forKey:@"chaoxiang"];
                        if ([self judgement:model.zhuangxiu]) {
                         [para setObject:model.zhuangxiu forKey:@"zhuangxiu"];
                            if ([self judgement:model.qizu]) {
                             [para setObject:model.qizu forKey:@"qizuDate"];
                                if ([self judgement:model.rizujin]) {
                                 [para setObject:model.rizujin forKey:@"rizujin"];
                                    if ([self judgement:model.yuezujin]) {
                                     [para setObject:model.yuezujin forKey:@"yuezujin"];
                                        if ([self judgement:model.mianzuqi]) {
                                            
                                         [para setObject:model.mianzuqi forKey:@"mianzuqi"];
                                            
                                            if ([self judgement:model.sheshi]) {
                                                
                                             [para setObject:model.sheshi forKey:@"peitao"];
                                                
                                                if ([self judgement:model.detailAddress]) {
                                                    
                                                 [para setObject:model.detailAddress forKey:@"address"];
                                                    
                                                    if ([self judgement:model.jianzhuleixing]) {
                                                        
                                                     [para setObject:model.jianzhuleixing forKey:@"jianzhuType"];
                                                        
                                                        if ([self judgement:model.jianzhumianji]) {
                                                            
                                                            CGFloat jianzhuT = [model.jianzhumianji floatValue];
                                                            NSNumber *jianzhuMJ = [NSNumber numberWithFloat:jianzhuT];
                                                         [para setObject:jianzhuMJ forKey:@"jianzhuSize"];
                                                            
                                                            if ([self judgement:model.jingcenggao]) {
                                                                
                                                             [para setObject:model.jingcenggao forKey:@"jingcenggao"];
                                                                
                                                                if ([self judgement:model.wuyejibie]) {
                                                                    [para setObject:model.wuyejibie forKey:@"wuyeJibie"];
                                                                    if ([self judgement:model.ruzhushijian]) {
                                                                     [para setObject:model.ruzhushijian forKey:@"ruzhuDate"];
                                                                        if ([self judgement:model.kaifashang]) {
                                                                   [para setObject:model.kaifashang forKey:@"kaifashang"];
                                                                            if ([self judgement:model.shejidanwei]) {
                                                                            [para setObject:model.shejidanwei forKey:@"shejiDanwei"];
                                                                            if ([self judgement:model.shigongdanwei]) {
                                                                                    
                                                               [para setObject:model.shigongdanwei forKey:@"shigongDanwei"];
                                                                                    if ([self judgement:model.diliweizhi]) {
                                                                                        
                                                                 [para setObject:model.diliweizhi forKey:@"city"];
                                                                                        if ([self judgement:model.shigongdanwei1]) {
                                                                  
                                                                                            
                                                                                            [para setObject:model.shigongdanwei1 forKey:@"zhoubianPeitao"];
                                                                                            
                                                                                            
                                                                                            if ([self judgement:model.shejidanwei1]) {
                                                                                                
                                                                [para setObject:model.shejidanwei1 forKey:@"louneiPeitao"];
                                                                                                
                                                                                                if ([self judgement:model.beizhu]) {
                                                               [para setObject:model.beizhu forKey:@"remark"];
                                                                                                    if ([self judgement:model.jiaotongpeitao]) {
                                                                                                        [para setObject:model.jiaotongpeitao forKey:@"jiaotongPeitao"];
                                                                                                    }else{
                                                                                                        
                                                                                                    }
                                                                                                
                                                                                                
                                                                                                }else{
                                                                                                    NSLog(@"请先填写备注");
                                                                                                }
                                                                                            }else{
                                                                                                NSLog(@"请先填写设计单位");
                                                                                            }
                                                                                        
                                                                                        }else{
                                                                                            NSLog(@"请先填写施工单位");
                                                                                        }
                                                                                    
                                                                                    }else{
                                                                                        NSLog(@"请先填写地理位置");
                                                                                    }
                                                                                
                                                                                }else{
                                                                                    NSLog(@"请先填写施工单位");
                                                                                }
                                                                            }else{
                                                                                NSLog(@"请先填写设计单位");
                                                                            }
                                                                            
                                                                            
                                                                        }else{
                                                                            NSLog(@"请先填写开发商");
                                                                        }
                                                                        
                                                                        
                                                                    }else{
                                                                        NSLog(@"请先填写入住时间");
                                                                    }
                                                                    
                                                                    
                                                                }else{
                                                                    NSLog(@"请先填写物业级别");
                                                                }
                                                                
                                                            }else{
                                                                NSLog(@"请先填写净层高");
                                                            }
                                                            
                                                        }else{
                                                            NSLog(@"请先填写建筑面积");
                                                        }
                                                        
                                                    }else{
                                                        NSLog(@"请先填写建筑类型");
                                                    }
                                                    
                                                }else{
                                                    NSLog(@"请先填写详细地址");
                                                }
                                                
                                            }else{
                                                NSLog(@"请先填写设施");
                                            }
                                            
                                        }else{
                                            NSLog(@"请先填写免租期");
                                        }
                                        
                                    }else{
                                        NSLog(@"请先填写月租金");
                                    }
                                    
                                }else{
                                    NSLog(@"请先填写");
                                }
                                
                            }else{
                                NSLog(@"请先填写起租日期");
                            }
                            
                        }else{
                            NSLog(@"请先填写装修");
                        }
                        
                    }else{
                        NSLog(@"请先填写朝向");
                    }
                    
                    
                }else{
                    NSLog(@"请先填写面积");
                }
                
            }else{
                NSLog(@"请先填写楼号楼层");
            }
            
        }else{
            NSLog(@"请先填写楼号信息");
        }
        
    }else{
        NSLog(@"请先填写楼宇信息");
    }
    
    if (self.imgURLsARR.count>0) {
        NSString *urlStr = [self.imgURLsARR componentsJoinedByString:@","];
        [para setObject:urlStr forKey:@"imgPaths"];
    }
    
    [[HRRequestManager manager] POST_PATH:AddRentHouse para:para success:^(id responseObject) {
        
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
                [self.alertV setTitle:responseObject[@"errMsg"]];
                [_alertV show];
            }
            
        }
        
    } failure:^(NSError *error) {
        [self.alertV setTitle:@"网络请求失败"];
        [_alertV show];
        
    }];
}

-(BOOL)judgement:(NSString*)modelStr{
    
    if (modelStr.length > 0) {
        return YES;
    }
    
    return NO;
}



- (void)addImg {
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:nil
                                                     delegate:self
                                            cancelButtonTitle:@"取消"
                                       destructiveButtonTitle:nil
                                            otherButtonTitles:@"从手机相册选择",@"拍照",nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;//设置样式
    sheet.tag = 642016;
    [sheet showInView:self.view];

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
    
    //    NSMutableArray *showImages = [NSMutableArray array];
   
//    [self.selectimgArr removeAllObjects];
    
    for (int i=0; i<assets.count; i++) {
        ALAsset *asset = assets[i];
        
        
        UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        
        CGSize imagesize = tempImg.size;
        if (_selectimgArr.count > 4) {
            //            _selectimgArr.count = 8;
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
            
        }
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LSPublishRentOutFooterViewreceiveImages" object:_selectimgArr];

    if (self.selectimgArr.count < 4 && self.isBigger == YES) {
        self.isBigger = NO;
        CGRect frame = self.rentOutFooter.frame;
        frame.size.height -= 100;
        self.rentOutFooter.frame = frame;
        self.myCustomTableView.tableFooterView = self.rentOutFooter;
        
    }else if (self.selectimgArr.count > 3 && self.isBigger == NO){
        self.isBigger = YES;
        CGRect frame = self.rentOutFooter.frame;
        frame.size.height += 100;
        self.rentOutFooter.frame = frame;
        self.myCustomTableView.tableFooterView = self.rentOutFooter;
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
            //            {
            //                ds =     {
            //                    imgPath = "http://www.wcsyq.gov.cn/upload/2016-06/20160604120021661.png";
            //                };
            //                errMsg = "\U4e0a\U4f20\U6210\U529f";
            //                success = 1;
            //            }
            
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
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LSPublishRentOutFooterViewreceiveImages" object:_selectimgArr];
    
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
