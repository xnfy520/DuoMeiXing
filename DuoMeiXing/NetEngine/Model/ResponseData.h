//
//  ResponseData.h
//  DuoMeiXing
//
//  Created by 雪念飞叶 on 15/7/30.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 全局响应

@interface ResponseData : NSObject

@end

@interface ResponseUser : ResponseData
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSURL *avatarUrl;
@property (nonatomic, copy) NSString *mobile;
@end

//登录
@interface ResponseLogin : ResponseUser

@property (nonatomic, copy) NSString *token;

+ (NSDictionary *)responseValidator;

@end


#pragma mark - 短信验证码响应数据

@interface ResponseSMS : ResponseData

@property (nonatomic, copy) NSNumber *result;
@property (nonatomic, copy) NSString *tips;

+ (NSDictionary *)responseValidator;

@end

#pragma mark - 分页响应基类

@interface ResponseBasePage : ResponseData

@property (nonatomic, copy) NSNumber *pageNo;
@property (nonatomic, copy) NSNumber *pageSize;
@property (nonatomic, copy) NSNumber *prePage;
@property (nonatomic, copy) NSNumber *nextPage;
@property (nonatomic, copy) NSNumber *totalCount;
@property (nonatomic, copy) NSNumber *totalPages;

@end

#pragma mark - 消息结果

@interface ResponseMessage : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSNumber *msgNumbers;
@property (nonatomic, copy) NSString *fromId;
@property (nonatomic, copy) NSURL *fromLogoUrl;
@property (nonatomic, copy) NSString *videoId;
@property (nonatomic, copy) NSString *chatType;
@property (nonatomic, copy) NSString *messageType;
@property (nonatomic, copy) NSString *fromNickName;
@property (nonatomic, copy) NSNumber *createTime;

@end

#pragma mark - 消息响应数据

@interface ResponseMessageResult : ResponseBasePage

@property (nonatomic, copy) NSArray *result;

+ (NSDictionary *)responseValidator;

@end

@interface ResponseBaseInfo : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSURL *picUrl;
@property (nonatomic, copy) NSNumber *createTime;

+ (NSDictionary *)responseValidator;

@end

@interface ResponseVideo : ResponseBaseInfo

@property (nonatomic, copy) NSURL *videoUrl;
@property (nonatomic, copy) NSString *memberId;
@property (nonatomic, copy) NSNumber *publishTime;
@property (nonatomic, copy) NSNumber *totalBytes;
@property (nonatomic, copy) NSNumber *likeTimes;
@property (nonatomic, copy) NSNumber *playTimes;


+ (NSDictionary *)responseValidator;

@end



#pragma mark - 视频响应数据

@interface ResponseVideoResult : ResponseBasePage

@property (nonatomic, copy) NSArray *result;

+ (NSDictionary *)responseValidator;

@end


@interface ResponseVideoComment : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSURL *logoUrl;
@property (nonatomic, copy) NSString *videoId;
@property (nonatomic, copy) NSString *memberId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSNumber *createTime;

@end

#pragma mark - 视频响应数据

@interface ResponseVideoCommentResult : ResponseBasePage

@property (nonatomic, copy) NSArray *result;

+ (NSDictionary *)responseValidator;

@end


@interface ResponseFriend : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSURL *logoUrl;
@property (nonatomic, copy) NSString *memberId;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *relationId;
@property (nonatomic, copy) NSString *type;


+ (NSDictionary *)responseValidator;

@end



#pragma mark - 视频响应数据

@interface ResponseFriendResult : ResponseBasePage

@property (nonatomic, copy) NSArray *result;

+ (NSDictionary *)responseValidator;

@end

