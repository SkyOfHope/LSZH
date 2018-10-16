

#import "HREntrance.h"
#import "HRTabBarController.h"
#import "HRBaseNavigationController.h"
#import "Masonry.h"

@interface HREntrance ()

@end

@implementation HREntrance

+ (UIViewController *)rootViewController {
    
#pragma mark - child controllers
    NSArray *controllerNames = @[@"LSHomeViewController",@"LSReleaseViewController", @"LSPersonalViewController"];
    HRTabBarController *tabBarVC = [[HRTabBarController alloc] initWithViewControllers:controllerNames];

#pragma mark - images
    NSArray *imageSelected = PlistArray(@"TabBarSelectedImageNames");
    NSArray *imageDefault = PlistArray(@"TabBarDefaultImageNames");
    [tabBarVC setupTabBarImage:imageDefault selectedImage:imageSelected];
    
#pragma mark - titles
    
    [tabBarVC setupTabBarTitles:PlistArray(@"TabBarTitles")];
    
    
#pragma mark - title color
    [tabBarVC setupItemTitleSelectedColor:COLOR_3296ED defaultColor:[UIColor grayColor]];
    
#pragma mark - TabBarBackgroundColor
    [tabBarVC setupTabBarBackgroundColor:[UIColor whiteColor]];
    
#pragma mark - TabBarTopLineColor
    [tabBarVC setupTabBarTopLineColor:[UIColor clearColor]];
    
    HRBaseNavigationController *navi = [[HRBaseNavigationController alloc] initWithRootViewController:tabBarVC];

    return navi;
}

@end
