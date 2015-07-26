//
//  UserDataManager.h
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/26.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface UserDataManager : NSObject{
    NSManagedObjectContext *context;
}

-(void) commitChanges;

//Create
-(void) initUser:(NSDictionary *)data;

//Selection
-(NSArray *)fetchUser;

-(BOOL) isNotEmpty;

-(NSInteger) userCount;

- (NSArray *)getUserWithId:(NSString *)id;

-(void)deleteUser:(NSManagedObject *) user;

-(void)clearAllUser;

- (BOOL)hasChange;

@end
