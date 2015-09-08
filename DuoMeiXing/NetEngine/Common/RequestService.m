//
//  LoginApi.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/26.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "RequestService.h"
#import "DNADef.h"

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
        
    }
    return self;
}

- (NSDictionary *)requestHeaderFieldValueDictionary
{
    NSDictionary *properties = [[NSMutableDictionary alloc] init];
    [properties setValue:
     [NSString stringWithFormat:@"%@=%@;%@=%@",
        sessionIdKey,
        [UserDataManager sharedUserDataManager].sessionId,
        sessionIdName,
        [UserDataManager sharedUserDataManager].token] forKey:@"Cookie"];
    return properties;
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

+ (id)registerReqeustPostData:(RequstData *)requestData
{
    RequestService *request = [[RequestService alloc] initReqeustUrl:appAPIRegister withPostData:requestData withResponseValidator:nil];
    return request;
}

+ (id)verifySmscodeReqeustPostData:(RequstData *)requestData
{
    RequestService *request = [[RequestService alloc] initReqeustUrl:appAPIVerifySMS withPostData:requestData withResponseValidator:nil];
    return request;
}

+ (id)messageSummaryReqeust
{
    RequstPage *requestData = [[RequstPage alloc] init];
    requestData.pageNo = @"1";
    requestData.pageSize = @"10";
    
    RequestService *request = [[RequestService alloc] initReqeustUrl:appAPIMessageSummary withPostData:requestData withResponseValidator:[ResponseMessageResult responseValidator]];
    return request;
}

+ (id)messageAllReqeustPostData:(RequstData *)requestData
{
    RequestService *request = [[RequestService alloc] initReqeustUrl:appAPIMessageALL withPostData:requestData withResponseValidator:[ResponseMessageResult responseValidator]];
    return request;
}

+ (id)videoMemberReqeustPostData:(RequstData *)requestData
{
    RequestService *request = [[RequestService alloc] initReqeustUrl:appAPIVideoMember withPostData:requestData withResponseValidator:[ResponseVideoResult responseValidator]];
    return request;
}

+ (id)videoCommentReqeustPostData:(RequstData *)requestData
{
    RequestService *request = [[RequestService alloc] initReqeustUrl:appAPIVideoComment withPostData:requestData withResponseValidator:nil];
    return request;
}

+ (id)gameReqeustPostData:(RequstData *)requestData
{
    RequestService *request = [[RequestService alloc] initReqeustUrl:appAPIGame withPostData:requestData withResponseValidator:[ResponseVideoResult responseValidator]];
    return request;
}

+ (id)videoLastReqeustPostData:(RequstData *)requestData
{
    RequestService *request = [[RequestService alloc] initReqeustUrl:appAPIVideoLast withPostData:requestData withResponseValidator:[ResponseVideoResult responseValidator]];
    return request;
}

+ (id)videoReqeustPostData:(RequstData *)requestData
{
    RequestService *request = [[RequestService alloc] initReqeustUrl:appAPIVideo withPostData:requestData withResponseValidator:[ResponseVideoResult responseValidator]];
    return request;
}


+ (id)videoIdRequestPostData:(RequstData *)requestData
{
    RequestService *request = [[RequestService alloc] initReqeustUrl:appAPIVideoId withPostData:requestData withResponseValidator:[ResponseVideo responseValidator]];
    return request;
}

+ (id)friendAllRequestPostData:(RequstData *)requestData
{
    RequestService *request = [[RequestService alloc] initReqeustUrl:appAPIFriendAll withPostData:requestData withResponseValidator:[ResponseFriendResult responseValidator]];
    return request;
}

+ (id)friendTeacherRequestPostData:(RequstData *)requestData
{
    RequestService *request = [[RequestService alloc] initReqeustUrl:appAPIFriendTeacher withPostData:requestData withResponseValidator:[ResponseFriendResult responseValidator]];
    return request;
}

+ (id)teacherAllRequestPostData:(RequstData *)requestData
{
    RequestService *request = [[RequestService alloc] initReqeustUrl:appAPITeacherAll withPostData:requestData withResponseValidator:[ResponseFriendResult responseValidator]];
    return request;
}

+ (id)mentorAllRequestPostData:(RequstData *)requestData
{
    RequestService *request = [[RequestService alloc] initReqeustUrl:appAPIMentorAll withPostData:requestData withResponseValidator:[ResponseFriendResult responseValidator]];
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
