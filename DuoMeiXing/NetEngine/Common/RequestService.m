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

+ (id)messageReqeust
{
    RequstPage *requestData = [[RequstPage alloc] init];
    requestData.pageNo = @"1";
    requestData.pageSize = @"10";
    
    RequestService *request = [[RequestService alloc] initReqeustUrl:appAPIMessage withPostData:requestData withResponseValidator:[ResponseMessage responseValidator]];
    return request;
}

+ (id)videoLastReqeustPostData:(RequstData *)requestData
{
    RequestService *request = [[RequestService alloc] initReqeustUrl:appAPIVideoLast withPostData:requestData withResponseValidator:[ResponseVideo responseValidator]];
    return request;
}

+ (id)videoReqeustPostData:(RequstData *)requestData
{
    RequestService *request = [[RequestService alloc] initReqeustUrl:appAPIVideo withPostData:requestData withResponseValidator:[ResponseVideo responseValidator]];
    return request;
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
