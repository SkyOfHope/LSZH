
#import "HRBaseViewController.h"
#import "HRIndicatorWindow.h"


typedef void(^LMBlock)(void);

/**
 *  NavigationClickBlockType
 *
 *  @param buttonTag
 */
typedef void(^NavigationClickBlockType)(NSInteger buttonTag);

@interface HRBaseViewController ()

/**
 *  TitleViewClickBlock
 */
@property (nonatomic, copy)LMBlock navigationTitleViewClickBlock;

/**
 *  LeftBarButtonClickBlock
 */
@property (nonatomic, copy)NavigationClickBlockType navigationLeftBarButtonClickBlock;

/**
 *  RightBarButtonClickBlock
 */
@property (nonatomic, copy)NavigationClickBlockType navigationRightBarButtonClickBlock;

/**
 *  IndicatorWindow
 */
@property (nonatomic, strong)HRIndicatorWindow *indicatorWindow;

@end

@implementation HRBaseViewController

#pragma mark - ---------- Lazy loading ----------
- (HRIndicatorWindow *)indicatorWindow {
    if (_indicatorWindow == nil) {
        _indicatorWindow = [[HRIndicatorWindow alloc] initWithFrame:SCREEN_BOUNDS];
    }
    return _indicatorWindow;
}


#pragma mark - ---------- Lifecycle ----------

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initBaseData];
    [self configBaseUI];
    
}

#pragma mark - ---------- Public Methods ----------

#pragma mark Override Super
/**
 *  setup statusBarStyle
 *
 *  @return UIStatusBarStyle
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark NavigationTitle
/**
 *  NavigationTitle
 *
 *  @param title
 *  @param titleColor
 *  @param size(system)
 */
- (void)navigationTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)size {
    UILabel *titleText = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 150, 44)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=color;
    titleText.textAlignment = NSTextAlignmentCenter;
    [titleText setFont:[UIFont systemFontOfSize:size]];
    [titleText setText:title];
    self.navigationItem.titleView = titleText;
}

/**
 *  NavigationTitleView
 *
 *  @param view  CustomView
 *  @param block tap event block
 */
- (void)navigationTitleView:(UIView *)view click:(void(^)())block {
    view.userInteractionEnabled = YES;
    self.navigationItem.titleView = view;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigationTitleViewTap:)];
    [view addGestureRecognizer:tap];
    self.navigationTitleViewClickBlock = block;
}


#pragma mark NavigationBarButton
/**
 *  LeftBarButtonItems(imageView)
 *
 *  @param imageNames   imageName array
 *  @param block        button click (left->right tag=1,2,3...)
 */
- (void)navigationLeftBarButtonImageNames:(NSArray <NSString *> *)imageNames click:(void(^)(NSInteger buttonTag))block {
    NSArray *barButtonItems = [self handleBarButtonImageNames:imageNames isLeft:YES];
    if (!barButtonItems.count) {
        return;
    }
    if (barButtonItems.count == 1)
    {
        self.navigationItem.leftBarButtonItem = [barButtonItems lastObject];
    } else {
        self.navigationItem.leftBarButtonItems = barButtonItems;
    }
    self.navigationLeftBarButtonClickBlock = block;
}



/**
 *  LeftBarButtonItems(title)
 *
 *  @param titles  title
 *  @param block   button click (left->right tag=1,2,3...)
 */
- (void)navigationLeftBarButtonTitles:(NSArray <NSString *> *)titles click:(void(^)(NSInteger buttonTag))block {
    NSArray *barButtonItems = [self handleBarButtonTitles: titles isLeft:YES];
    if (!barButtonItems.count) {
        return;
    }
    if (barButtonItems.count == 1) {
        self.navigationItem.leftBarButtonItem = [barButtonItems lastObject];
    } else {
        self.navigationItem.leftBarButtonItems = barButtonItems;
    }
    
    self.navigationLeftBarButtonClickBlock = block;
}

