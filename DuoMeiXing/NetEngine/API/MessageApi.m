//
//  MessageApi.m
//  DuoMeiXing
//
//  Created by 雪念飞叶 on 15/7/28.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "MessageApi.h"
#import "DNADef.h"

@implementation MessageApi
{
    NSString *_token;
    NSString *_pageNo;
    NSString *_pageSize;
}

- (id)initWithPageNo:(NSString *)pageNo pageSize:(NSString *)pageSize {
    self = [super init];
    if (self) {
        _token = [UserDataManager sharedUserDataManager].token;
        _pageNo = pageNo;
        _pageSize = pageSize;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/dmx/app/ajax/video/message/get.dmx";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"token": _token,
             @"pageNo": _pageNo,
             @"pageSize": _pageSize
             };
}

- (id)jsonValidator {
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
