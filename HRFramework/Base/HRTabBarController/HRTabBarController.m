

#import "HRTabBarController.h"
#import "Masonry.h"

@interface HRTabBarController ()

@property (nonatomic, strong)NSArray *controllers;

@property (nonatomic, strong)UIImageView *releaseImageView;

@end

@implementation HRTabBarController

#pragma mark - ---------------- Lazy Loading ----------------
-(UIImageView *)releaseImageView {
    if (_releaseImageView == nil) {
        UIImage *img = [UIImage imageNamed:@"发送"];
        _releaseImageView =[[UIImageView alloc] initWithImage:img];
        _releaseImageView.userInteractionEnabled = YES;
    }
    return _releaseImageView;
}

#pragma mark - ---------------- Lifecycle -------------------
/**
 *  init
 *
 *  @param controllerNames
 *
 *  @return instancetype
 */
- (instancetype)initWithViewControllers:(NSArray <NSString *>*)controllerNames {
    self = [super init];
    if (self) {

        self.viewControllers = [self transformClasses:controllerNames];
        
        
    
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self configTabBarUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"~!@#$^&* memory warning *&^$#@!~");
}

#pragma mark - ---------------- IBActions -------------------

#pragma mark - ---------------- Public Methods --------------

#pragma mark Override Super

#pragma mark Self Declare

/**
 *  TabBarImage
 *
 *  @param imageNames
 *  @param selectedImage
 */
- (void)setupTabBarImage:(NSArray <NSString *>*)imageNames selectedImage:(NSArray <NSString *>*)selectedImage {

    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tabBarItem.image = [[UIImage imageNamed:imageNames[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        obj.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }];
}

/**
 *  TabBarTitles
 *
 *  @param titles
 */
- (void)setupTabBarTitles:(NSArray <NSString *>*)titles {
    
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tabBarItem.title = titles[idx];
    }];
}

/**
 *  TabBarBackgroundColor
 *
 *  @param color
 */
- (void)setupTabBarBackgroundColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:245/255 green:245/255 blue:245/255 alpha:245/255].CGColor);
    CGContextSetFillColorWithColor(context,RGB(245, 245, 245).CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.tabBar.backgroundImage = image;
}
/**
 *  ItemTitleColor
 *
 *  @param selectedColor
 *  @param defaultColor
 */
- (void)setupItemTitleSelectedColor:(UIColor *)selectedColor defaultColor:(UIColor *)defaultColor {
    
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITabBarItem *item = obj.tabBarItem;
        NSDictionary *unselectedDic = [NSDictionary dictionaryWithObjectsAndKeys:defaultColor,UITextAttributeTextColor, nil];
        [item setTitleTextAttributes:unselectedDic forState:UIControlStateNormal];
        NSDictionary *selectedDic = [NSDictionary dictionaryWithObjectsAndKeys:selectedColor,
                                     UITextAttributeTextColor,nil];
        [item setTitleTextAttributes:selectedDic forState:UIControlStateSelected];
    }];
}

/**
 *  adjust image position
 *
 *  @param edge
 */
- (void)setupImageEdge:(UIEdgeInsets)edge {
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tabBarItem.imageInsets = edge;
    }];
}

/*~!
 *  brif    setupTabBarTopLineColor
 *  author  muyingbo
 *  time    2016-05-18
 */
- (void)setupTabBarTopLineColor:(UIColor *)color {
//    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);

    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.tabBar.shadowImage = image;
}



#pragma mark - ---------------- Private Methods -------------

#pragma mark Init Data

#pragma mark Config UserInteface
- (void)configTabBarUI {
    [self configReleaseImageView];
}


// tabBar add release imageView
- (void)configReleaseImageView {
    
    [self.tabBar addSubview:self.releaseImageView];
    
    self.releaseImageView.center = CGPointMake(SCREEN_WIDTH / 2, 7);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(releaseImageViewTap)];
    [self.releaseImageView addGestureRecognizer:tap];
    
}

- (void)releaseImageViewTap {
    [self setSelectedIndex:1];
}


#pragma mark Net Request

#pragma mark Setup Timer


#pragma mark ClassesTransformController
- (NSArray <UIViewController *>*)transformClasses:(NSArray <NSString *>*)classes {
    NSMutableArray *arr = [NSMutableArray array];
    [classes enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Class class = NSClassFromString(obj);
        UIViewController *vc = [class new];
        [arr addObject:vc];
    }];
    return arr;
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