/**
 *  RightBarButtonItems(imageView)
 *
 *  @param imageNames imageNames array
 *  @param block      button click (right->left tag=1,2,3...)
 */
- (void)navigationRightBarButtonImageNames:(NSArray <NSString *> *)imageNames click:(void(^)(NSInteger buttonTag))block {
    NSArray *barButtonItems = [self handleBarButtonImageNames:imageNames isLeft:NO];
    if (!barButtonItems.count) {
        return;
    }
    if (barButtonItems.count == 1) {
        self.navigationItem.rightBarButtonItem = [barButtonItems lastObject];
    } else {
        self.navigationItem.rightBarButtonItems = barButtonItems;
    }
    
    self.navigationRightBarButtonClickBlock = block;
}
/**
 *  RightBarButtonItems(title)
 *
 *  @param titles title array
 *  @param block  button click (right->left tag=1,2,3...)
 */
- (void)navigationRightBarButtonTitles:(NSArray <NSString *> *)titles click:(void(^)(NSInteger buttonTag))block {
    NSArray *barButtonItems = [self handleBarButtonTitles:titles isLeft:NO];
    if (barButtonItems.count) {
        return;
    }
    if (barButtonItems.count == 1) {
        self.navigationItem.rightBarButtonItem = [barButtonItems lastObject];
    } else {
        self.navigationItem.rightBarButtonItems = barButtonItems;
    }
    
    self.navigationRightBarButtonClickBlock = block;
}
/**
 *  show indicator
 */
- (void)showIndicator {
    [self.indicatorWindow makeKeyAndVisible];
}

/**
 *  hidden indicator
 */
- (void)hiddenIndicator {
    [self.indicatorWindow setHidden:YES];
}


#pragma mark - ---------- Private Methods ----------

#pragma mark Data
- (void)initBaseData {
    
}

#pragma mark UI
- (void)configBaseUI {
    
}




#pragma mark Others

/**
 *  custom navigation titleView tap event
 *
 *  @param recognizer recognizer
 */
- (void)navigationTitleViewTap:(UITapGestureRecognizer *)recognizer {
    self.navigationTitleViewClickBlock();
}


// images transform buttons
- (NSMutableArray *)handleBarButtonImageNames:(NSArray *)imageNames isLeft:(BOOL)flag{
    NSMutableArray *barButtonItems = [NSMutableArray array];
    for (int i = 0; i < imageNames.count; i++) {
        UIImage *img = [UIImage imageNamed:imageNames[i]];
        if (img) {
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            bt.frame = CGRectMake(0, 0, 30, 30);
            [bt setImage:img forState:UIControlStateNormal];
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:bt];
            if (flag) {
                [bt addTarget:self action:@selector(navigationLeftBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            } else {
                [bt addTarget:self action:@selector(navigationRightBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            bt.tag = i + 1;
            [barButtonItems addObject:item];
        }
    }
    return barButtonItems;
}

// titles transform buttons
- (NSMutableArray *)handleBarButtonTitles:(NSArray *)titles isLeft:(BOOL)flag {
    NSMutableArray *barButtonItems = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = CGRectMake(0, 0, 44, 44);
        bt.titleLabel.font = FONT(16);
        [bt setTitle:titles[i] forState:UIControlStateNormal];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:bt];
        if (flag) {
            [bt addTarget:self action:@selector(navigationLeftBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [bt addTarget:self action:@selector(navigationRightBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        bt.tag = i + 1;
        [barButtonItems addObject:item];
    }
    return barButtonItems;
}

// LeftBarButtonClick
- (void)navigationLeftBarButtonClick:(UIButton *)sender
{
    if (self.navigationLeftBarButtonClickBlock) {
        self.navigationLeftBarButtonClickBlock(sender.tag);
    }
    
}
// RightBarButtonClick
- (void)navigationRightBarButtonClick:(UIButton *)sender
{
    if (self.navigationRightBarButtonClickBlock) {
        self.navigationRightBarButtonClickBlock(sender.tag);
    }
    
}



@end
