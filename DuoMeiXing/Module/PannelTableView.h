//
//  PannelTableView.h
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/17.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNADef.h"

@protocol clickCellDelegate

- (void)getCellData:(id)data;

@end

@interface PannelTableView : UIView<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *memberId;

@property (nonatomic, copy) NSString *videoId;

@property (nonatomic, assign) NSInteger cellType;

@property (nonatomic, assign) NSInteger pannelType;

@property (nonatomic, weak) id<clickCellDelegate>delegate;

- (void)setTableScrollEnabled:(BOOL)enabled;

- (void)sendWorksRequest;

- (void)sendCommentsRequest;

@end
