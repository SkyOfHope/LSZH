//
//  LSRegistFinanceOrgnizationCell.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/26.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSRegistFinanceOrgnizationCell.h"

#import "LSRegistDataModel.h"

#import "HRRegular.h"


@interface LSRegistFinanceOrgnizationCell()<UITextViewDelegate,UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *name;


@property (copy, nonatomic) NSString *documentType;


@property (strong, nonatomic) IBOutlet UITextField *documentCode;
@property (strong, nonatomic) IBOutlet UITextField *contactName;
@property (strong, nonatomic) IBOutlet UITextField *province;
@property (strong, nonatomic) IBOutlet UITextField *city;
@property (strong, nonatomic) IBOutlet UITextField *area;
@property (strong, nonatomic) IBOutlet UITextField *detailAddress;
@property (strong, nonatomic) IBOutlet UITextField *email;


@property (weak, nonatomic) IBOutlet UITextView *About;

@property (weak, nonatomic) IBOutlet UILabel *placeHolder;


@property (weak, nonatomic) IBOutlet UILabel *wordCount;

@property (strong, nonatomic) UIButton *selectedBtn;



//得到组织类型并 存储
- (IBAction)documentType:(UIButton *)sender;

//抓取图片按钮

@property (weak, nonatomic) IBOutlet UIButton *ImagePickerBtn;

@end

@implementation LSRegistFinanceOrgnizationCell

- (void)awakeFromNib {
    // Initialization code
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
//    
//    [self.province addGestureRecognizer:tap];
//    [self.city addGestureRecognizer:tap];
//    [self.area addGestureRecognizer:tap];
    
    self.About.layer.borderColor = RGB(220, 220, 220).CGColor;
    self.About.layer.borderWidth = 1;
    self.About.delegate = self;
    
    [self.ImagePickerBtn addTarget:self action:@selector(PickerImage:) forControlEvents:UIControlEventTouchUpInside];
    

}

//图片按钮方法
-(void)PickerImage:(UIButton*)sender{
    
    if ([self.delegate respondsToSelector:@selector(pickeImageMethod)]) {
        [self.delegate pickeImageMethod];
    }
}

-(void)setImageUpdate:(UIImage *)imageUpdate{

        _imageUpdate = imageUpdate;
        
        //设置抓图按钮背景
        [self.ImagePickerBtn setImage:nil forState:UIControlStateNormal];
        [self.ImagePickerBtn setBackgroundImage:_imageUpdate forState:UIControlStateNormal];
}

//企业简介输入框相关设置

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    NSString *word = textView.text;
    
    if (word == nil) {
        [self.placeHolder setHidden:NO];
    }else{
        [self.placeHolder setHidden:YES];
    }
    
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    NSInteger word = textView.text.length;
    
    if (word == 0) {
        [self.placeHolder setHidden:NO];
    }else{
        [self.placeHolder setHidden:YES];
    }
    
}

-(void)textViewDidChangeSelection:(UITextView *)textView{
    
    NSInteger wordNumber = 500 - textView.text.length;
    
    self.wordCount.text = [NSString stringWithFormat:@"还可以输入%zd/500字",wordNumber];
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    NSString *string = textView.text;
    if ([string length] > 500)
        
    {
        
        string = [string substringToIndex:500];
        
        self.About.text = string;
    }
    
}

//-(void)textViewDidChange:(UITextView *)textView{
//    
//    NSInteger wordNumber = 500 - textView.text.length;
//    
//    self.wordCount.text = [NSString stringWithFormat:@"还可以输入%zd/500字",wordNumber];
//
//}

//控制输入字符数量
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    
//    if (range.location >= 500) {
//        return NO;
//    }else{
//        return YES;
//    }
//}







-(void)setProvinceArray:(NSArray *)ProvinceArray{
    
    _ProvinceArray = ProvinceArray;
    if (ProvinceArray.count > 0) {
        self.province.text = ProvinceArray[0];
        self.city.text = ProvinceArray[1];
//        self.area.text = ProvinceArray[2];
        NSString *str = [ProvinceArray[2] substringWithRange:NSMakeRange(0, [ProvinceArray[2] length] - 1)];
        self.area.text = str;
        
        
    }else{
        NSLog(@"数组没有数据");
    }

}

- (IBAction)adressChoiceBtnAction:(UIButton *)sender {
    
    NSLog(@"1234567");
    
    [self endEditing:YES];
    
    [self.delegate showProvincePickerView];

}


