//
//  MainTableViewCell.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/5.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "MainTableViewCell.h"
#import "UIView+FrameMethods.h"

@implementation MainTableViewCell
{
    float height;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        height = 50;//CGRectGetHeight(self.frame);
        NSLog(@"%f", height);
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, (height - (height - 10))/2, height - 10, height - 10)];
        [self.contentView addSubview:self.avatarImageView];

        _avatarBadgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_avatarImageView.frame)-11, -3, 14, 14)];
        _avatarBadgeLabel.backgroundColor = [UIColor redColor];
        _avatarBadgeLabel.layer.masksToBounds = YES;
        _avatarBadgeLabel.layer.cornerRadius = 7;
        _avatarBadgeLabel.textAlignment = NSTextAlignmentCenter;
        _avatarBadgeLabel.font = [UIFont systemFontOfSize:8];
        _avatarBadgeLabel.textColor = [UIColor whiteColor];
        [_avatarImageView addSubview:_avatarBadgeLabel];
        
        _avatarDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - CGRectGetWidth(self.frame)/3 - 5, 5, CGRectGetWidth(self.frame)/3, 10)];
        _avatarDateLabel.font = [UIFont systemFontOfSize:11];
        _avatarDateLabel.textColor = [UIColor lightGrayColor] ;
        _avatarDateLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_avatarDateLabel];
        
        _avatarTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_avatarImageView.frame)+10, CGRectGetMinX(_avatarImageView.frame)+CGRectGetHeight(_avatarBadgeLabel.frame)/2, CGRectGetWidth(self.frame)/2, 14)];
        _avatarTitleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_avatarTitleLabel];
        
        _avatarMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_avatarImageView.frame)+10, CGRectGetMaxY(_avatarImageView.frame)-13, CGRectGetWidth(self.frame) - CGRectGetWidth(_avatarImageView.frame) + 10, 12)];
        _avatarMessageLabel.font = [UIFont systemFontOfSize:12];
        _avatarMessageLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_avatarMessageLabel];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _avatarBadgeLabel.hidden = !_showBadge;
    
}

@end
