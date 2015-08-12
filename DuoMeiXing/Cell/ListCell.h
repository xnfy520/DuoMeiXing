//
//  ListCell.h
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/6.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNADef.h"

@interface ListCell : UITableViewCell

@property(nonatomic, retain) UIImageView *cellImageView;
@property(nonatomic, retain) UILabel *cellBadgeLabel;
@property(nonatomic, retain) UILabel *cellDateLabel;
@property(nonatomic, retain) UILabel *cellTitleLabel;
@property(nonatomic, retain) UILabel *cellDetailLabel;
@property(nonatomic, assign) CellListType cellListType;

@property (nonatomic, assign) id cellData;

@property(nonatomic, assign) CGFloat height;

@end