- (IBAction)completeBtnAction:(UIButton *)sender {



//    获取状态
    
    /*
     self.name.text.length > 0 && self.documentCode.text.length > 0 && self.contactName.text.length > 0 && self.province.text.length > 0 && self.city.text.length > 0 && self.area.text.length > 0 && self.detailAddress.text.length > 0 && self.email.text.length > 0 && self.About.text.length > 0 && self.documentType.length > 0
     */
    
    //&& self.city.text.length > 0 && self.area.text.length > 0 省市区只判断省是否有数据
    
    if (self.name.text.length > 0) {
        if (self.documentCode.text.length > 0) {
            if (self.contactName.text.length > 0) {
                if (self.province.text.length > 0 ) {
                    if (self.detailAddress.text.length > 0) {
                        if (self.email.text.length > 0) {
                            if (self.About.text.length > 0) {
                                if (self.documentType.length > 0) {
                                    if (self.imageUpdate) {
                                        
                                        //        //获取所有参数
                                        NSDictionary *para = [NSDictionary dictionaryWithDictionary:[self PostPara]];
                                        
                                        //发送
                                        
                                        [[HRRequestManager manager]POST_PATH:PATH_Register para:para success:^(id responseObject) {
                                            
                                            NSLog(@"%@",responseObject);
                                            
                                            NSDictionary *totalDict = responseObject;
                                            
                                            NSString *success = totalDict[@"success"];
                                            
                                            if ([success isEqualToString:@"1"]) {
                                                
                                                [self.viewController promptBox_YTC_GeneralWithWords:responseObject[@"errMsg"]];
                                                
                                                [self.delegate ifSuccessPrompt:@"信息提交成功，请等待管理员审核"];
                                                
                                            }else{
                                                [self.delegate ifSuccessPrompt:@"注册失败"];
                                            }
                                        } failure:^(NSError *error) {
                                            [self.delegate ifSuccessPrompt:@"网络连接不佳"];
                                        }];
                                    }else{
                                        [self.delegate ifSuccessPrompt:@"请上传营业执照图片"];
                                    }
                                    
                                }else{
                                    [self.delegate ifSuccessPrompt:@"请选择证件类型"];
                                }
                            }else{
                                [self.delegate ifSuccessPrompt:@"请输入企业简介"];
                            }
                        }else{
                            [self.delegate ifSuccessPrompt:@"请输入正确的邮箱"];
                        }
                    }else{
                        [self.delegate ifSuccessPrompt:@"请输入详细地址"];
                    }
                }else{
                    [self.delegate ifSuccessPrompt:@"请输入注册地址"];
                }
            }else{
                [self.delegate ifSuccessPrompt:@"请输入联系人名称"];
            }
        }else{
            [self.delegate ifSuccessPrompt:@"请输入证件号码"];
        }
    }else{
        [self.delegate ifSuccessPrompt:@"请输入名称"];
    }
    
}


-(NSMutableDictionary*)PostPara{
    
    //有图片数据 共 11 个 现11个
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    [para setObject:self.name.text forKey:@"organizationName"];
    [para setObject:self.documentCode.text forKey:@"licenseCode"];
    [para setObject:self.contactName.text forKey:@"principalName"];
    [para setObject:self.province.text forKey:@"province"];
    [para setObject:self.city.text forKey:@"city"];
    [para setObject:self.area.text forKey:@"county"];
    [para setObject:self.detailAddress.text forKey:@"address"];
    [para setObject:self.email.text forKey:@"email"];
    [para setObject:self.About.text forKey:@"remark"];
    [para setObject:self.documentType forKey:@"licenseName"];
    
    //获取背景图片
//    NSData *imgData = UIImageJPEGRepresentation(self.imageUpdate, 0.5);
    [para setObject:self.imgPathStr forKey:@"licenseImg"];
    
    //之前页面的值 共三个

    NSString *filepath = [LSRegistDataModel filePathForRegist];
    
    LSRegistDataModel *modal = [NSKeyedUnarchiver unarchiveObjectWithFile:filepath];
    
    [para setObject:modal.mobile forKey:@"mobile"];
    [para setObject:modal.password forKey:@"password"];
    [para setObject:modal.userTypeId forKey:@"userTypeId"];
    
    
    //测试
//    [para setObject:@"fuben" forKey:@"licenseImg"];
    
    
    return para;
    
}


- (IBAction)documentType:(UIButton *)sender {
    


    [self.selectedBtn setImage:[UIImage imageNamed:@"灰色--未选中"] forState:UIControlStateNormal];
    
    self.selectedBtn = sender;
    
    [self.selectedBtn setImage:[UIImage imageNamed:@"灰色-选中"] forState:UIControlStateNormal];
    
    self.documentType = sender.titleLabel.text;
    
}


//上传图片
//-(void)uploadImageMethod{
//    
//    NSData *data;
//    
//    if (UIImagePNGRepresentation(self.imageUpdate) == nil) {
//        data = UIImageJPEGRepresentation(self.imageUpdate, 0.5);
//    }
//    else {
//        data = UIImageJPEGRepresentation(self.imageUpdate, 0.5);
//    }
//    NSString *str = [NSString stringWithFormat:@"http://www.wcsyq.gov.cn/API/UploadImg.ashx"];
//    
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    
//    [parameters setObject:data forKey:@"imgPath"]; // 二进制传输文件
//    
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:str parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//        formatter.dateFormat = @"yyyyMMddHHmmss";
//        NSString *str = [formatter stringFromDate:[NSDate date]];
//        NSString *fileName = [NSString stringWithFormat:@"%@.png",str];
//        [formData appendPartWithFileData:data name:@"imgPath" fileName:fileName mimeType:@"image/png"];
//    } error:nil];
//    
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
//        // This is not called back on the main queue.
//        // You are responsible for dispatching to the main queue for UI updates
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //Update the progress view 上传进度
//            //            [progressView setProgress:uploadProgress.fractionCompleted];
//        });
//        
//    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        
//        if (error) {
//            NSLog(@"error%@",error);
//        }
//        else {
//            id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            NSLog(@"result%@",result);
//            
//            if ([result isKindOfClass:[NSDictionary class]]) {
//                NSDictionary *resultDic = (NSDictionary *)result;
//                NSDictionary *dsDic = resultDic[@"ds"];
//                self.imgPathStr = dsDic[@"imgPath"];
//            }
//            NSLog(@"imgPathStr=======%@",self.imgPathStr);
//            
//        }
//    }];
//    
//    [uploadTask resume];
//
//}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
