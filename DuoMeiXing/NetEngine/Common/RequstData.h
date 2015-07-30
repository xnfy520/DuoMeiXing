//
//  RequstData.h
//  DuoMeiXing
//
//  Created by 雪念飞叶 on 15/7/30.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequstData : NSObject
@property (nonatomic, copy) NSString *token;
@end

@interface RequestLogin : RequstData
@property (nonatomic, copy) NSString *loginId;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *loginCode;
@end

@interface RequestRegister : RequstData
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *smsCode;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *companyCode;
@end

@interface RequestSMS : RequstData
@property (nonatomic, copy) NSString *mobile;
@end

@interface RequstPage : RequstData
@property (nonatomic, copy) NSString *pageNo;
@property (nonatomic, copy) NSString *pageSize;
@end