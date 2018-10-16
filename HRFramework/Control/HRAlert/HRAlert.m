

#import "HRAlert.h"

@interface HRAlert ()

/**
 *  alertController
 */
@property (nonatomic, strong) UIAlertController *alertController;

@end

@implementation HRAlert

/**
 *  alert
 *
 *  @param title
 *  @param message
 *  @param actionTitles
 *  @param button touchupInside
 */
+ (void)showTitle:(NSString *)title message:(NSString *)message action:(NSArray *)actionTitles click:(void (^)(NSInteger tag))block{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

    for (int i = 0; i < actionTitles.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            block(i);
        }];
        [alertController addAction:action];
    }
    
    [self performSelectorOnMainThread:@selector(show:) withObject:alertController waitUntilDone:NO];
}

/**
 *  show alert
 *
 *  @param alertController is pushed
 */
+ (void)show:(UIAlertController *)alertController {
    [AppDelegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
}


@end
