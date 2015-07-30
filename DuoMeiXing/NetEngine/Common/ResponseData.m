//
//  ResponseData.m
//  DuoMeiXing
//
//  Created by 雪念飞叶 on 15/7/30.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "ResponseData.h"
#import "DNADef.h"

@implementation ResponseData

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

@implementation ResponseSMS

+ (NSDictionary *)responseValidator
{
    return @{
             @"result": [NSNumber class]
             };
}

@end

//消息结果

@implementation ResponseMessageResult

+(NSArray *)allowedPropertyNames
{
    return @[@"id", @"content", @"msgNumbers", @"fromId", @"fromLogoUrl", @"videoId", @"chatType", @"messageType", @"fromNickName", @"createTime"];
}

@end

//消息
@implementation ResponseMessage

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