
#import "HRADView.h"

typedef void(^ImageViewTapBlockType)(NSInteger imageViewTag);

typedef NS_ENUM(NSInteger, Direction) {
    DirectionLeft  = -1,
    DirectionRight = 1,
};


@interface HRADView ()<UIScrollViewDelegate>

@property (nonatomic, copy) ImageViewTapBlockType imageViewTapBlock;
@property (nonatomic, strong) NSMutableArray<UIImage *> *images;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, assign) Direction direction;
@property (nonatomic, assign) CGFloat oldOffsetX;
@property (nonatomic, assign) BOOL allowTapImageView;
@property (nonatomic, assign) BOOL isLongPressStauts;


@property (nonatomic, strong) NSMutableArray<NSString *> *titles;
@end

@implementation HRADView

#pragma mark - ||================= Lazy loading ===============||
- (NSMutableArray *)images {
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (NSMutableArray *)titles {
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        _pageControl.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height - _pageControl.frame.size.height / 2);
        _pageControl.hidesForSinglePage = YES;
        _pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPage = 0;
        
    }
    return _pageControl;
}
#pragma mark - ||================== Lifecycle =================||

- (void)dealloc {
    [self.timer invalidate];
}

#pragma mark - ||================= Public Method =============||
- (instancetype)initWithFrame:(CGRect)frame imageNames:(NSArray <NSString *>*)names{
    if (self = [super initWithFrame:frame]) {
        [self initializeData];
        if (names) {
            [self handleImageNames:names];
            if (self.images.count == 1) {
                [self configImageView];
            }
            if (self.images.count > 1) {
                [self configScrollView];
                [self configImageViews];
                [self addPageControl];
                if (self.time > 0.001) {
                    [self continueTimer];
                }
            }
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame URLStrings:(NSArray<NSString *> *)urls{
    if (self = [super initWithFrame:frame]) {
        [self initializeData];
        
        if (urls) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [self handleUrls:urls];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (self.images.count == 1) {
                        [self configImageView];
                    }
                    if (self.images.count > 1) {
                        [self configScrollView];
                        [self configImageViews];
                        [self addPageControl];
                        if (self.time > 0.001) {
                            [self continueTimer];
                        }
                    }
                });
            });
        }
    }
    return self;
}

- (void)openTimerWithAnimationDuration:(NSTimeInterval)animationDuration {
    self.time = animationDuration;
    [self initTimer];
}

- (void)imageViewTap:(ImageViewTapBlockType)block {
    self.allowTapImageView = YES;
    self.imageViewTapBlock = block;
}

#pragma mark - ||================ Private Method =============||
#pragma mark >>> initializeData
- (void)initializeData{
    self.direction = DirectionRight;
    self.time = 0.0f;
    self.allowTapImageView = NO;
    self.isLongPressStauts = NO;
}

#pragma mark >>> configUI
-(void)handleImageNames:(NSArray <NSString *>*)imageNames {
    
    for (int i = 0; i < imageNames.count; i++) {
        UIImage *img = [UIImage imageNamed:imageNames[i]];
        if (img) {
            [self.images addObject:img];
        }
    }
    [self handleImages];
}

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

- (void)handleImages {
    if (self.images.count > 1) {
        [self.images insertObject:[self.images lastObject] atIndex:0];
        [self.images insertObject:self.images[1] atIndex:self.images.count];
    }
}

- (void)configImageView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.image = [self.images firstObject];
    imageView.tag = 0;
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapEvent:)];
    [imageView addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewLongPress:)];
    [imageView addGestureRecognizer:longPress];
    
    [longPress requireGestureRecognizerToFail:tap];
    
}

- (void)configScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * self.images.count, self.frame.size.height);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    [self addSubview:self.scrollView];
}

- (void)configImageViews {
    for (int i = 0; i < self.images.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.images[i]];
        imageView.frame = CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height);
        [self.scrollView addSubview:imageView];
        
        if (i == 0) {
            imageView.tag = self.images.count - 1;
        }else if (i == self.images.count - 1) {
            imageView.tag = 0;
        }else {
            imageView.tag = i - 1;
        }
        
        imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapEvent:)];
        [imageView addGestureRecognizer:tap];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewLongPress:)];
        [imageView addGestureRecognizer:longPress];
        
        [longPress requireGestureRecognizerToFail:tap];
    }
}

- (void)imageViewTapEvent:(UIGestureRecognizer *)recognizer {
    if (self.allowTapImageView) {
        self.imageViewTapBlock(recognizer.view.tag);
    }
}

- (void)imageViewLongPress:(UIGestureRecognizer *)recognizer {
    
    if (!self.isLongPressStauts) {
        [self pauseTimer];
    }else {
        [self continueTimer];
    }
    self.isLongPressStauts = !self.isLongPressStauts;
}

- (void)addPageControl {
    if (self.images.count > 1) {
        self.pageControl.numberOfPages = self.images.count - 2;
        [self addSubview:self.pageControl];
    }
}

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

#pragma mark setup timer
- (void)initTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(updatePage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)continueTimer {
    if (self.timer) {
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.time]];
    }
}

- (void)pauseTimer {
    if (self.timer) {
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)updatePage {
    if (self.scrollView == nil) {
        [self pauseTimer];
        return;
    }
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

        [self resetPageCurrentControl];
        
    }];
}

#pragma mark - ||================ Protocol Methods ============||

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self pauseTimer];
    
    self.oldOffsetX = self.scrollView.contentOffset.x;
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    if (self.scrollView.contentOffset.x > self.oldOffsetX) {
        self.direction = DirectionRight;
    }else {
        self.direction = DirectionLeft;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self resetPageCurrentControl];
    
    int currentPage = scrollView.contentOffset.x / self.frame.size.width;
    if (currentPage == self.images.count - 1) {
        scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    } else if (currentPage == 0) {
        scrollView.contentOffset = CGPointMake((self.images.count -2) * self.frame.size.width, 0);
    }
    
    [self continueTimer];
}

@end
