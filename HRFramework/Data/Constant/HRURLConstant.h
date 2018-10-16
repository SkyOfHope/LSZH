/*================================
||    @param name   URL          ||
||    @param author muyingbo     ||
||    @param date   2016-04-06   ||
=================================*/

#ifndef LMURLConstant_h
#define LMURLConstant_h
#import <Foundation/Foundation.h>


#pragma mark - ||=================== 协议 ===================||

#if DEBUG
#define URLProtocol @"http://"
#else
#define URLProtocol @"http://"
#endif

#pragma mark - ||=================== 地址 ===================||

#if DEBUG
#define URLHost @"www.wcsyq.gov.cn"
#else
#define URLHost @"www.wcsyq.gov.cn"
#endif

#pragma mark - ||=================== 端口 ===================||

#if DEBUG
#define URLPort @""
#else
#define URLPort @""
#endif


#pragma mark - ||=================== 路径 ====================||

#pragma mark - URLPath

// 举例
// 1.1.1
static NSString * const JAVA_USER_LOGIN = @"/Login/sendCode.aspx";

static NSString * const PHP_USER_LOGIN = @"/Login/sendCode.aspx";

//一、	首页轮播图
#define  GetBanner  @"/API/GetBanner.ashx"
//二、	首页搜索
#define  Search  @"/API/Search.ashx"
//三、	查询实验区动态（TOP 1）
#define  GetSyqdtTop  @"/API/GetSyqdtTop.ashx"
//四、	查询实验区动态（列表）
#define  GetSyqdt  @"/API/GetSyqdt.ashx"
//五、	查询实验区动态（详情）
#define  GetArticleModel  @"/API/GetArticleModel.ashx"
//六、	查询文化金融（列表）
#define  GetItemJinRong  @"/API/GetItemJinRong.ashx"
//七、	查询文化金融（详情）
#define  GetItemJinRongModel  @"/API/GetItemJinRongModel.ashx"
//八、	查询融资需求（列表）
#define  GetItemFinancing  @"/API/GetItemFinancing.ashx"
//九、	查询融资需求（详情）
#define  PATH_GetItemFinancingModel  @"/API/GetItemFinancingModel.ashx"
//十、	查询办公空间出租（列表）
#define  PATH_GetItemRentHouse  @"/API/GetItemRentHouse.ashx"
//十一、	查询办公空间出租（详情）
#define  PATH_GetItemRentHouseModel  @"/API/GetItemRentHouseModel.ashx"
//十五、	查询办公空间求租（为你推荐列表）(添加)
#define  PATH_GetItemWantHouse_TJ  @"/API/GetItemWantHouse_TJ.ashx"

//十二、	查询办公空间出租（为你推荐列表）(添加) 
#define  PATH_GetItemRentHouse_TJ  @"/API/GetItemRentHouse_TJ.ashx"

//十二、	查询办公空间求租（列表）
#define  PATH_GetItemWantHouse  @"/API/GetItemWantHouse.ashx"
//十三、	查询办公空间求租（详情）
#define  PATH_GetItemWantHouseModel @"/API/GetItemWantHouseModel.ashx"
//十四、	查询政策资讯（列表）
#define  PATH_GetArticle  @"/API/GetArticle.ashx"
////十五、	查询政策资讯（详情）
//#define  PATH_GetArticleModel  @"/API/GetArticleModel.ashx"
//十六、	查询项目详情页图片列表【公用方法】
#define  PATH_GetItemImg  @"/API/GetItemImg.ashx"


//登陆
//十七、	---------------------------------

//十八、	注册
#define  PATH_Register  @"/API/Register.ashx"
//十九、	查询手机号是否已经注册
#define  PATH_VerifyMobile  @"/API/VerifyMobile.ashx"
//二十、	获取手机验证码【公用方法】
#define  PATH_GetCode  @"/API/GetCode.ashx"
//二十一、	登录
#define  PATH_Login  @"/API/Login.ashx"


//二十二、	---------------------------------
//二十三、	上传图片【公用方法】
#define  PATH_UploadImg  @"/API/UploadImg.ashx"


//二十四、	-------------------------------
//二十五、	添加文化金融
#define  PATH_AddJinRong  @"/API/AddJinRong.ashx"
//二十六、	添加融资需求
#define  PATH_AddFinancing  @"/API/AddFinancing.ashx"
//二十七、	添加办公空间出租 $@$@$@ (和第五个接口相同)
#define  AddRentHouse  @"/API/AddRentHouse.ashx"
//二十八、	添加办公空间求租
#define  PATH_AddWantHouse  @"/API/AddWantHouse.ashx"



