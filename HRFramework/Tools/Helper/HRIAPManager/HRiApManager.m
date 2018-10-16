//
//  LMIAP.m
//  iAp支付
//
//  Created by 穆英波 on 16/4/7.
//  Copyright © 2016年 Obgniyum. All rights reserved.
//

#import "HRiApManager.h"
#import <StoreKit/StoreKit.h>

typedef void(^Failure)(NSString *error);
typedef void(^Success)(void);

@interface HRiApManager () <SKPaymentTransactionObserver,SKProductsRequestDelegate>

/**
 *  productID
 */
@property (nonatomic, copy) NSString *productID;
/**
 *  successBlock
 */
@property (nonatomic, copy) Success successBlock;
/**
 *  failureBlock
 */
@property (nonatomic, copy) Failure failureBlock;

@end

@implementation HRiApManager

#pragma mark - ---------- Singleton ----------
+ (instancetype)manager {
    static HRiApManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL]init];
    });
    return instance;
}
+ (instancetype) allocWithZone:(struct _NSZone *)zone {
    return [HRiApManager manager];
}
- (instancetype)copyWithZone:(struct _NSZone *)zone{
    return [HRiApManager manager];
}

- (void)payWithProductID:(NSString *)productID success:(void(^)(void))success failure:(void(^)(NSString *error))failure{

    self.successBlock = success;
    self.failureBlock = failure;
    
    self.productID = productID;
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    if([SKPaymentQueue canMakePayments]){
        NSLog(@"\n[允许程序内付费]");
        [self requestProductData:productID];
    }else{
        self.failureBlock(@"不允许程序内付费");
    }

}
#pragma mark 请求商品
- (void)requestProductData:(NSString *)type{
    NSLog(@"\n[请求对应的产品信息]");
    NSArray *product = [[NSArray alloc] initWithObjects:type, nil];
    NSSet *nsset = [NSSet setWithArray:product];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    [request start];
    
}

#pragma mark - SKProductsRequestDelegate <SKRequestDelegate>
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    NSLog(@"\n[收到产品反馈消息]");
    NSArray *product = response.products;
    if([product count] == 0){
        NSLog(@"\n[没有商品]");
        self.failureBlock(@"没有商品");
        return;
    }
    
    NSLog(@"\n[有商品]");
    NSLog(@"产品付费数量:%ld",[product count]);
    NSLog(@"产品标识:%@", response.invalidProductIdentifiers);
    SKProduct *p = nil;
    for (SKProduct *pro in product) {
        
        if([pro.productIdentifier isEqualToString:self.productID]){
            p = pro;
            NSLog(@"%@", [pro description]);
            NSLog(@"%@", [pro localizedTitle]);
            NSLog(@"%@", [pro localizedDescription]);
            NSLog(@"%@", [pro price]);
            NSLog(@"%@", [pro productIdentifier]);
        }
    }
    
    SKPayment *payment = [SKPayment paymentWithProduct:p];
    
    NSLog(@"\n[购买请求]\n");
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

#pragma mark - SKRequestDelegate
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    self.failureBlock(@"请求失败");
    NSLog(@"\n[请求失败]\n[失败信息]:\n%@", error);
    
}
- (void)requestDidFinish:(SKRequest *)request{
    NSLog(@"\n[请求结束]\n");
}

#pragma mark - SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction{
    for(SKPaymentTransaction *tran in transaction){
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:
                NSLog(@"\n[交易完成]\n");
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                [self completeTransaction:tran];
                
                // TODO:
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"\n[商品添加进列表]\n");
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"\n[已经购买过商品]\n");
                self.failureBlock(@"已经购买过商品");
                break;
            case SKPaymentTransactionStateFailed:
               //NSLog(@"\n[交易失败]\n");
                break;
            default:
                break;
        }
    }
}
//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"\n[交易结束]\n[请求成功]");
    self.successBlock();
}
- (void)dealloc{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

@end
