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

@implementation RequstVideoMember

@end


@implementation RequstVideo

+ (id)requstNewestWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize
{
    return [self requstAction:@"" withType:@"" withPageNo:pageNo withPageSize:pageSize];
}

+ (id)requstTopPlayWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize
{
    return [self requstAction:@"top_play" withType:@"" withPageNo:pageNo withPageSize:pageSize];
}

+ (id)requstTopCommentWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize
{
    return [self requstAction:@"top_comment" withType:@"" withPageNo:pageNo withPageSize:pageSize];
}

+ (id)requstTeachingTguitaWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize
{
    return [self requstAction:@"teaching" withType:@"tguita" withPageNo:pageNo withPageSize:pageSize];
}

+ (id)requstTeachingPianoWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize
{
    return [self requstAction:@"teaching" withType:@"piano" withPageNo:pageNo withPageSize:pageSize];
}

+ (id)requstTeachingEguitaWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize
{
    return [self requstAction:@"teaching" withType:@"eguita" withPageNo:pageNo withPageSize:pageSize];
}

+ (id)requstTeachingViolinWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize
{
    return [self requstAction:@"teaching" withType:@"violin" withPageNo:pageNo withPageSize:pageSize];
}

+ (id)requstMePublishedWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize
{
    return [self requstAction:@"me" withType:@"published" withPageNo:pageNo withPageSize:pageSize];
}

+ (id)requstMeCheckingWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize
{
    return [self requstAction:@"me" withType:@"checking" withPageNo:pageNo withPageSize:pageSize];
}

+ (id)requstMeUploadingWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize
{
    return [self requstAction:@"me" withType:@"uploading" withPageNo:pageNo withPageSize:pageSize];
}

+ (id)requstAction:(NSString *)action withType:(NSString *)type withPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize
{
    NSDictionary *dic = @{
                          @"pageNo":@(pageNo),
                          @"pageSize":@(pageSize),
                          @"action":action,
                          @"type": type
                          };
    return [self objectWithKeyValues:dic];
}

@end