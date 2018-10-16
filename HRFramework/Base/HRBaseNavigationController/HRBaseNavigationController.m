
#import "HRBaseNavigationController.h"

@interface HRBaseNavigationController ()

@end

@implementation HRBaseNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    

}

// in order to adjust statusBar
- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

@end
