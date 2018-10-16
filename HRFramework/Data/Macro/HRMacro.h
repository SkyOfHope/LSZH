/*===============================
||    @param name   Macro       ||
||    @param author muyingbo    ||
||    @param date   2016-03-28  ||
================================*/

#ifndef LMMacro_h
#define LMMacro_h

#pragma mark - -------------  System Singleton ----------------
#define UserDefault     [NSUserDefaults standardUserDefaults]
#define Notification    [NSNotificationCenter defaultCenter]
#define Application     [UIApplication sharedApplication]
#define AppDelegate     [[UIApplication sharedApplication] delegate]

#pragma mark - ------------------- XIB --------------------
#define LoadXib(Class) [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([Class class]) owner:nil options:nil] firstObject];

#pragma mark - ---------------- Storyboard ----------------
#define StoryboardInitialViewController(name) [[UIStoryboard storyboardWithName:name bundle:nil] instantiateInitialViewController]
#define StoryboardIdentifierViewController(name, identifier)   [[UIStoryboard storyboardWithName:name bundle:nil] instantiateViewControllerWithIdentifier:identifier]

#pragma mark - ---------------- Block ----------------
#define weakSelf(weakSelf) __weak typeof(self) weakSelf = self
#define strongSelf(strongSelf,weakSelf) __strong typeof(weakSelf) strongSelf = weakSelf

#pragma mark - ------------------ NSBundle -------------------
#define BUNDLE [NSBundle mainBundle]
// Bundle display name
#define APP_NAME [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define APP_VERSION [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APP_BUILD [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleVersion"]

#define BundleFilePath(name, type) [[NSBundle mainBundle] pathForResource:name ofType:type]
#define BundleImage(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:ext]]

#define PlistArray(name) [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"plist"]]
#define PlistDictionary(name) [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"plist"]]


#pragma mark - -------------------- UIScreen ------------------
#define SCREEN_BOUNDS     [UIScreen mainScreen].bounds
#define SCREEN_WIDTH      [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT     [UIScreen mainScreen].bounds.size.height


#pragma mark - ------------------- Color -------------------
#define RGB(r,g,b)          [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGB_0X(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RAND_COLOR          [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]

#pragma mark - -------------------- Log --------------------
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"--------------- [NSLog] ---------------\n[Method]:%s\n[Line]:%d\n[Content]:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif


#pragma mark - ------------------- String -------------------
#pragma mark FormatString
#define SF(...) [NSString stringWithFormat:__VA_ARGS__]

#pragma mark EmptyString
#define EmptyString(string) (string == nil || (NSNull *)string == [NSNull null] || [string isEqualToString:@""])

#define LocString(x, ...) NSLocalizedString(x, nil)


#pragma mark - ||================== Font ==================||
#define FONT(size) [UIFont systemFontOfSize:size]


#pragma mark - ------------------- G_C_D -------------------

#define GLOBAL_Q dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#define MAIN_Q dispatch_get_main_queue()

#define AS_GLOBAL(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

#define AS_MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

#define GCD_DELAY(time, block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_queue_create("custom", DISPATCH_QUEUE_CONCURRENT), block);


#pragma mark - -------------------- Language --------------------
#define LANGUAGE ([[NSLocale preferredLanguages] objectAtIndex:0])


#pragma mark - -------------------- Time --------------------

#pragma mark - -------------------- KeyBoard --------------------

#define HiddenKeyBoard [[Application keyWindow] endEditing:YES];


#endif /* LMMacro_h */
