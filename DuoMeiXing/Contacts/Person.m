//
//  Person.m
//  DuoMeiXing
//
//  Created by 雪念飞叶 on 15/7/9.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize name,username;

-(id)init:(NSString*) _username name:(NSString*) _name {
    self = [super init];
    self.username = _username;
    self.name = _name;
    
    return self;
}

@end
