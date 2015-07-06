//
//  MineTableViewCell.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/6.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "MineTableViewCell.h"

@implementation MineTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        float height = 66;
        
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (height - (height - 20))/2, height - 20, height - 20)];
        [self.contentView addSubview:self.avatarImageView];
        
        _avatarTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_avatarImageView.frame)+30, CGRectGetMinY(_avatarImageView.frame)+1, CGRectGetWidth(self.frame)/2, 16)];
        [self.contentView addSubview:_avatarTitleLabel];
        
        _avatarPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_avatarTitleLabel.frame), CGRectGetMaxY(_avatarImageView.frame)-11, CGRectGetWidth(self.frame) - CGRectGetWidth(_avatarImageView.frame) + 10, 10)];
        _avatarPhoneLabel.font = [UIFont systemFontOfSize:13];
        _avatarPhoneLabel.textColor = [UIColor magentaColor];
        [self.contentView addSubview:_avatarPhoneLabel];
        
    }
    return self;
}

@end
