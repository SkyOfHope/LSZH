//
//  LMShareSDK.m
//  shareDemo
//
//  Created by 穆英波 on 16/4/1.
//  Copyright © 2016年 ATM. All rights reserved.
//

#import "HRShareManager.h"

//mob:去mob平台注册应用获取 http://www.mob.com/#/
static NSString *const MOBAppKey = @"143795fbc6146";

//新浪:去新浪开发者平台注册应用获取
static NSString *const WBAppKey = @"待填写";
static NSString *const WBAppSecret = @"待填写";

//微信:去微信开发者平台注册应用获取 https://open.weixin.qq.com
static NSString *const WXAppId = @"wx8c60f8c65c0781fc";
static NSString *const WXAppSecret = @"94d0415977ff8f4d715f70d9c4d5db51";

//QQ:去腾讯开发者平台注册应用获取 http://open.qq.com
static NSString *const QQAppId = @"待填写";
static NSString *const QQAppKey = @"待填写";

@interface HRShareManager ()

@end

@implementation HRShareManager


+ (void)configEnvironment {
    
    [ShareSDK registerApp:MOBAppKey
          activePlatforms:@[ @(SSDKPlatformTypeSinaWeibo),
                             @(SSDKPlatformTypeQQ),
                             @(SSDKPlatformTypeWechat)]
                 onImport:^(SSDKPlatformType platformType) {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
    {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:WBAppKey
                                           appSecret:WBAppSecret
                                         redirectUri:@"http://www.weibo.com"
                                            authType:SSDKAuthTypeBoth];
                 break;
                 
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:WXAppId
                                       appSecret:WXAppSecret];
                 break;
                 
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:QQAppId
                                      appKey:QQAppKey
                                    authType:SSDKAuthTypeBoth];
                 break;
                 
             default:
                 break;
         }
     }];
}

/*~!
 *  Func share
 *  Auth muyingbo
 *  Time 2016-06-06
 *  Brif
 */
+ (void)shareTo:(Platform)platform title:(NSString *)title image:(UIImage *)image content:(NSString *)content url:(NSString *)url completed:(void(^)())block {
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];

    // 解决新浪无法分享及二次分享没反应的问题
    [shareParams SSDKEnableUseClientShare];
    
    [shareParams SSDKSetupShareParamsByText:content
                                     images:image
                                        url:[NSURL URLWithString:url]
                                      title:title
                                       type:SSDKContentTypeAuto];
    
    [ShareSDK share:(SSDKPlatformType)platform //分享的平台类型
         parameters:shareParams // 分享内容
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         // 回调处理
         block();
     }];
}






@end
