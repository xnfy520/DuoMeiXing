//
//  UserDataManager.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/26.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "UserDataManager.h"
#import "CoreDataManager.h"

@implementation UserDataManager

SINGLETON_IMPLEMENTATION(UserDataManager);

-(id) init
{
    if (self = [super init]) {
        context = [[CoreDataManager shardCoreDataManager] moc];
        [self printPathToStore];
    }
    return self;
}

-(void) printPathToStore
{
    NSLog(@"%@", [[CoreDataManager shardCoreDataManager] storeDirectory].path);
}

-(void) commitChanges
{
    [[CoreDataManager shardCoreDataManager] saveContext];
}

-(void) initUser:(NSDictionary *)data
{

    _id = [data objectForKey:@"id"];
    _userId = [data objectForKey:@"userId"];
    _token = [data objectForKey:@"token"];
    _username = [data objectForKey:@"username"];
    _nickname = [data objectForKey:@"nickname"];
    _avatar = [data objectForKey:@"avatar"];
    _avatarUrl = [data objectForKey:@"avatarUrl"];
    _mobile = [data objectForKey:@"mobile"];
    
    [self addUser]; //添加用户

}

//添加用户
- (void)addUser
{
    if ([self userCount] > 0){
        [self clearAllUser];
    }
    
    NSManagedObject *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];

    [user setValue:_id forKey:@"id"];
    [user setValue:_userId forKey:@"userId"];
    [user setValue:_token forKey:@"token"];
    [user setValue:_username forKey:@"username"];
    [user setValue:_nickname forKey:@"nickname"];
    [user setValue:_avatar forKey:@"avatar"];
    [user setValue:_avatarUrl forKey:@"avatarUrl"];
    [user setValue:_mobile forKey:@"mobile"];
    
    NSError *error = nil;
    if ([context save:&error]) {
        //更新成功
        
        
        
        NSLog(@"%@", context);
        
        NSLog(@"addUser 更新成功");
    }

    NSLog(@"%@",[user valueForKey:@"pk"]);
}

//修改用户
- (void)updateUser
{
    NSError *error = nil;
    
//    NSArray *fetchedObjects = [self fetchUser];
    
    NSManagedObject *user = [self getCurrentUser];
    
    if (user != nil){ //存在用户 修改用户信息
        //    for (NSManagedObject *user in fetchedObjects) {
        [user setValue:_id forKey:@"id"];
        [user setValue:_token forKey:@"token"];
        [user setValue:_username forKey:@"username"];
        [user setValue:_nickname forKey:@"nickname"];
        [user setValue:_avatar forKey:@"avatar"];
        [user setValue:_avatarUrl forKey:@"avatarUrl"];
        [user setValue:_mobile forKey:@"mobile"];
        //    }
        
        if ([context save:&error]) {
            //更新成功
            NSLog(@"updateUser 更新成功");
        }
        
    }
    

}

-(NSArray *) fetchUser{
    
    // construct a fetch request
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // return the result of executing the fetch request
    return [context executeFetchRequest:fetchRequest error:&error];
}

- (NSManagedObject *)getCurrentUser
{
    if ([self userCount]>0 && _token != nil) {
        NSPredicate *predicate = [NSPredicate
                                  predicateWithFormat:@"token == %@",_token];
        //首先你需要建立一个request
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:context]];
        [request setPredicate:predicate];//这里相当于sqlite中的查询条件，具体格式参考苹果文档
        //https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/Predicates/Articles/pCreating.html
        NSError *error = nil;
        NSArray *result = [context executeFetchRequest:request error:&error];//这里获取到的是一个数组，你需要取出你要更新的那个obj
        return [result firstObject];
    }else{
        return nil;
    }
}

-(BOOL) isLogin
{
    if ([self fetchUser].count > 0 && _token!=nil) {
        return YES;
    }else{
        if (_token == nil) {
            [self clearAllUser];
        }
        return NO;
    }
}

-(NSInteger) userCount
{
    return [self fetchUser].count;
}

-(void)deleteUser:(NSManagedObject *) user {
    
    if ([self userCount]>0) {
        
        [context deleteObject:user];
        
        NSError *error = nil;
        
        if ([context save:&error]) {
            //更新成功
            NSLog(@"deleteUser 更新成功");
        }
        
    }
    

}

-(void)clearAllUser {
    
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
