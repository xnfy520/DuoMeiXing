//
//  ListCell.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/6.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupAvatarImageView];
        [self setupAvatarBadgeLabel];
        [self setupAvatarDateLabel];
        [self setupAvatarTitleLabel];
        [self setupAvatarMessageLabel];
    }
    return self;
}

- (void)setupAvatarImageView
{
    _avatarImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_avatarImageView];
}

- (void)setupAvatarBadgeLabel
{
    _avatarBadgeLabel = [[UILabel alloc] init];
    _avatarBadgeLabel.backgroundColor = [UIColor redColor];
    _avatarBadgeLabel.layer.masksToBounds = YES;
    _avatarBadgeLabel.layer.cornerRadius = 7;
    _avatarBadgeLabel.textAlignment = NSTextAlignmentCenter;
    _avatarBadgeLabel.font = [UIFont systemFontOfSize:8];
    _avatarBadgeLabel.textColor = [UIColor whiteColor];
    [_avatarImageView addSubview:_avatarBadgeLabel];
}

- (void)setupAvatarDateLabel
{
    _avatarDateLabel = [[UILabel alloc] init];
    _avatarDateLabel.font = [UIFont systemFontOfSize:11];
    _avatarDateLabel.textColor = [UIColor lightGrayColor] ;
    _avatarDateLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_avatarDateLabel];
}

- (void)setupAvatarTitleLabel
{
    _avatarTitleLabel = [[UILabel alloc] init];
    _avatarTitleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_avatarTitleLabel];
}

- (void)setupAvatarMessageLabel
{
    _avatarMessageLabel = [[UILabel alloc] init];
    _avatarMessageLabel.font = [UIFont systemFontOfSize:12];
    _avatarMessageLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_avatarMessageLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _avatarBadgeLabel.hidden = !_showBadge;
    
    _avatarImageView.frame = CGRectMake(5, (CGRectGetHeight(self.frame) - (CGRectGetHeight(self.frame) - 10)) / 2, self.imageWidth>0 ? self.imageWidth : CGRectGetHeight(self.frame)-10, CGRectGetHeight(self.frame) - 10);
    
    _avatarBadgeLabel.frame = CGRectMake(CGRectGetWidth(_avatarImageView.frame)-11, -3, 14, 14);
    
    _avatarDateLabel.frame = CGRectMake(CGRectGetWidth(self.frame) - CGRectGetWidth(self.frame) / 3 - 5, 7, CGRectGetWidth(self.frame) / 3, 10);
    
    _avatarTitleLabel.frame = CGRectMake(CGRectGetWidth(_avatarImageView.frame) + 10, CGRectGetMinX(_avatarImageView.frame) + CGRectGetHeight(_avatarBadgeLabel.frame) / 2, CGRectGetWidth(self.frame) / 2, 14);
    
    _avatarMessageLabel.frame = CGRectMake(CGRectGetWidth(_avatarImageView.frame) + 10, CGRectGetMaxY(_avatarImageView.frame) - 13, CGRectGetWidth(self.frame) - CGRectGetWidth(_avatarImageView.frame) + 10, 12);
}

@end
