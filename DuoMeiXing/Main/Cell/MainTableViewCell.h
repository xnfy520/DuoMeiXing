//
//  MainTableViewCell.h
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/5.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewCell : UITableViewCell

@property(nonatomic, retain) UIImageView *avatarImageView;
@property(nonatomic, retain) UILabel *avatarBadgeLabel;
@property(nonatomic, retain) UILabel *avatarDateLabel;
@property(nonatomic, retain) UILabel *avatarTitleLabel;
@property(nonatomic, retain) UILabel *avatarMessageLabel;
@property(nonatomic, assign) BOOL showBadge;
@property(nonatomic, assign) BOOL isDetails;

@end
