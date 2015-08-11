//
//  LoginApi.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/26.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "RequestService.h"

@implementation RequestService

- (void)didChangeRea:(NSNotification*)notification
{
    NSLog(@"notifacation");
}

- (id)initReqeustUrl:(NSString*) requestUrl withPostData:(RequstData *)requestData withResponseValidator :(NSDictionary *)responseValidator
{
    NSLog(@"==========================");
    NSLog(@"requestUrl:%@", requestUrl);
    NSLog(@"==========================");
    self = [super init];
    if (self) {
        _requestUrl = requestUrl;
        _requstData = requestData;
        _responseValidator = responseValidator;

//        [self sese];
    }
    return self;
}

//- (void)sese
//{
//    AFHTTPSessionManager *aef = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:self.baseUrl]];
//    aef.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    [aef.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//                
//                
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//                NSLog(@"-------AFNetworkReachabilityStatusReachableViaWWAN------");
//                break;
//                
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                NSLog(@"-------AFNetworkReachabilityStatusReachableViaWiFi------");
//                break;
//            case AFNetworkReachabilityStatusNotReachable:
//                postEvent(AFNetworkingReachabilityDidChangeNotification);
//                NSLog(@"-------AFNetworkReachabilityStatusNotReachable------");
//                break;
//            default:
//                break;
//        }
//    }];
//    [aef.reachabilityManager startMonitoring];
//}

+ (id)messageReqeust
{
    RequstPage *requestData = [[RequstPage alloc] init];
    requestData.pageNo = @"1";
    requestData.pageSize = @"10";
    
    RequestService *request = [[RequestService alloc] initReqeustUrl:appAPIMessage withPostData:requestData withResponseValidator:[ResponseMessage responseValidator]];
    return request;
}

+ (id)videoMemberReqeustPostData:(RequstData *)requestData
{
    RequestService *request = [[RequestService alloc] initReqeustUrl:appAPIVideoMember withPostData:requestData withResponseValidator:[ResponseVideo responseValidator]];
    return request;
}

+ (id)videoCommentReqeustPostData:(RequstData *)requestData
{
    RequestService *request = [[RequestService alloc] initReqeustUrl:appAPIVideoComment withPostData:requestData withResponseValidator:[ResponseVideoCommentResult responseValidator]];
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

- (NSInteger)cacheTimeInSeconds
{
    return 60 * 3;
}

@end
