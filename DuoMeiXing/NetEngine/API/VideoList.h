//
//  VideoList.h
//  DuoMeiXing
//
//  Created by 雪念飞叶 on 15/7/29.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "YTKRequest.h"

@interface VideoList : YTKRequest

- (id)initWithAction:(NSString *)action withType:(NSString *)type PageNo:(NSString *)pageNo pageSize:(NSString *)pageSize;

@end
