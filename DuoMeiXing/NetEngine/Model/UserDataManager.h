//
//  UserDataManager.h
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/26.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Singleton.h"

@interface UserDataManager : NSObject
{
    NSManagedObjectContext *context;
}

SINGLETON_INTERFACE(UserDataManager);

@property(strong, nonatomic) NSString* id;
@property(strong, nonatomic) NSString* userId;
@property(strong, nonatomic) NSString* token;
@property(strong, nonatomic) NSString* username;
@property(strong, nonatomic) NSString* nickname;
@property(strong, nonatomic) NSString* avatar;
@property(strong, nonatomic) NSString* avatarUrl;
@property(strong, nonatomic) NSString* mobile;

- (BOOL)isLogin;

- (void)initUser:(NSDictionary *)data;

- (void)updateUser;

- (void)clearUser;

@end
