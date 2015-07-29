//
//  VideoList.m
//  DuoMeiXing
//
//  Created by 雪念飞叶 on 15/7/29.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "VideoList.h"
#import "DNADef.h"

@implementation VideoList
{
    NSString *_token;
    NSString *_action;//me teaching top_play top_comment
    //me->checking/published/uploading
    //teaching->piano/tguita/eguita/violin
    //top_play->
    //top_comment->
    NSString *_type;
    NSString *_pageNo;
    NSString *_pageSize;
}

- (id)initWithAction:(NSString *)action withType:(NSString *)type PageNo:(NSString *)pageNo pageSize:(NSString *)pageSize
{
    if (self = [super init]) {
        _token = [UserDataManager sharedUserDataManager].token;
        _action = action;
        _type = type;
        _pageNo = pageNo;
        _pageSize = pageSize;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/dmx/app/ajax/video/type/get.dmx";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"token": _token,
             @"action": _action,
             @"type": _type,
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
