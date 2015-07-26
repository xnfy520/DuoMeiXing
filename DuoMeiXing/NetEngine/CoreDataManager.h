//
//  CoreDataManager.h
//  xxy
//
//  Created by 雪念飞叶 on 14-9-20.
//  Copyright (c) 2014年 雪念飞叶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

@property (nonatomic, readonly) NSManagedObjectContext *moc;
@property (nonatomic, readonly) NSManagedObjectModel *model;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *coordinator;

+(CoreDataManager *) shardCoreDataManager;

-(void) saveContext;

-(NSURL *) storeDirectory;

@end
