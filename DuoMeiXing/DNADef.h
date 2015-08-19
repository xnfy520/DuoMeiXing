//
//  DNADef.h
//  DuoMeiXing
//
//  Created by 天陨 on 15/6/18.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#ifndef DuoMeiXing_DNADef_h
#define DuoMeiXing_DNADef_h

#import "DisplayUtil.h"
#import "DNATabBarController.h"
#import "UIView+FrameMethods.h"
#import "UIImage+DNA.h"
#import "MJExtension.h"
#import "RequstData.h"
#import "ResponseData.h"
#import "RequestService.h"
#import "UserDataManager.h"
#import "Model.h"
#import "UIImageView+WebCache.h"
#import "UIScrollView+EmptyDataSet.h"

//视频列表
typedef enum : NSUInteger{
    kPhotographAlbumTypeDefault,    //我的视频
    kPhotographAlbumTypeNewest,     //最新视频
    kPhotographAlbumTypeHot,        //最热视频
    kPhotographAlbumTypePiano,      //钢琴视频
    kPhotographAlbumTypeTguita,     //吉他视频
    kPhotographAlbumTypeEguita,     //电吉他视频
    kPhotographAlbumTypeViolin,     //小提琴视频
    kPhotographAlbumTypePublished,  //发布成功
    kPhotographAlbumTypeChecking,   //等待审核
    kPhotographAlbumTypeUploading   //正在上传
} PhotographAlbumType;

typedef enum : NSUInteger{
    kOptionCtrlTypeNewest,          //最新
    kOptionCtrlTypeHot,             //最热
    kOptionCtrlTypeContacts,        //大师,专家
    kOptionCtrlTypeInstrument,      //乐器
    kOptionCtrlTypeTeaching,        //教材
    kOptionCtrlTypeAccount,         //帐户
    kOptionCtrlTypePhotographAlbum, //影集
    kOptionCtrlTypeSettings,        //设置
    kOptionCtrlTypeOrder,           //订单
    kOptionCtrlTypeAbout,           //关于
    kOptionCtrlTypeUpdate,          //更新
    kOptionCtrlTypeExit,            //退出
    kOptionCtrlTypeAvatar,          //头像
    kOptionCtrlTypeNickname,        //昵称
    kOptionCtrlTypePopoverScan,     //扫一扫
    kOptionCtrlTypePopoverVideo,    //上传视频
    kOptionCtrlTypePopoverFriend,   //新朋友
    kOptionCtrlTypeTopPaly,         //最多播放
    kOptionCtrlTypeTopComment,      //最多评论
    kOptionCtrlTypeTeachingTgita,   //吉他教材
    kOptionCtrlTypeTeachingPiano,   //钢琴教材
    kOptionCtrlTypeTeachingEgita,   //电吉他教材
    kOptionCtrlTypeTeachingViolin,  //小提琴教材
    kOptionCtrlTypeMyPublished,     //发布成功
    kOptionCtrlTypeMyChecking,      //等待审核
    kOptionCtrlTypeMyUploading      //正在上传
} OptionCtrlType;

typedef enum : NSUInteger{
    kCellListMessage,    //消息列表类型
    kCellListComment,    //评论列表类型
    kCellListVideo       //视频列表类型
} CellListType;

typedef enum : NSUInteger{
    kPhotographAlbumCategoryHot,        //最热
    kPhotographAlbumCategoryTeaching,   //教材
    kPhotographAlbumCategoryMyVideo    //我的视频
} PhotographAlbumCategory;

typedef enum : NSUInteger{
    kDisplayPannelReview,            //点评
    kDisplayPannelComments,          //评论
    kDisplayPannelInformation,       //信息
    kDisplayPannelWorks              //作品
} DisplayPanleType;

#define commentTypeNormal   @"NORMAL"

#define apiBaseUrl @"http://app.dmxing.cn"

#define appAPILogin             @"/dmx/app/ajax/login.dmx"                      //登录
#define appAPIRegister          @"/dmx/app/ajax/member_register.dmx"            //注册
#define appAPISMS               @"/dmx/app/ajax/send_smscode.dmx"               //验证码
//获取所有发送给我通知，包括我关注的朋友上传了新视频，我关注的朋友对我的视频发表了评论
#define appAPIMessageSummary    @"/dmx/app/ajax/video/message/summary/get.dmx"
#define appAPIMessageALL        @"/dmx/app/ajax/video/message/type/get_all.dmx"
#define appAPIVideo             @"/dmx/app/ajax/video/type/get.dmx"             //获取各类视频
#define appAPIVideoLast         @"/dmx/app/ajax/video/get_last.dmx"             //获取最新视频
#define appAPIVideoMember       @"/dmx/app/ajax/video/person/get.dmx"           //获取某个用户的所有视频
#define appAPIVideoComment      @"/dmx/app/ajax/video/comment/get_list.dmx"     //获取视频的评论
#define appAPIVideoId           @"/dmx/app/ajax/video/get.dmx"                  //通过视频ID获取视频信息

#define appCompanyCode @"dalmatian"

#define addObs(a, b)\
[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(b:) name:a object:nil];

#define removeObs(eventName)\
[[NSNotificationCenter defaultCenter]removeObserver:self name:eventName object:nil];

#define postEvent(eventName)\
[[NSNotificationCenter defaultCenter] postNotificationName:eventName object:nil];

#pragma mark - Global var

//获取设备物理高度
#define screenHeight [UIScreen mainScreen].bounds.size.height

//获取设备物理宽度
#define screenWidth [UIScreen mainScreen].bounds.size.width

#define appName @"哆每星"

#define globalLoginView @"onLoginView"
#define globalRegisterView @"onRegisterView"
#define globalMainView @"onMainView"

#define globalLoginAction @"onLogin"
#define globalLogoutAction @"onLogout"

#define statusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define navigationBarHeight self.navigationController.navigationBar.frame.size.height

#define statusBarWithNavigationBarHeight (statusBarHeight + navigationBarHeight)

#define listCellHeight 56.0f

#define listCellImageWith 60.0f

#define popoverSize CGSizeMake(120, 119)

#define submitButtonWith (screenWidth-20)

#define submitButtonPadding (screenWidth-submitButtonWith)/2

#define formFieldWith (screenWidth-20)

#define formFieldPadding (screenWidth-formFieldWith)/2

//默认背景色
#define defaultBackgroundColor [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1]

//默认导航条颜色 //[DisplayUtil hexStringToColor:@"#21292C"]
#define defaultNavigationBar [UIColor colorWithRed:55./255. green:63./255. blue:71./255. alpha:1.0]

#define defaultTabBarTitleColor [DisplayUtil hexStringToColor:@"#1284FF"]



//ios系统版本
#define ios8x [[[UIDevice currentDevice] systemVersion] floatValue] >=8.0f
#define ios7x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) && ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f)
#define ios6x [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f
#define iosNot6x [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f


#define iphone4x_3_5 ([UIScreen mainScreen].bounds.size.height==480)

#define iphone5x_4_0 ([UIScreen mainScreen].bounds.size.height==568)

#define iphone5x_4_0_height 568

#define iphone6_4_7 ([UIScreen mainScreen].bounds.size.height==667.0f)

#define iphone6Plus_5_5 ([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.height==414.0f)


#endif
