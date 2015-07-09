//
//  Person.h
//  DuoMeiXing
//
//  Created by 雪念飞叶 on 15/7/9.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

-(id)init:(NSString*) _username name:(NSString*) _name;
@property (assign, readwrite, nonatomic) NSString *name;
@property (assign, readwrite, nonatomic) NSString *username;

@end
