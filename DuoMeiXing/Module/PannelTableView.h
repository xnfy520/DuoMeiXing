//
//  PannelTableView.h
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/17.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PannelTableView : UIView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *identifier;

- (void)setTableScrollEnabled:(BOOL)enabled;

@end
