//
//  ListCell.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/6.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "ListCell.h"
#import "DNADef.h"

#define TitleFontSize 14
#define DetailFontSize 12
#define DateFontSize 11
#define BadgeFontSize 8

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
    _cellImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_cellImageView];
}

- (void)setupAvatarBadgeLabel
{
    _cellBadgeLabel = [[UILabel alloc] init];
    _cellBadgeLabel.backgroundColor = [UIColor redColor];
    _cellBadgeLabel.layer.masksToBounds = YES;
    _cellBadgeLabel.layer.cornerRadius = 7;
    _cellBadgeLabel.textAlignment = NSTextAlignmentCenter;
    _cellBadgeLabel.font = [UIFont systemFontOfSize:BadgeFontSize];
    _cellBadgeLabel.textColor = [UIColor whiteColor];
    [_cellImageView addSubview:_cellBadgeLabel];
}

- (void)setupAvatarDateLabel
{
    _cellDateLabel = [[UILabel alloc] init];
    _cellDateLabel.font = [UIFont systemFontOfSize:DateFontSize];
    _cellDateLabel.textColor = [UIColor lightGrayColor] ;
    _cellDateLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_cellDateLabel];
}

- (void)setupAvatarTitleLabel
{
    _cellTitleLabel = [[UILabel alloc] init];
    _cellTitleLabel.font = [UIFont systemFontOfSize:TitleFontSize];
//    _avatarTitleLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_cellTitleLabel];
}

- (void)setupAvatarMessageLabel
{
    _cellDetailLabel = [[UILabel alloc] init];
    _cellDetailLabel.font = [UIFont systemFontOfSize:DetailFontSize];
    _cellDetailLabel.textColor = [UIColor lightGrayColor];
//    _avatarMessageLabel.backgroundColor = [UIColor magentaColor];
    [self.contentView addSubview:_cellDetailLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _cellBadgeLabel.hidden = !_showBadge;
    
    CGFloat pointY = (CGRectGetHeight(self.frame) - (CGRectGetHeight(self.frame) - 10)) / 2;
    
    _cellImageView.frame = CGRectMake(5, pointY, self.imageWidth>0 ? self.imageWidth : CGRectGetHeight(self.frame)-10, CGRectGetHeight(self.frame) - 10);
    
    _cellBadgeLabel.frame = CGRectMake(CGRectGetWidth(_cellImageView.frame)-11, -3, 14, 14);

    _cellTitleLabel.frame = CGRectMake(CGRectGetWidth(_cellImageView.frame) + 10, CGRectGetHeight(self.frame)/2 - [DisplayUtil getSize:12 withString:_cellTitleLabel.text].height, (CGRectGetWidth(self.frame)-CGRectGetWidth(_cellImageView.frame)) / 2, TitleFontSize);

    _cellDetailLabel.frame = CGRectMake(CGRectGetWidth(_cellImageView.frame) + 10, CGRectGetHeight(self.frame)/2 + 4, CGRectGetWidth(self.frame) - CGRectGetWidth(_cellImageView.frame) - 15, DetailFontSize);
    
    _cellDateLabel.frame = CGRectMake(CGRectGetWidth(self.frame) - CGRectGetWidth(self.frame) / 3 - 5, CGRectGetMinY(_cellTitleLabel.frame), CGRectGetWidth(self.frame) / 3, DateFontSize);
    
}

@end
