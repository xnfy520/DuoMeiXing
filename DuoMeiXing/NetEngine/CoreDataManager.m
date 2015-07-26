//
//  CoreDataManager.m
//  xxy
//
//  Created by 雪念飞叶 on 14-9-20.
//  Copyright (c) 2014年 雪念飞叶. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

@synthesize moc, model, coordinator;


-(void) saveContext
{
    NSError *error = nil;
    if (self.moc != nil) {
        if ([moc hasChanges] && ![moc save:&error]) {
            NSLog(@"error %@: %@", error, [error userInfo]);
            abort();
        }
    }
}

-(NSURL *) storeDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(NSManagedObjectContext *) moc
{
    if (moc != nil) {
        return moc;
    }
    if (self.coordinator != nil) {
        moc = [[NSManagedObjectContext alloc] init];
        [moc setPersistentStoreCoordinator:coordinator];
    }
    return moc;
}

-(NSManagedObjectModel *) model
{
    if (model != nil) {
        return model;
    }
    NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:@"dalmatian" withExtension:@"momd"];
    model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
    return model;
}

-(NSPersistentStoreCoordinator *) coordinator
{
    if (coordinator != nil) {
        return coordinator;
    }
    NSURL *storeUrl = [[self storeDirectory] URLByAppendingPathComponent:@"dalmatian.sqlite"];
    NSError *error = nil;
    coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self model]];
    if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
        NSLog(@"error %@: %@", error, [error userInfo]);
        abort();
    }
    return coordinator;
}

+(CoreDataManager *) shardCoreDataManager
{
    static dispatch_once_t pred;
    static CoreDataManager *_sharedInstance;
    dispatch_once(&pred, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}





@end
