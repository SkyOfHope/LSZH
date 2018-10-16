
//
//  LSPublishRentOutFooterView.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/20.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSPublishRentOutFooterView.h"
#import "UIViewExt.h"


@interface LSPublishRentOutFooterView ()



//整个view的高

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;


//真正容纳图片的View
@property (weak, nonatomic) IBOutlet UIView *trueImgView;


//需要下移的两个控件
@property (weak, nonatomic) IBOutlet UIButton *protocolBtn;

@property (assign, nonatomic) BOOL isGibber;

@end

@implementation LSPublishRentOutFooterView



- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LSPublishRentOutFooterViewreceiveImages" object:nil];
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveImages:) name:@"LSPublishRentOutFooterViewreceiveImages" object:nil];
    
}

- (void)hideKeyBoard {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}


- (void)receiveImages:(NSNotification *)notifycation
{
    id result = notifycation.object;
    NSLog(@"object = %@", result);
    //用来保存
//    CGRect firstFrame = NULL;
    //先移除之前的所有控件
    for (UIView *smallView in self.trueImgView.subviews) {
        
        [smallView removeFromSuperview];
        
    }

    //获取imageView的宽进行计算之后的控件大小
    
    CGFloat widhtView = (self.trueImgView.frame.size.width - 35 )/4;

    //在九宫格布局
    
    if ([result isKindOfClass:[NSArray class]]) {
        
        NSArray *selectImgArr = (NSArray *)result;
        
        if (selectImgArr.count == 0) {
            
            UIButton *lastBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 5  , 55, 55)];
            [self.trueImgView addSubview:lastBtn];
            [lastBtn setBackgroundImage:[UIImage imageNamed:@"上传照片"] forState:UIControlStateNormal];
            //添加方法
            [lastBtn addTarget:self action:@selector(addImgAction) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        //九宫格布局
        
        for (int i = 0; i < selectImgArr.count; i ++) {
            
            NSInteger row = i / 4;
            NSInteger col = i % 4;
            
            
            UIImageView *showImgV = [[UIImageView alloc]initWithImage:selectImgArr[i]];
            [self.trueImgView addSubview:showImgV];
            showImgV.frame = CGRectMake(5+((widhtView + 5)*col), 7 + (widhtView + 7) * row , widhtView, widhtView);
            showImgV.image = selectImgArr[i];

            //添加删除按钮
            
            CGFloat widthForShanchu = 12;
            UIButton *shanchuB = [[UIButton alloc]initWithFrame:CGRectMake(5+((widhtView + 5)*col) + ( widhtView - widthForShanchu ), 7 + (widhtView + 7) * row , widthForShanchu, widthForShanchu)];
            
            shanchuB.tag = i;
            [self.trueImgView addSubview:shanchuB];
            shanchuB.backgroundColor = [UIColor redColor];
            [shanchuB setBackgroundImage:[UIImage imageNamed:@"删除照片"] forState:UIControlStateNormal];
            [shanchuB addTarget:self action:@selector(shanchutupian:) forControlEvents:UIControlEventTouchUpInside];
            
            
            //添加多一个按钮
            if (i == selectImgArr.count - 1 && selectImgArr.count != 5) {
                
                if (i == 3) {
                    
                    UIButton *lastBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 7 + 7 +widhtView * 1 , widhtView, widhtView)];
                    [self.trueImgView addSubview:lastBtn];
                    [lastBtn setBackgroundImage:[UIImage imageNamed:@"上传照片"] forState:UIControlStateNormal];
                    //添加方法
                    [lastBtn addTarget:self action:@selector(addImgAction) forControlEvents:UIControlEventTouchUpInside];
                    
                }else{
                    
                    UIButton *lastBtn = [[UIButton alloc]initWithFrame:CGRectMake(5+((widhtView + 5)* (col + 1)), 7 + (widhtView + 7) * row , widhtView, widhtView)];
                    [self.trueImgView addSubview:lastBtn];
                    [lastBtn setBackgroundImage:[UIImage imageNamed:@"上传照片"] forState:UIControlStateNormal];
                    //添加方法
                    [lastBtn addTarget:self action:@selector(addImgAction) forControlEvents:UIControlEventTouchUpInside];
                    
                }

            }

        }
        
        self.addImgBtn.hidden = YES;
   
    }
}

-(void)shanchutupian:(UIButton*)sender{
    
    NSLog(@"%zd",sender.tag);
    
    [self.delegate shanchutupianChuzu:sender.tag];
    
}


- (IBAction)protocolBtnAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
}

-(void)addImgAction{
    
    if (_delegate && [_delegate respondsToSelector:@selector(addImg)]) {
        [_delegate addImg];
    }
    
}

- (IBAction)addImgBtnAction:(id)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(addImg)]) {
        [_delegate addImg];
    }
    
}

- (IBAction)totalcompeleteaction:(id)sender {
    
//    LStotalCompeleteModel *model = [LStotalCompeleteModel shareInstance];
    
    
    if (self.protocolBtn.selected) {
        if (_delegate && [_delegate respondsToSelector:@selector(totalcompelete)]) {
            [_delegate totalcompelete];
        }
        
    }else{
        if ([self.delegate respondsToSelector:@selector(promptForCell:)]) {
            [self.delegate promptForCell:@"请勾选 保证上述信息真实有效"];
        }
        
    }
    
}


@end
