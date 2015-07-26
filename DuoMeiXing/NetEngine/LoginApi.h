//
//  LoginApi.h
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/26.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "YTKRequest.h"

@interface LoginApi : YTKRequest

- (id)initWithLoginId:(NSString *)loginId password:(NSString *)password;

- (NSString *)userId;

@end
