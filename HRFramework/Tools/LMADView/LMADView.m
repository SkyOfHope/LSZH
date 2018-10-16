
/**
 *  @param name   轮播图
 *  @param author muyingbo
 *  @param date   2016-03－28
 */


#import "LMADView.h"

#import "LSCustomLabel.h"

typedef NS_ENUM(NSInteger, Direction) {
    DirectionLeft  = -1,
    DirectionRight = 1,
};


@interface LMADView ()<UIScrollViewDelegate>



/**
 *  图片点击回调
 */
@property (nonatomic, copy) ImageViewTapBlockType imageViewTapBlock;

/**
 *  图片变成n＋2
 */
@property (nonatomic, strong) NSMutableArray<UIImage *> *images;
/**
 *  滚动视图
 */
@property (nonatomic, strong) UIScrollView *scrollView;
/**
 *  计时器
 */
@property (nonatomic, strong) NSTimer *timer;
/**
 *  轮播时间
 */
@property (nonatomic, assign) NSTimeInterval time;
/**
 *  轮播方向
 */
@property (nonatomic, assign) Direction direction;
/**
 *  上一次轮播图的偏移量（辅助设置方向）
 */
@property (nonatomic, assign) CGFloat oldOffsetX;
/**
 *  是否允许图片点击
 */
@property (nonatomic, assign) BOOL allowTapImageView;
/**
 *  是否是长按状态
 */
@property (nonatomic, assign) BOOL isLongPressStauts;

@end

@implementation LMADView

#pragma mark - ||================== 懒加载 ==================||
- (NSMutableArray *)images {
    if (!_images) {
        _images = [[NSMutableArray alloc] init];
    }
    return _images;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-30, SCREEN_WIDTH, 30)];
//        _pageControl.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height - _pageControl.frame.size.height / 2);
//        _pageControl.center = CGPointMake(self.frame.size.width - 30, self.frame.size.height - _pageControl.frame.size.height / 2 );
        _pageControl.hidesForSinglePage = YES;
        
        _pageControl.currentPageIndicatorTintColor = RGB(50, 150, 237);
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPage = 0;
        
    }
    return _pageControl;
}
#pragma mark - ||================== 生命周期 =================||

- (void)dealloc {
    [self.timer invalidate];
}

#pragma mark - ||================== 公有方法 =================||
// 本地图片初始化
- (instancetype)initWithFrame:(CGRect)frame withImageNames: (NSArray <NSString *>*)names withtitles:(NSArray<NSString *> *)titles {
    if (self = [super initWithFrame:frame]) {
        [self initializeData];
        if (names) {
            [self handleImageNames:names];
            if (self.images.count > 0) {
                [self configScrollView];
                [self addImageViews:titles];
                [self addPageControl];
            }
        }
    }
    return self;
}
// 网络图片初始化
- (instancetype)initWithFrame:(CGRect)frame withURLStrings:(NSArray<NSString *> *)urls withTitles:(NSArray<NSString *> *)titles {
    if (self = [super initWithFrame:frame]) {
        [self initializeData];
        
        if (urls) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [self handleUrls:urls];
                if (self.images.count > 0) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self configScrollView];
                        [self addImageViews:titles];
                        [self addPageControl];
                    });
                }
            });
        }
        
    }
    return self;
}

// 开启计时器
- (void)openTimerWithAnimationDuration:(NSTimeInterval)animationDuration {
    
    self.time = animationDuration;
    
    [self initTimer];
    
}

// 调用此方法开启点击回调
- (void)imageViewTap:(ImageViewTapBlockType)block {
    self.allowTapImageView = YES;
    self.imageViewTapBlock = block;
}

#pragma mark - ||================== 私有方法 =================||
// 初始化数据
- (void)initializeData{
    // 初始化方向为又方向
    self.direction = DirectionRight;
    // 翻页动画时间
    self.time = 0.0f;
    // 是否开启图片点击事件
    self.allowTapImageView = NO;
    // 是否是长按状态
    self.isLongPressStauts = NO;
}

// string 转化成 image
-(void)handleImageNames:(NSArray <NSString *>*)imageNames {
    
    for (int i = 0; i < imageNames.count; i++) {
        UIImage *img = [UIImage imageNamed:imageNames[i]];
        // 非空添加
        if (img) {
            [self.images addObject:img];
        }
    }
    [self handleImages];
}

// url 转化成image
- (void)handleUrls:(NSArray <NSString *>*)urls {
    
    for (int i = 0; i < urls.count; i++) {
        NSURL *url = [NSURL URLWithString:urls[i]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:data];
        if (img) {
            [self.images addObject:img];
        }
    }
    [self handleImages];
}

// 前后增加两张图片（如果只有一张的话就没必要了）
- (void)handleImages {
    if (self.images.count > 1) {
        [self.images insertObject:[self.images lastObject] atIndex:0];
        [self.images insertObject:self.images[1] atIndex:self.images.count];
    }
    // retult 1,3,4,....
}


