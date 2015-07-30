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

@interface RequstPage : RequstData
@property (nonatomic, copy) NSString *pageNo;
@property (nonatomic, copy) NSString *pageSize;
@end

@interface RequestLogin : RequstData
@property (nonatomic, copy) NSString *loginId;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *loginCode;
@end