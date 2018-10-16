

#import "HRRegular.h"

@implementation HRRegular

/*~!
 *  brif    Telephone Number
 *  author  muyingbo
 *  time    2016-05-17
 */
+ (BOOL)checkTelephoneNumber:(NSString *)number {
    
    NSString *regex = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    
    NSPredicate *predicateRe = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    
    return [predicateRe evaluateWithObject:number];
    
}

/*~!
 *  brif    ID Card Number ( 15 | 18 )
 *  author  muyingbo
 *  time    2016-05-17
 */
+ (BOOL)checkIDCardNumber:(NSString *)number {
    
    NSString *regex = @"\\d{15}(\\d\\d[0-9xX])?";
    
    NSPredicate *predicateRe = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    
    return [predicateRe evaluateWithObject:number];
}

/*~!
 *  brif    Email
 *  author  muyingbo
 *  time    2016-05-17
 */
+ (BOOL)checkEmail:(NSString *)email {
    NSString *regex = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
    
    NSPredicate *predicateRe = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    
    return [predicateRe evaluateWithObject:email];
}

/*~!
 *  brif    URL
 *  author  muyingbo
 *  time    2016-05-17
 */
+ (BOOL)checkURL:(NSString *)url {
    NSString *regex = @"^http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?$";
    
    NSPredicate *predicateRe = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    
    return [predicateRe evaluateWithObject:url];
}

/*~!
 *  brif    Just Number
 *  author  muyingbo
 *  time    2016-05-17
 */
+ (BOOL)checkJustNumber:(NSString *)number {
    
    NSString *regex = @"^[0-9]+$";
    
    NSPredicate *predicateRe = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    
    return [predicateRe evaluateWithObject:number];
}

/*~!
 *  brif    Just English
 *  author  muyingbo
 *  time    2016-05-17
 */
+ (BOOL)checkJustLetter:(NSString *)string{
    
    NSString *regex = @"^[A-Za-z]+$";
    
    NSPredicate *predicateRe = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    
    return [predicateRe evaluateWithObject:string];
}

/*~!
 *  brif    Just Capital Letters
 *  author  muyingbo
 *  time    2016-05-17
 */
+ (BOOL)checkJustCapitalLetters:(NSString *)string {
    NSString *regex = @"^[A-Z]+$";
    
    NSPredicate *predicateRe = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    
    return [predicateRe evaluateWithObject:string];
}

/*~!
 *  brif    Just Lowercase
 *  author  muyingbo
 *  time    2016-05-17
 */
+ (BOOL)checkJustLowercase:(NSString *)string {
    
    NSString *regex = @"^[a-z]+$";
    
    NSPredicate *predicateRe = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    
    return [predicateRe evaluateWithObject:string];
}

/*~!
 *  brif    Just Chinese
 *  author  muyingbo
 *  time    2016-05-17
 */
+ (BOOL)checkJustChinese:(NSString *)string {
    NSString *regex = @"^[\u4e00-\u9fa5]+$";
    
    NSPredicate *predicateRe = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    
    return [predicateRe evaluateWithObject:string];
}

/*~!
 *  brif    Contain special character
 *  author  muyingbo
 *  time    2016-05-17
 */
+ (BOOL)checkContainSpecialCharacter:(NSString *)string {
    NSString *regex = @"[~`!@#$%^&*':;\"\?=/<>,\\.\\{\\}\\[\\]\\(\\)]+";
    
    NSPredicate *predicateRe = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    
    return [predicateRe evaluateWithObject:string];
}

@end