//二十九、	-------------------------------
//三十、	我发布的文化金融（列表）
#define  PATH_GetMyJinRong  @"/API/GetMyJinRong.ashx"
//三十一、	我发布的融资需求（列表）
#define  PATH_GetMyFinancing  @"/API/GetMyFinancing.ashx"
//三十二、	我发布的办公空间出租（列表）
#define  PATH_GetMyRentHouse  @"/API/GetMyRentHouse.ashx"
//三十三、	我发布的办公空间求租（列表）
#define  PATH_GetMyWantHouse  @"/API/GetMyWantHouse.ashx"
//三十四、	查询待审核数量【公用方法】
#define  PATH_GetNoReadCount  @"/API/GetNoReadCount.ashx"
//三十五、	结束发布【公用方法】
#define  PATH_UpdateStateEnd  @"/API/UpdateStateEnd.ashx"


//三十六、	-------------------------------
//三十七、	查询我的资料
#define  PATH_GetUserInfo  @"/API/GetUserInfo.ashx"
//三十八、	修改个人信息
#define  PATH_UpdateUser  @"/API/UpdateUser.ashx"
//三十九、	修改头像
#define  PATH_UpdateUserHeadImg  @"/API/UpdateUserHeadImg.ashx"
//四十、	修改密码
#define  PATH_UpdatePwd  @"/API/UpdatePwd.ashx"
//四十一、	忘记密码
#define  PATH_UpdatePwd2  @"/API/UpdatePwd2.ashx"

//四十二、	-------------------------------
//四十三、	加入收藏【公用方法】
#define  PATH_JoinCollect @"/API/JoinCollect.ashx"
//四十四、	取消收藏【公用方法】
#define  PATH_CancelCollect  @"/API/CancelCollect.ashx"
//四十五、	我收藏的文化金融（列表）
#define  PATH_GetCollectJinRong  @"/API/GetCollectJinRong.ashx"
//四十六、	我收藏的融资需求（列表）
#define  PATH_GetCollectFinancing  @"/API/GetCollectFinancing.ashx"
//四十七、	我收藏的办公空间出租（列表）
#define  PATH_GetCollectRentHouse  @"/API/GetCollectRentHouse.ashx"
//四十八、	我收藏的办公空间求租（列表）
#define  PATH_GetCollectWantHouse  @"/API/GetCollectWantHouse.ashx"
//四十九、	-------------------------------
//五十、	我的信箱（列表）
#define  PATH_GetUserMessage  @"/API/GetUserMessage.ashx"
//五十一、	我的信箱（详情）
#define  PATH_GetMessageModel  @"/API/GetMessageModel.ashx"
//五十二、	是否有未读约谈
#define  PATH_IsExistNewMeet  @"/API/IsExistNewMeet.ashx"
//五十三、	选择项目（列表）
#define  PATH_SelectMeetItem  @"/API/SelectMeetItem.ashx"
//五十四、	选择项目的基本详情
#define  PATH_SelectMeetItemModel  @"/API/SelectMeetItemModel.ashx"
//五十五、	发起约谈【公用方法】
#define  PATH_SendMeet  @"/API/SendMeet.ashx"
//五十六、	我发起的约谈（列表）
#define  PATH_GetUserSendMeet  @"/API/GetUserSendMeet.ashx"
//五十七、	我发起的约谈（详情）
#define  PATH_GetUserSendMeetModel  @"/API/GetUserSendMeetModel.ashx"
//五十八、	我收到的约谈（项目列表）
#define  PATH_GetUserMeetItem  @"/API/GetUserMeetItem.ashx"
//五十九、	我收到的约谈（用户列表）
#define  PATH_GetUserMeetUsers  @"/API/GetUserMeetUsers.ashx"
//六十、	我收到的约谈（详情）
#define  PATH_GetUserMeetModel  @"/API/GetUserMeetModel.ashx"

//六十一、 查询用户类型
#define  PATH_GetUserType  @"/API/GetUserType.ashx"

//六十二  是否收藏
#define  PATH_isHaveCollected  @"/API/IsCollect.ashx"


//六十三、 删除我发起的约谈
#define  PATH_DeleteAppoinmentFromMe  @"/API/DelUserSendMeet.ashx"

//六十四   删除我收到的约谈
#define  PATH_DeleteAppointmentITake  @"/API/DelUserMeet.ashx"

//www.wcsyq.gov.cn/API/IsShangxian.ashx
//六十五   判断是否上线
#define  Path_IsShangxian  @"/API/IsShangxian.ashx"















#endif /* LMURL_h */
