//
//  RequstData.m
//  DuoMeiXing
//
//  Created by 雪念飞叶 on 15/7/30.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "RequstData.h"
#import "UserDataManager.h"

@implementation RequstData
-(id)init
{
    if (self = [super init]) {
        self.token = [UserDataManager sharedUserDataManager].token;
    }
    return self;
}
@end

@implementation RequstPage

@end

@implementation RequestLogin

@end