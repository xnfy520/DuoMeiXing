//
//  AccountAvatarCell.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/6.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "AccountAvatarCell.h"

#define TitleFontSize 16
#define PhoneFontSize 13

@implementation AccountAvatarCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        float height = 66;
        
        _cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (height - (height - 20))/2, height - 20, height - 20)];
        [self.contentView addSubview:self.cellImageView];
        
        _cellTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_cellImageView.frame)+30, CGRectGetMinY(_cellImageView.frame)+1, CGRectGetWidth(self.frame)/2, TitleFontSize)];
        [self.contentView addSubview:_cellTitleLabel];
        
        _cellPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_cellTitleLabel.frame), CGRectGetMaxY(_cellImageView.frame)-11, CGRectGetWidth(self.frame) - CGRectGetWidth(_cellImageView.frame) + 10, 10)];
        _cellPhoneLabel.font = [UIFont systemFontOfSize:PhoneFontSize];
        _cellPhoneLabel.textColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
        [self.contentView addSubview:_cellPhoneLabel];
        
    }
    return self;
}

@end
