//
//  LoginApi.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/26.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "RequestService.h"

@implementation RequestService

- (id)initReqeustUrl:(NSString*) requestUrl withPostData:(RequstData *)requestData withResponseValidator :(NSDictionary *)responseValidator
{
    self = [super init];
    if (self) {
        _requestUrl = requestUrl;
        _requstData = requestData;
        _responseValidator = responseValidator;
    }
    return self;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (NSString *)requestUrl
{
    return _requestUrl;
}

- (id)requestArgument
{
    return _requstData.keyValues;
}

- (id)jsonValidator
{
    return _responseValidator;
}

@end
