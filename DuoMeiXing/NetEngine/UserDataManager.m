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
    NSManagedObject *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    [user setValue:[data objectForKey:@"id"] forKey:@"id"];
    [user setValue:[data objectForKey:@"userId"] forKey:@"userId"];
    [user setValue:[data objectForKey:@"token"] forKey:@"token"];
    [user setValue:[data objectForKey:@"username"] forKey:@"username"];
    [user setValue:[data objectForKey:@"nickname"] forKey:@"nickname"];
    [user setValue:[data objectForKey:@"avatar"] forKey:@"avatar"];
    [user setValue:[data objectForKey:@"avatarUrl"] forKey:@"avatarUrl"];
    [user setValue:[data objectForKey:@"mobile"] forKey:@"mobile"];
    NSError *error = nil;
    if ([context save:&error]) {
        //更新成功
        NSLog(@"更新成功");
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

- (NSArray *)getUserWithId:(NSString *)id
{
    
    NSPredicate *predicate = [NSPredicate
                              predicateWithFormat:@"id == %@",id];
    
    //首先你需要建立一个request
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:context]];
    [request setPredicate:predicate];//这里相当于sqlite中的查询条件，具体格式参考苹果文档
    //https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/Predicates/Articles/pCreating.html
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:request error:&error];//这里获取到的是一个数组，你需要取出你要更新的那个obj
    return result;
}

-(BOOL) isNotEmpty
{
    if ([self fetchUser].count > 0) {
        return YES;
    }else{
        return NO;
    }
}

-(NSInteger) userCount
{
    return [self fetchUser].count;
}

-(void)deleteUser:(NSManagedObject *) user {
    [context deleteObject:user];
    NSError *error = nil;
    if ([context save:&error]) {
        //更新成功
        NSLog(@"更新成功");
    }
}

-(void)clearAllUser {
    NSArray *fetchedObjects = [self fetchUser];
    
    for (NSManagedObject *user in fetchedObjects) {
        [self deleteUser:user];
    }
    
    NSError *error = nil;
    if ([context save:&error]) {
        //更新成功
        NSLog(@"更新成功");
    }
}

- (BOOL)hasChange
{
    if ([context hasChanges]) {
        return YES;
    }else{
        return NO;
    }
}

@end
