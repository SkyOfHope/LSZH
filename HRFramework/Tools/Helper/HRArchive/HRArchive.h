
/*================================
||    @param name   Archive      ||
||    @param author muyingbo     ||
||    @param date   2016-03-28   ||
=================================*/

#import <Foundation/Foundation.h>

@interface HRArchive : NSObject

/**
 *  archive
 *
 *  @param obj  coder object
 *  @param path coder path
 */
+ (void)archiveObject:(NSObject *)obj toPath:(NSString *)file;
/**
 *  unarchive
 *
 *  @param path decoder path
 *
 *  @return decoder object
 */
+ (id)unarchiveFromPath:(NSString *)file;


@end
