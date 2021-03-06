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
@property (nonatomic, copy) NSString *companyCode;
@end

@interface RequestVerifySmscode : RequstData
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *smsCode;
+ (id)requstMobile:(NSString *)mobile withSmscode:(NSString *)smsCode;
@end

#pragma mark - 短信验证码请求参数

@interface RequestSMS : RequstData
@property (nonatomic, copy) NSString *mobile;
@end

@interface RequstPage : RequstData
@property (nonatomic, copy) NSString *pageNo;
@property (nonatomic, copy) NSString *pageSize;
@end

@interface RequstGame : RequstPage
+ (id)requstGameWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize;
@end

@interface RequstFriendAll : RequstPage
+ (id)requstFriendAllWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize;
@end

@interface RequstFriendTeacher : RequstPage
+ (id)requstFriendTeacherWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize;
@end

@interface RequstTeacherAll : RequstPage
+ (id)requstTeacherAllWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize;
@end

@interface RequstMentorAll : RequstPage
+ (id)requstMentorAllWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize;
@end

#pragma mark - 不同消息类型请求参数

@interface RequstMessageAll : RequstPage
@property (nonatomic, copy) NSString *action;
@property (nonatomic, copy) NSString *type;
+ (id)requstMessageCommentWithVideoId:(NSString *)videoId PageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize;
+ (id)requstMessageUploadWithFirendId:(NSString *)firendId PageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize;
@end

@interface RequstVideoMember : RequstPage
@property (nonatomic, copy) NSString *memberId;
+ (id)requstVideoMemberWithMemberId:(NSString *)memberId PageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize;
@end

@interface RequstVideoComment : RequstPage
@property (nonatomic, copy) NSString *videoId;
@property (nonatomic, copy) NSString *type;
+ (id)requstVideoReviewWithVideoId:(NSString *)videoId PageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize;
+ (id)requstVideoCommentWithVideoId:(NSString *)videoId PageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize;
@end

@interface RequstVideoId : RequstPage
@property (nonatomic, copy) NSString *videoId;
+ (id)requstVideoWithVideoId:(NSString *)videoId;
@end

@interface RequstVideo : RequstPage
@property (nonatomic, copy) NSString *action;
@property (nonatomic, copy) NSString *type;

+ (id)requstGameWithGameId:(NSString *)gameId WithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize;

+ (id)requstNewestWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize;

+ (id)requstTopPlayWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize;
+ (id)requstTopCommentWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize;

+ (id)requstTeachingTguitaWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize;
+ (id)requstTeachingPianoWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize;
+ (id)requstTeachingEguitaWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize;
+ (id)requstTeachingViolinWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize;

+ (id)requstMePublishedWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize;
+ (id)requstMeCheckingWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize;
+ (id)requstMeUploadingWithPageNo:(NSInteger)pageNo withPageSize:(NSInteger)pageSize;

@end

