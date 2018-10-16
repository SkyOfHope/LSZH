/*===================================
||    @param name   IAPVerifyURL    ||
||    @param author muyingbo        ||
||    @param date   2016-03-28      ||
====================================*/

#ifndef LMIAPVerifyURLConstant_h
#define LMIAPVerifyURLConstant_h

#if DEBUG 
#define IAP_VERIFY_URL @"https://sandbox.itunes.apple.com/verifyReceipt"
#else
#define IAP_VERIFY_URL @"https://buy.itunes.apple.com/verifyReceipt"
#endif


#endif /* LMIAPVerifyURLConstant_h */
