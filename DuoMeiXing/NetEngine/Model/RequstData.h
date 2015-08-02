//
//  RequstData.h
//  DuoMeiXing
//
//  Created by 雪念飞叶 on 15/7/30.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 全局请求参数

@interface RequstData : NSObject
@property (nonatomic, copy) NSString *token;
@end


#pragma mark - 登录请求参数

@interface RequestLogin : RequstData
@property (nonatomic, copy) NSString *loginId;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *loginCode;
@end


#pragma mark - 注册请求参数

@interface RequestRegister : RequstData
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *smsCode;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *companyCode;
@end


#pragma mark - 短信验证码请求参数

@interface RequestSMS : RequstData
@property (nonatomic, copy) NSString *mobile;
@end


#pragma mark - 分页请求参数

@interface RequstPage : RequstData
@property (nonatomic, copy) NSString *pageNo;
@property (nonatomic, copy) NSString *pageSize;
@end

