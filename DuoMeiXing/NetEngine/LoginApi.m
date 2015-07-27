//
//  LoginApi.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/26.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "LoginApi.h"
#import "DNADef.h"

@implementation LoginApi {
    NSString *_loginId;
    NSString *_password;
}

- (id)initWithLoginId:(NSString *)loginId password:(NSString *)password {
    self = [super init];
    if (self) {
        _loginId = loginId;
        _password = password;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/dmx/app/ajax/login.dmx";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"loginId": _loginId,
             @"password": _password,
             @"loginCode": companyCode
             };
}

- (id)jsonValidator {
    return @{
             @"id": [NSString class],
             @"userId": [NSString class],
             @"token": [NSString class],
             @"username": [NSString class],
             @"nickname": [NSString class],
             @"avatar": [NSString class],
             @"avatarUrl": [NSString class],
             @"mobile": [NSString class]
             };
}

@end
