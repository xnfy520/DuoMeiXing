//
//  MJExtensionConfig.m
//  DuoMeiXing
//
//  Created by 雪念飞叶 on 15/7/30.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "MJExtension.h"
#import "ResponseData.h"

@implementation MJExtensionConfig

+ (void)load
{
    [ResponseMessageData setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"result" : @"ResponseMessageResultData"
                 };
    }];
}

@end
