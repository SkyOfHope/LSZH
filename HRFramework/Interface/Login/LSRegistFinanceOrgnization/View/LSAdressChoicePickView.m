//
//  LSAdressChoicePickView.m
//  LSZH
//
//  Created by risenb-ios5 on 16/6/16.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSAdressChoicePickView.h"


@interface LSAdressChoicePickView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHegithCons;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;

//省 数组
@property (strong, nonatomic) NSArray *provinceArr;
//城市 数组
@property (strong, nonatomic) NSArray *cityArr;
//区县 数组
@property (strong, nonatomic) NSArray *areaArr;
@property (strong, nonatomic) AreaObject *locate;

@end



@implementation LSAdressChoicePickView


-(instancetype)init{
    
    if (self = [super init]) {
        
        self = [[NSBundle mainBundle] loadNibNamed:@"LSAdressChoicePickView" owner:nil options:nil].firstObject;
        self.frame = [UIScreen mainScreen].bounds;
        self.pickView.delegate = self;
        self.pickView.dataSource = self;
        
        self.provinceArr = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AreaPlist.plist" ofType:nil]];
        self.cityArr = self.provinceArr[0][@"cities"];
        self.areaArr = self.cityArr[0][@"areas"];
        
        if (self.areaArr.count) {
            self.locate.area = self.areaArr[0];
        }else{
            self.locate.area = @"";
        }

        [self pickerView:self.pickView didSelectRow:0 inComponent:0];

        [self customView];
        
    }
    
    return self;
}

- (void)customView{
    self.contentViewHegithCons.constant = 265;
    [self layoutIfNeeded];
}

#pragma mark - setter && getter

- (AreaObject *)locate{
    if (!_locate) {
        _locate = [[AreaObject alloc]init];
    }
    return _locate;
}



- (IBAction)cancelBtnAction:(UIButton *)sender {
    [self hide];
    
    
}


- (IBAction)sureBtnAction:(UIButton *)sender {
    
    if (self.block) {
        self.block(self,sender,self.locate);
    }
    [self hide];
    
    
}

#pragma  mark - function

- (void)show{
    UIWindow *win = [[UIApplication sharedApplication] keyWindow];
    UIView *topView = [win.subviews firstObject];
    [topView addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.contentViewHegithCons.constant = 265;
        [self layoutIfNeeded];
    }];
}

- (void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.contentViewHegithCons.constant = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return self.provinceArr.count;
            break;
        case 1:
            return self.cityArr.count;
            break;
        case 2:
            if (self.areaArr.count) {
                return self.areaArr.count;
                break;
            }
        default:
            return 0;
            break;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return [[self.provinceArr objectAtIndex:row] objectForKey:@"province"];
            break;
        case 1:
            return [[self.cityArr objectAtIndex:row] objectForKey:@"city"];
            break;
        case 2:
            if (self.areaArr.count) {
                return [self.areaArr objectAtIndex:row];
                break;
            }
        default:
            return  @"";
            break;
    }
}
#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

#pragma mark - UIPickerViewDelegate




- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 8.0;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component) {
        case 0:
        {
            self.cityArr = [[self.provinceArr objectAtIndex:row] objectForKey:@"cities"];
            [self.pickView reloadComponent:1];
            [self.pickView selectRow:0 inComponent:1 animated:YES];
            
            
            self.areaArr = [[self.cityArr objectAtIndex:0] objectForKey:@"areas"];
            [self.pickView reloadComponent:1];
            [self.pickView selectRow:0 inComponent:1 animated:YES];
            
            self.locate.province = self.provinceArr[row][@"province"];
            self.locate.city = self.cityArr[0][@"city"];
            if (self.areaArr.count) {
                self.locate.area = self.areaArr[0];
            }else{
                self.locate.area = @"";
            }
            
            break;
        }
        case 1:{
            self.areaArr = [[self.cityArr objectAtIndex:row] objectForKey:@"areas"];
            [self.pickView reloadComponent:2];
            [self.pickView selectRow:0 inComponent:2 animated:YES];
            
            self.locate.city = self.cityArr[row][@"city"];
            if (self.areaArr.count) {
                self.locate.area = self.areaArr[0];
            }else{
                self.locate.area = @"";
            }
            
            break;
        }
        case 2:{
            if (self.areaArr.count) {
                self.locate.area = self.areaArr[row];
                NSLog(@"#$#$#$#$#$#$#$#$#$#$%@",self.areaArr);
            }else{
                self.locate.area = @"";
            }
            
            break;
        }
        default:
            break;
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
