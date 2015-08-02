//
//  RequstData.m
//  DuoMeiXing
//
//  Created by 雪念飞叶 on 15/7/30.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "RequstData.h"
#import "DNADef.h"

#pragma mark - 全局请求

@implementation RequstData
-(id)init
{
    if (self = [super init]) {
        self.token = [UserDataManager sharedUserDataManager].token;
    }
    return self;
}
@end


#pragma mark - 登录请求

@implementation RequestLogin
-(id)init
{
    if (self = [super init]) {
        self.loginCode = appCompanyCode;
    }
    return self;
}
@end


#pragma mark - 注册请求

@implementation RequestRegister
-(id)init
{
    if (self = [super init]) {
        self.companyCode = appCompanyCode;
    }
    return self;
}
@end


#pragma mark - 短信验证码请求

@implementation RequestSMS

@end


#pragma mark - 分页请求

@implementation RequstPage

@end
