//
//  MessageApi.h
//  DuoMeiXing
//
//  Created by 雪念飞叶 on 15/7/28.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "YTKRequest.h"

@interface MessageApi : YTKRequest

- (id)initWithPageNo:(NSString *)pageNo pageSize:(NSString *)pageSize;

@end
