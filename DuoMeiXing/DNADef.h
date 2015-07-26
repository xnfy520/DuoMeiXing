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

typedef enum : NSUInteger{
    kPhotographAlbumTypeDefault,    //我的视频
    kPhotographAlbumTypeNewest,     //最新视频
    kPhotographAlbumTypeHot         //最热视频
} PhotographAlbumType;

#define apiBaseUrl @"http://app.dmxing.cn";

#define companyCode @"dalmatian"

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

#define statusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define navigationBarHeight self.navigationController.navigationBar.frame.size.height

#define statusBarWithNavigationBarHeight (statusBarHeight + navigationBarHeight)

#define listCellHeight 50.0f

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
