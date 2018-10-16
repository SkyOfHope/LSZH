
//
//  LSLeadViewController.m
//  LSZH
//
//  Created by risenb-ios5 on 16/5/31.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSLeadViewController.h"

@interface LSLeadViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
//
@property (strong, nonatomic) NSMutableArray *DataArr;

@property (strong,nonatomic) UIPageControl *pageCOntrol;
@end

@implementation LSLeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建引导页图片数组
    self.DataArr = [[NSMutableArray alloc]init];
    [self.DataArr addObject:[UIImage imageNamed:@"蓝色智慧引导页0"]];
    [self.DataArr addObject:[UIImage imageNamed:@"蓝色智慧引导页1-1"]];
    
    //创建collection的布局
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    
    flow.itemSize = [UIScreen mainScreen].bounds.size;
    flow.minimumLineSpacing = 0;
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    //创建collectionView
    self.collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flow];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    //注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    
}

//切换控制器

-(void)changeRootVC{
    
    if ([self.delegate respondsToSelector:@selector(LeadControllerChangeRootController)]) {
        [self.delegate LeadControllerChangeRootController];
    }
    
}



//数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.DataArr.count;
    
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    
    //item内部添加图片控件
    UIImageView *imageView = [[UIImageView alloc]initWithImage:self.DataArr[indexPath.row]];
    imageView.frame = [UIScreen mainScreen].bounds;
    
    [cell addSubview:imageView];
    
    if (indexPath.row == 0) {
        //跳过按钮
        
        CGFloat jumpWidth = 50;
        
        UIButton *jumpBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - jumpWidth - 20, 30, jumpWidth, jumpWidth * 0.5)];
        [cell addSubview:jumpBtn];
        
        [jumpBtn setBackgroundImage:[UIImage imageNamed:@"跳过"] forState:UIControlStateNormal];
        
        [jumpBtn addTarget:self action:@selector(changeRootVC) forControlEvents:UIControlEventTouchUpInside];
        
        //引导
//        UILabel *label = [[UILabel alloc]init];
//        label.bounds = CGRectMake(0, 0, cell.width, 50);
//        label.center = CGPointMake(cell.center.x, CGRectGetMaxY(cell.frame) - label.height );
//        label.textAlignment = NSTextAlignmentCenter;
//        [cell addSubview:label];
//        label.textColor = [UIColor whiteColor];
//        label.backgroundColor = [UIColor clearColor];
//        label.text = @"<<< 滑动翻页 >>>";
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        self.pageCOntrol = pageControl;
        pageControl.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50);
        pageControl.center = CGPointMake(cell.center.x, CGRectGetMaxY(cell.frame) - pageControl.height );
        [self.view addSubview:pageControl];
        
        
        pageControl.numberOfPages = 2;//总的图片页数
        pageControl.currentPage = 0; //当前页
        
        [pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];  //用户点击UIPageControl的响应函数
        pageControl.currentPageIndicatorTintColor = RGB(50, 150, 237);
        pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        pageControl.backgroundColor = [UIColor clearColor];
        

    }else if (indexPath.row == 1){
        //立即体验按钮
        
        CGFloat nowWidth = 113;
        
        UIButton *nowBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - nowWidth)/2, SCREEN_HEIGHT * 0.7 , nowWidth, nowWidth * 0.32)];
        [cell addSubview:nowBtn];
        
        [nowBtn setBackgroundImage:[UIImage imageNamed:@"立即体验"] forState:UIControlStateNormal];
        
        [nowBtn addTarget:self action:@selector(changeRootVC) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return cell;
}



- (void)pageTurn:(UIPageControl*)sender
{
    //做出相应的滑动显示
   
    
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    NSLog(@"%@");;
    
    if (self.collectionView.contentOffset.x == [UIScreen mainScreen].bounds.size.width) {
        self.pageCOntrol.currentPage = 1;
    }else{
        self.pageCOntrol.currentPage = 0;
    }
    
}


-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
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

- (IBAction)changeRootViewController:(id)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"yinDaoYe_jieshu" object:nil];
    
    
    
}
@end