// ScrollView 没什么说的
- (void)configScrollView{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width , self.frame.size.height)];
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * self.images.count, self.frame.size.height);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    // 默认显示第一张（index=1， 不是0）
    self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    [self addSubview:self.scrollView];
}

// ScrollView上 添加 imageView
- (void)addImageViews:(NSArray<NSString *> *)titles{
    for (int i = 0; i < self.images.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.images[i]];
        imageView.frame = CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height);
        
        LSCustomLabel *titlelab = [[LSCustomLabel alloc]init];
        titlelab.frame = CGRectMake(0, imageView.height-30, imageView.width, 30);
        titlelab.textColor = [UIColor whiteColor];
        titlelab.font = [UIFont systemFontOfSize:12];
        
//        titlelab.backgroundColor = [UIColor lightGrayColor];
        titlelab.backgroundColor = RGBA(0, 0, 0, .5);

        [imageView addSubview:titlelab];
        
        if (i == 0) {
            titlelab.text = [titles lastObject];
//            titlelab.text = [NSString stringWithFormat:@"  %@",[titles lastObject]];
            
        }else if (i == self.images.count - 1){
            titlelab.text = [titles firstObject];
        } else {
            titlelab.text = [titles objectAtIndex:i - 1];
        }
        [self.scrollView addSubview:imageView];
        
        if (i == 0) {
            // 第一张和倒数第二张一样
            imageView.tag = self.images.count - 1;
            
        }else if (i == self.images.count - 1) {
            // 倒数第一张和第二张一样
            imageView.tag = 0;
        }else {
            imageView.tag = i - 1;
        }
        
        imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapEvent:)];
        [imageView addGestureRecognizer:tap];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewLongPress:)];
        [imageView addGestureRecognizer:longPress];
        
        // 建立以来关系
        [longPress requireGestureRecognizerToFail:tap];
        
    }
}

// 图片点击事件
- (void)imageViewTapEvent:(UIGestureRecognizer *)recognizer {
    if (self.allowTapImageView) {
        self.imageViewTapBlock(recognizer.view.tag);
    }
}


// 长按手势调用两次这个方法
- (void)imageViewLongPress:(UIGestureRecognizer *)recognizer {
    
    if (!self.isLongPressStauts) {
        [self pauseTimer];
    }else {
        [self startTimer];
    }
    self.isLongPressStauts = !self.isLongPressStauts;
}


// 添加pageControl
- (void)addPageControl {
    if (self.images.count > 1) {
        
        self.pageControl.frame = CGRectMake(self.size.width - self.images.count*15, self.frame.size.height-30, self.images.count*15, 30);
        self.pageControl.numberOfPages = self.images.count - 2;
        [self addSubview:self.pageControl];
    }
}

// 重置 currentPage
- (void)resetPageCurrentControl {
    
    if (self.images.count > 1) {
        int page = self.scrollView.contentOffset.x / self.frame.size.width;
        
        if (page == 0) {
            self.pageControl.currentPage = self.images.count - 2 - 1;
        } else if (page == self.images.count - 1) {
            self.pageControl.currentPage = 0;
        } else {
            self.pageControl.currentPage = page - 1;
        }
        
    }
}

#pragma mark 计时器
// 初始化计时器
- (void)initTimer {
    // 时间小于0表示未开启计时器
    if (self.time > 0){
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(updatePage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        // 开启计时器
        [self startTimer];
        
    }
}
// 开启计时器
- (void)startTimer {
    if (self.timer) {
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.time]];
    }
}
// 暂停计时器
- (void)pauseTimer {
    if (self.timer) {
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}

// 更新当前pageControl
- (void)updatePage {
    CGPoint currentOffset = self.scrollView.contentOffset;
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.contentOffset = CGPointMake(currentOffset.x + self.scrollView.frame.size.width * self.direction, currentOffset.y);
        
    } completion:^(BOOL finished) {
        if (self.scrollView.contentOffset.x == (self.images.count - 1) * self.frame.size.width) {
            self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
        }
        if (self.scrollView.contentOffset.x == 0) {
            self.scrollView.contentOffset = CGPointMake((self.images.count -2) * self.frame.size.width, 0);
        }
        // 重置CurrentControl
        [self resetPageCurrentControl];
        
    }];
}

#pragma mark - ||================== 代理方法 =================||

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self pauseTimer];
    
    self.oldOffsetX = self.scrollView.contentOffset.x;
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    // 改变方向
    if (self.scrollView.contentOffset.x > self.oldOffsetX) {
        self.direction = DirectionRight;
    }else {
        self.direction = DirectionLeft;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 重置CurrentControl
    [self resetPageCurrentControl];
    
    int currentPage = scrollView.contentOffset.x / self.frame.size.width;
    if (currentPage == self.images.count - 1) {
        scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    } else if (currentPage == 0) {
        scrollView.contentOffset = CGPointMake((self.images.count -2) * self.frame.size.width, 0);
    }
    // 恢复计时器
    [self startTimer];
}





@end
