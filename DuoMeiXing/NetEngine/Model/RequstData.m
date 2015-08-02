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



@implementation RequstVideo

+ (id)requstTopPlay
{
    return [self requstAction:@"top_play" withType:@""];
}

+ (id)requstTopComment
{
    return [self requstAction:@"top_comment" withType:@""];
}

+ (id)requstTeachingTguita
{
    return [self requstAction:@"teaching" withType:@"tguita"];
}

+ (id)requstTeachingPiano
{
    return [self requstAction:@"teaching" withType:@"piano"];
}

+ (id)requstTeachingEguita
{
    return [self requstAction:@"teaching" withType:@"eguita"];
}

+ (id)requstTeachingViolin
{
    return [self requstAction:@"teaching" withType:@"violin"];
}

+ (id)requstMePublished
{
    return [self requstAction:@"me" withType:@"published"];
}

+ (id)requstMeChecking
{
    return [self requstAction:@"me" withType:@"checking"];
}

+ (id)requstMeUploading
{
    return [self requstAction:@"me" withType:@"uploading"];
}

+ (id)requstAction:(NSString *)action withType:(NSString *)type
{
    NSDictionary *dic = @{
                          @"pageNo":@1,
                          @"pageSize":@3,
                          @"action":action,
                          @"type": type
                          };
    return [self objectWithKeyValues:dic];
}

@end
