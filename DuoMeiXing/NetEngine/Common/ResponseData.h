//
//  ResponseData.h
//  DuoMeiXing
//
//  Created by 雪念飞叶 on 15/7/30.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseData : NSObject

@end

//登录
@interface ResponseLoginData : ResponseData

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *avatarUrl;
@property (nonatomic, copy) NSString *mobile;

+ (NSDictionary *)responseValidator;

@end


//消息结果
@interface ResponseMessageResultData : ResponseData

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSNumber *msgNumbers;
@property (nonatomic, copy) NSString *fromId;
@property (nonatomic, copy) NSString *fromLogoUrl;
@property (nonatomic, copy) NSString *videoId;
@property (nonatomic, copy) NSString *chatType;
@property (nonatomic, copy) NSString *messageType;
@property (nonatomic, copy) NSString *fromNickName;
@property (nonatomic, copy) NSNumber *createTime;

@end


//消息
@interface ResponseMessageData : ResponseData

@property (nonatomic, copy) NSNumber *pageNo;
@property (nonatomic, copy) NSNumber *pageSize;
@property (nonatomic, copy) NSNumber *prePage;
@property (nonatomic, copy) NSNumber *nextPage;
@property (nonatomic, copy) NSNumber *totalCount;
@property (nonatomic, copy) NSNumber *totalPages;
@property (nonatomic, copy) NSArray *result;

+ (NSDictionary *)responseValidator;

@end