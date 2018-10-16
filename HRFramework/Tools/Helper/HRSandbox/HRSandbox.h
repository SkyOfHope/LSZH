
/*================================
||    @param name   SandboxPath      ||
||    @param author muyingbo     ||
||    @param date   2016-03-28   ||
=================================*/

#import <Foundation/Foundation.h>

@interface HRSandbox : NSObject

/**
 *  bundle 路径，不能存储任何东西
 *
 *  @return path
 */
+ (NSString *)appPath;

/**
 *  document 目录，itunes会备份，存储非常重要的文件
 *
 *  @return path
 */
+ (NSString *)docPath;


/**
 *  libary 目录
 *
 *  @return path
 */
+ (NSString *)libPath;


/**
 *  prefrence目录保存程序的设置信息，itunes会备份。
 *
 *  @return path
 */
+ (NSString *)libPrePath;


/**
 *  cache目录保存程序的缓存信息，itunes不会备份。
 *
 *  @return path
 */
+ (NSString *)libCachePath;

/**
 *  tmp路径存储数据较大的临时文件，程序重新启动会清除这个文件夹里的所有内容。
 *
 *  @return path
 */
+ (NSString *)tmpPath;

@end
