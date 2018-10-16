

#import <Foundation/Foundation.h>

@interface HRRegular : NSObject

/*~!
 *  brif    Telephone Number
 *  author  muyingbo
 *  time    2016-05-17
 */
+ (BOOL)checkTelephoneNumber:(NSString *)number;

/*~!
 *  brif    ID Card Number ( 15 | 18 )
 *  author  muyingbo
 *  time    2016-05-17
 */
+ (BOOL)checkIDCardNumber:(NSString *)number;

/*~!
 *  brif    Email
 *  author  muyingbo
 *  time    2016-05-17
 */
+ (BOOL)checkEmail:(NSString *)email;

/*~!
 *  brif    URL
 *  author  muyingbo
 *  time    2016-05-17
 */
+ (BOOL)checkURL:(NSString *)url;


/*~!
 *  brif    Just Number
 *  author  muyingbo
 *  time    2016-05-17
 */
+ (BOOL)checkJustNumber:(NSString *)number;

/*~!
 *  brif    Just Letter
 *  author  muyingbo
 *  time    2016-05-17
 */
+ (BOOL)checkJustLetter:(NSString *)string;

/*~!
 *  brif    Just Capital Letters
 *  author  muyingbo
 *  time    2016-05-17
 */
+ (BOOL)checkJustCapitalLetters:(NSString *)string;


/*~!
 *  brif    Just Lowercase
 *  author  muyingbo
 *  time    2016-05-17
 */
+ (BOOL)checkJustLowercase:(NSString *)string;

/*~!
 *  brif    Just Chinese
 *  author  muyingbo
 *  time    2016-05-17
 */
+ (BOOL)checkJustChinese:(NSString *)string;

/*~!
 *  brif    Contain special character
 *  author  muyingbo
 *  time    2016-05-17
 */
+ (BOOL)checkContainSpecialCharacter:(NSString *)string;



@end
