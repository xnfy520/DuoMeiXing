//
//  LoginApi.h
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/26.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "YTKRequest.h"
#import "DNADef.h"

@interface RequestService : YTKRequest

@property (nonatomic, copy) NSString *requestUrl;
@property (nonatomic, copy) RequstData *requstData;
@property (nonatomic, copy) NSDictionary *responseValidator;

- (id)initReqeustUrl:(NSString*) requestUrl withPostData:(RequstData *)requestData withResponseValidator :(NSDictionary *)responseValidator;

+ (id)messageSummaryReqeust;

+ (id)messageAllReqeustPostData:(RequstData *)requestData;

+ (id)videoMemberReqeustPostData:(RequstData *)requestData;

+ (id)videoCommentReqeustPostData:(RequstData *)requestData;

+ (id)gameAttendReqeustPostData:(RequstData *)requestData;

+ (id)gameReqeustPostData:(RequstData *)requestData;

+ (id)videoLastReqeustPostData:(RequstData *)requestData;

+ (id)videoReqeustPostData:(RequstData *)requestData;

+ (id)videoIdRequestPostData:(RequstData *)requestData;

+ (id)friendAllRequestPostData:(RequstData *)requestData;

+ (id)friendTeacherRequestPostData:(RequstData *)requestData;

+ (id)teacherAllRequestPostData:(RequstData *)requestData;

+ (id)mentorAllRequestPostData:(RequstData *)requestData;

@end
