//
//  AppDelegate.m
//  LSZH
//
//  Created by 穆英波 on 16/5/18.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "HRAppDelegate.h"

#import "LSLeadViewController.h"

#import "LSLoginViewController.h"

#import "IQKeyboardManager.h"
@interface HRAppDelegate ()<LSLeadViewControllerDelegate>

@end

@implementation HRAppDelegate





- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [HRNetStatusManager shareConfiguration];
    [HRShareManager configEnvironment];
    
    [HRFirstEnter isFirst:^{
        // TODO:
    }];
    NSLog(@"%d", [HRVersion check]);

    //添加键盘自适应
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    //测试引导页 -----

//    NSUserDefaults *userdefuale = [NSUserDefaults standardUserDefaults];
//    [userdefuale setObject:nil forKey:@"mobile"];
//    [userdefuale setObject:nil forKey:@"password"];
    
    //进入页面先读取当前 存储 版本号
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    
    NSString *oldVersion = [userdefault objectForKey:@"versionNumber"];
    
    //获取当前系统版本
    NSString *currentVersion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
//    NSString *currentVersion = @"dafafa";
    
    
    
    //如果没有 或者 存储版本号 小于 当前版本号 都启动 引导页
    
    if (oldVersion == nil || oldVersion != currentVersion) {
    
        NSLog(@"不相等或者 为空");
        
        [userdefault setObject:currentVersion forKey:@"versionNumber"];
        
        [userdefault synchronize];
        
        LSLeadViewController *leadController = [[LSLeadViewController alloc]init];
        
        leadController.delegate = self;
        
        self.window.rootViewController = leadController;
        
        //如果是新版本,添加通知中心,准备进行页面转换
        //控制器为 引导页之后 点击事件发生 代理转换页面为主页
        
    }else{
        
        NSLog(@"版本相同");

        [self enterMainPage];
        
    }

    return YES;
}

//引导页代理方法
-(void)LeadControllerChangeRootController{
    
    [self enterMainPage];
    
}

//进入主界面
-(void)enterMainPage{
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    
    BOOL isSavePassword = [userdefault boolForKey:@"savePassword"];
    
    if (isSavePassword == NO) {
        [userdefault setObject:nil forKey:@"userId"];
    }
    
    [userdefault synchronize];

    self.window.rootViewController = [HREntrance rootViewController];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.Nobility.LSZH" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LSZH" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"LSZH.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
