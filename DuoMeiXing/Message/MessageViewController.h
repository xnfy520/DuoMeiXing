//
//  MessageViewController.h
//  DuoMeiXing
//
//  Created by 天陨 on 15/8/29.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNABaseViewController.h"

@interface MessageViewController : DNABaseViewController<UITableViewDelegate, UITableViewDataSource>


@property(nonatomic, strong)NSString *listTitle;

@property(nonatomic, assign)NSUInteger listType;

@property(nonatomic, copy)NSString *userinfo;

@property(nonatomic, assign)BOOL isDisplay;

@end
