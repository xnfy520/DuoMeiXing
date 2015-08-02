//
//  ResponseData.m
//  DuoMeiXing
//
//  Created by 雪念飞叶 on 15/7/30.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "ResponseData.h"
#import "DNADef.h"

#pragma mark - 全局响应

@implementation ResponseData

@end

@implementation ResponseUser


@end

//登录
@implementation ResponseLogin

+ (NSDictionary *)responseValidator
{
    return @{
             @"id": [NSString class],
             @"userId": [NSString class],
             @"token": [NSString class],
             @"username": [NSString class],
             @"nickname": [NSString class],
             @"avatarUrl": [NSString class],
             @"mobile": [NSString class]
             };
}

@end


#pragma mark - 短信验证码响应

@implementation ResponseSMS

+ (NSDictionary *)responseValidator
{
    return @{
             @"result": [NSNumber class]
             };
}

@end


#pragma mark - 消息结果

@implementation ResponseMessageResult

+(NSArray *)allowedPropertyNames
{
    return @[@"id", @"content", @"msgNumbers", @"fromId", @"fromLogoUrl", @"videoId", @"chatType", @"messageType", @"fromNickName", @"createTime"];
}

@end


#pragma mark - 分页响应基类

@implementation ResponseBasePage


@end


#pragma mark - 消息响应

@implementation ResponseMessage

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"result" : @"ResponseMessageResult"
             };
}

+ (NSDictionary *)responseValidator
{
    return @{
             @"pageNo": [NSNumber class],
             @"pageSize": [NSNumber class],
             @"prePage": [NSNumber class],
             @"nextPage": [NSNumber class],
             @"totalCount": [NSNumber class],
             @"totalPages": [NSNumber class],
             @"result": [NSArray class]
             };
}

@end



@implementation ResponseVideoResult


@end


@implementation ResponseVideo

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"result" : @"ResponseVideoResult"
             };
}

+ (NSDictionary *)responseValidator
{
    return @{
             @"pageNo": [NSNumber class],
             @"pageSize": [NSNumber class],
             @"prePage": [NSNumber class],
             @"nextPage": [NSNumber class],
             @"totalCount": [NSNumber class],
             @"totalPages": [NSNumber class],
             @"result": [NSArray class]
             };
}

@end