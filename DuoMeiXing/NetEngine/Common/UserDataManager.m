//
//  UserDataManager.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/26.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "UserDataManager.h"

@implementation UserDataManager

SINGLETON_IMPLEMENTATION(UserDataManager);

- (id)init
{
    if (self = [super init]) {
        context = [[CoreDataManager shardCoreDataManager] moc];
    }
    return self;
}

- (void)printPathToStore
{
    NSLog(@"%@", [[CoreDataManager shardCoreDataManager] storeDirectory].path);
}

- (BOOL)isLogin
{
    if ([self getUser]!=nil && _token != nil && ![_token isEqualToString:@""]) {
        return YES;
    }else{
        return NO;
    }
}

- (void)initUser:(NSDictionary *)data
{
    
    _id = [data objectForKey:@"id"];
    _userId = [data objectForKey:@"userId"];
    _token = [data objectForKey:@"token"];
    _username = [data objectForKey:@"username"];
    _nickname = [data objectForKey:@"nickname"];
    _avatar = [data objectForKey:@"avatar"];
    _avatarUrl = [data objectForKey:@"avatarUrl"];
    _mobile = [data objectForKey:@"mobile"];
    _sessionId = [data objectForKey:@"sessionId"];

    [self addUser]; //添加用户
}

//添加用户
- (void)addUser
{
    if ([self getUser]!=nil) {
        [self saveUser];
    }else{
        NSManagedObject *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
        [user setValue:_id forKey:@"id"];
        [user setValue:_userId forKey:@"userId"];
        [user setValue:_token forKey:@"token"];
        [user setValue:_username forKey:@"username"];
        [user setValue:_nickname forKey:@"nickname"];
        [user setValue:_avatar forKey:@"avatar"];
        [user setValue:_avatarUrl forKey:@"avatarUrl"];
        [user setValue:_mobile forKey:@"mobile"];
        [user setValue:_sessionId forKey:@"sessionId"];
        NSError *error = nil;
        if ([context save:&error]) {
            NSLog(@"addUser 更新成功");
        }
    }
}

- (NSManagedObject *)getUser
{
    if ([self userCount]>0) {
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:context]];
        NSError *error = nil;
        NSArray *result = [context executeFetchRequest:request error:&error];//这里获取到的是一个数组，你需要取出你要更新的那个obj
        if ([result count]>0) {
            NSManagedObject *user = [result firstObject];
            return user;
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}

//修改用户
- (void)saveUser
{
    NSManagedObject *user = [self getUser];
    if (user != nil){ //存在用户 修改用户信息
        [user setValue:_id forKey:@"id"];
        [user setValue:_userId forKey:@"userId"];
        [user setValue:_token forKey:@"token"];
        [user setValue:_username forKey:@"username"];
        [user setValue:_nickname forKey:@"nickname"];
        [user setValue:_avatar forKey:@"avatar"];
        [user setValue:_avatarUrl forKey:@"avatarUrl"];
        [user setValue:_mobile forKey:@"mobile"];
        [user setValue:_sessionId forKey:@"sessionId"];
        NSError *error = nil;
        if ([context save:&error]) {
            //更新成功
            NSLog(@"updateUser 更新成功");
        }
    }
}

- (void)clearUser
{
    NSManagedObject *user = [self getUser];
    if (user != nil){
        [user setValue:@"" forKey:@"id"];
        [user setValue:@"" forKey:@"userId"];
        [user setValue:@"" forKey:@"token"];
        [user setValue:@"" forKey:@"username"];
        [user setValue:@"" forKey:@"nickname"];
        [user setValue:@"" forKey:@"avatar"];
        [user setValue:@"" forKey:@"avatarUrl"];
        [user setValue:@"" forKey:@"mobile"];
        [user setValue:@"" forKey:@"sessionId"];
        NSError *error = nil;
        if ([context save:&error]) {
            [self initUserData];
            //更新成功
            NSLog(@"updateUser 更新成功");
        }
    }
    
}

//初始化用
- (void)updateUser
{
    NSManagedObject *user = [self getUser];
    if (user!=nil) {
        _id = [user valueForKey:@"id"];
        _userId = [user valueForKey:@"userId"];
        _token = [user valueForKey:@"token"];
        _username = [user valueForKey:@"username"];
        _nickname = [user valueForKey:@"nickname"];
        _avatar = [user valueForKey:@"avatar"];
        _avatarUrl = [user valueForKey:@"avatarUrl"];
        _mobile = [user valueForKey:@"mobile"];
        _sessionId = [user valueForKey:@"sessionId"];
    }
}

- (void)initUserData
{
    _id = @"";
    _userId = @"";
    _token = @"";
    _username = @"";
    _nickname = @"";
    _avatar = @"";
    _avatarUrl = nil;
    _mobile = @"";
    _sessionId = @"";
}

- (NSArray *)fetchUser{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    return [context executeFetchRequest:fetchRequest error:&error];
}

- (NSInteger)userCount
{
    return [self fetchUser].count;
}

- (void)deleteUser:(NSManagedObject *) user {
    if ([self userCount]>0) {
        [context deleteObject:user];
        NSError *error = nil;
        if ([context save:&error]) {
            //更新成功
            NSLog(@"deleteUser 更新成功");
        }
    }
}

- (void)clearAllUser {
    if ([self userCount]>0){
        NSArray *fetchedObjects = [self fetchUser];
        for (NSManagedObject *user in fetchedObjects) {
            [self deleteUser:user];
        }
        NSError *error = nil;
        if ([context save:&error]) {
            //更新成功
            NSLog(@"clearAllUser 更新成功");
        }
    }
}

@end
