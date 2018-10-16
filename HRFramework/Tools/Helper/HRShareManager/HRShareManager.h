//
//  LMShareSDK.h
//  shareDemo
//
//  Created by 穆英波 on 16/4/1.
//  Copyright © 2016年 ATM. All rights reserved.
//
#pragma mark ----------   说明（环境配置） ----------



/*
    1. 接入sdk, 推荐cocoapods
 
 pod 'ShareSDK3/ShareSDKPlatforms/QQ'
 pod 'ShareSDK3/ShareSDKPlatforms/SinaWeibo'
 pod 'ShareSDK3/ShareSDKPlatforms/WeChat'
 pod 'MOBFoundation'
 pod 'ShareSDK3'
 
 
    2. 去对应开发者平台(如腾讯、新浪、微信... + mob(这里用了第三方分享平台))注册应用并获取开发所需信息（appid、key、secret等）, 填写到.m对应位置
 
    3. 设置白名单
       以 SourceCode 方式打开 info.plist 文件添加如下代码
 
 <key>LSApplicationQueriesSchemes</key>
 <array>
 <string>wechat</string>
 <string>weixin</string>
 <string>sinaweibohd</string>
 <string>sinaweibo</string>
 <string>sinaweibosso</string>
 <string>weibosdk</string>
 <string>weibosdk2.5</string>
 <string>mqqapi</string>
 <string>mqq</string>
 <string>mqqOpensdkSSoLogin</string>
 <string>mqqconnect</string>
 <string>mqqopensdkdataline</string>
 <string>mqqopensdkgrouptribeshare</string>
 <string>mqqopensdkfriend</string>
 <string>mqqopensdkapi</string>
 <string>mqqopensdkapiV2</string>
 <string>mqqopensdkapiV3</string>
 <string>mqzoneopensdk</string>
 <string>wtloginmqq</string>
 <string>wtloginmqq2</string>
 <string>mqqwpa</string>
 <string>mqzone</string>
 <string>mqzonev2</string>
 <string>mqzoneshare</string>
 <string>wtloginqzone</string>
 <string>mqzonewx</string>
 <string>mqzoneopensdkapiV2</string>
 <string>mqzoneopensdkapi19</string>
 <string>mqzoneopensdkapi</string>
 <string>mqzoneopensdk</string>
 <string>alipay</string>
 <string>alipayshare</string>
 </array>
 
    4. 配置 URL schemes(免登录)
       位置：target -> info -> URL Types
 
       4.1 QQ的url scheme的设置格式为：”QQ” ＋ AppId的16进制（如果appId转换的16进制数不够8位则在前面补0，如转换的是：5FB8B52，则最终填入为：QQ05FB8B52 注意：转换后的字母要大写）
 
       4.2 新浪微博的 url scheme 的设置格式为 wb+AppID
 
       4.3 微信的 url scheme 的设置格式为：微信appId
 
    5. 适配iOS9，网络协议
        以 SourceCode 方式打开 info.plist, 粘贴如下代码
 
 <key>NSAppTransportSecurity</key>
	<dict>
 <key>NSAllowsArbitraryLoads</key>
 <true/>
	</dict>
 
    6. 修改程序的bundleId, 与创建应用时一致，运行程序
 
    补充说明：更多问题参考mob平台http://www.mob.com/#/
 
    Q1: 新浪无法分享url
    S1: 把url拼接在content后面
 
 */


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

#import "WeiboSDK.h"//新浪微博SDK头文件
#import "WXApi.h"//微信SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>//QQ
#import <TencentOpenAPI/QQApiInterface.h>//QQ空间


typedef NS_ENUM(NSInteger, Platform) {
    PlatformWechat = 997,//微信平台
    PlatformWechatSession = 22, //微信好友
    PlatformWechatTimeline = 23, //微信朋友圈
    PlatformQQ = 998,//QQ平台
    PlatformQZone = 6 , //QQ空间
    PlatformQQfriend = 24, //QQ好友
    PlatformSina = 1, //新浪微博
};

@interface HRShareManager : NSObject

/*~!
 *  Func 环境配置
 *  Auth muyingbo
 *  Time 2016-06-06
 *  Brif
 */
+ (void)configEnvironment;


/*~!
 *  Func 分享
 *  Auth muyingbo
 *  Time 2016-06-06
 *  Brif
 */
+ (void)shareTo:(Platform)platform title:(NSString *)title image:(UIImage *)image content:(NSString *)content url:(NSString *)url completed:(void(^)())block;



@end
