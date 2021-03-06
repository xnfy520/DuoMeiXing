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

@implementation ResponseMessage

+(NSArray *)allowedPropertyNames
{
    return @[@"id", @"content", @"msgNumbers", @"fromId", @"fromLogoUrl", @"videoId", @"chatType", @"messageType", @"fromNickName", @"createTime"];
}

@end


#pragma mark - 分页响应基类

@implementation ResponseBasePage


@end


#pragma mark - 消息响应

@implementation ResponseMessageResult

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"result" : @"ResponseMessage"
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

@implementation ResponseBaseInfo

+ (NSDictionary *)responseValidator
{
    return @{
             @"id": [NSString class],
             @"name": [NSString class],
             @"desc": [NSString class],
             @"picUrl": [NSString class],
             @"createTime": [NSNumber class]
             };
}

@end

@implementation ResponseVideo

+ (NSDictionary *)responseValidator
{
    return @{
             @"id": [NSString class],
             @"name": [NSString class],
             @"desc": [NSString class],
             @"picUrl": [NSString class],
             @"createTime": [NSNumber class],
             @"videoUrl": [NSString class],
             @"memberId": [NSString class],
             @"publishTime": [NSNumber class],
             @"totalBytes": [NSNumber class],
             @"likeTimes": [NSNumber class],
             @"playTimes": [NSNumber class]
             };
}

@end


@implementation ResponseVideoResult

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"result" : @"ResponseVideo"
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


@implementation ResponseVideoComment


@end


@implementation ResponseVideoCommentResult

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"result" : @"ResponseVideoComment"
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


//--

@implementation ResponseFriend

+ (NSDictionary *)responseValidator
{
    return @{
             @"id": [NSString class],
             @"logoUrl": [NSURL class],
             @"memberId": [NSString class],
             @"nickName": [NSString class],
             @"relationId": [NSString class],
             @"type": [NSString class]
             };
}

@end


@implementation ResponseFriendResult

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"result" : @"ResponseFriend"
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


//==

@implementation ResponseMember

+ (NSDictionary *)responseValidator
{
    return @{
             @"id": [NSString class],
             @"nickname": [NSString class],
             @"name": [NSString class],
             @"photoUrl": [NSURL class],
             @"userId": [NSString class],
             @"username": [NSString class]
             };
}

@end


@implementation ResponseMemberResult

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"result" : @"ResponseMember"
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


