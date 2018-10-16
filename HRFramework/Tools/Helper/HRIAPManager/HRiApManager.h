/*===============================
||    @param name   iAp         ||
||    @param author muyingbo    ||
||    @param date   2016-03-28  ||
================================*/

/**
*
 *  Note:
 *
 *  1. developer center make productId for server
 *  2. developer center regisiter sandbox member
 *  3. request product order message
 *  4. according to product to pay
 *  5. send receipt-data to server
 *  6. remember handle receipt-data when it was lost
 *
 */


#import <Foundation/Foundation.h>

@interface HRiApManager : NSObject

/**
 *  Singleton
 *
 *  @return instancetype
 */
+ (instancetype)manager;

/**
 *  iap
 *
 *  @param productID
 *  @param success
 *  @param failure
 */
- (void)payWithProductID:(NSString *)productID success:(void(^)(void))success failure:(void(^)(NSString *error))failure;


@end
