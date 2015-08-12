//
//  ListCell.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/6.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "ListCell.h"

#define TitleFontSize 14
#define DetailFontSize 12
#define DateFontSize 11
#define BadgeFontSize 8

#define BadgeBgColor [UIColor redColor];

@implementation ListCell
{
    CGFloat imageWidth;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCellImageView];
        [self setupCellBadgeLabel];
        [self setupCellDateLabel];
        [self setupCellTitleLabel];
        [self setupCellDetailsLabel];
    }
    return self;
}

- (void)setupCellImageView
{
    _cellImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_cellImageView];
}

- (void)setupCellBadgeLabel
{
    _cellBadgeLabel = [[UILabel alloc] init];
    _cellBadgeLabel.backgroundColor = BadgeBgColor;
    _cellBadgeLabel.layer.masksToBounds = YES;
    _cellBadgeLabel.layer.cornerRadius = 7;
    _cellBadgeLabel.textAlignment = NSTextAlignmentCenter;
    _cellBadgeLabel.font = [UIFont boldSystemFontOfSize:BadgeFontSize];
    _cellBadgeLabel.textColor = [UIColor whiteColor];
    _cellBadgeLabel.hidden = YES;
    [_cellImageView addSubview:_cellBadgeLabel];
}

- (void)setupCellDateLabel
{
    _cellDateLabel = [[UILabel alloc] init];
    _cellDateLabel.font = [UIFont systemFontOfSize:DateFontSize];
    _cellDateLabel.textColor = [UIColor lightGrayColor];
    _cellDateLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_cellDateLabel];
}

- (void)setupCellTitleLabel
{
    _cellTitleLabel = [[UILabel alloc] init];
    _cellTitleLabel.font = [UIFont systemFontOfSize:TitleFontSize];
//    _avatarTitleLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_cellTitleLabel];
}

- (void)setupCellDetailsLabel
{
    _cellDetailLabel = [[UILabel alloc] init];
    _cellDetailLabel.font = [UIFont systemFontOfSize:DetailFontSize];
    _cellDetailLabel.textColor = [UIColor lightGrayColor];
    _cellDetailLabel.numberOfLines = 0;
//    _avatarMessageLabel.backgroundColor = [UIColor magentaColor];
    [self.contentView addSubview:_cellDetailLabel];
}

- (void)setCellData:(id)cellData
{
    if (self.cellListType == kCellListComment) {
        ResponseVideoComment *data = (ResponseVideoComment *)cellData;
        NSLog(@"%@", [data JSONObject]);
        _cellTitleLabel.text = data.nickName;
        _cellDetailLabel.text = data.content;
        [_cellImageView sd_setImageWithURL:data.logoUrl];
        _cellDateLabel.text = [DisplayUtil getDateStringWithDate:data.createTime];
        
    }else if(self.cellListType == kCellListVideo){
        ResponseVideoResult *data = (ResponseVideoResult *)cellData;
        _cellTitleLabel.text = data.name;
        _cellDetailLabel.text = data.desc;
        [_cellImageView sd_setImageWithURL:data.picUrl];
        _cellDateLabel.text = [DisplayUtil getDateStringWithDate:data.createTime];
    }
    [self sslayoutSubviews];
}

- (void)sslayoutSubviews
{
//    [super layoutSubviews];

    if (self.cellListType == kCellListMessage) {
        _cellBadgeLabel.hidden = NO;
    }else if(self.cellListType == kCellListVideo){
        imageWidth = listCellImageWith;
    }
    
    CGFloat pointY = (listCellHeight - (listCellHeight - 15)) / 2;
    
    _cellImageView.frame = CGRectMake(10, pointY, imageWidth>0 ? imageWidth : listCellHeight-15, listCellHeight - 15);
    
    _cellBadgeLabel.frame = CGRectMake(CGRectGetWidth(_cellImageView.frame)-9, -5, 14, 14);

    _cellTitleLabel.frame = CGRectMake(
                                       CGRectGetWidth(_cellImageView.frame) + 20,
                                       listCellHeight/2 - 16,
                                       (CGRectGetWidth(self.frame)-CGRectGetMaxX(_cellImageView.frame) - 50 -30),
                                       TitleFontSize);
    
    _cellDateLabel.frame = CGRectMake(CGRectGetWidth(self.frame) - 50 - 10, CGRectGetMinY(_cellTitleLabel.frame), 50, DateFontSize);

    if (self.cellListType == kCellListComment) {
        CGFloat textX = CGRectGetMinX(_cellTitleLabel.frame);
        
        CGFloat textY = listCellHeight/2+2;
        
        CGFloat textWidth = CGRectGetWidth(self.frame) - CGRectGetWidth(_cellImageView.frame) - 30;
        
        CGSize textSize = [_cellDetailLabel.text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:DetailFontSize]} context:nil].size;
        
        CGRect textRect = CGRectMake(textX, textY, textSize.width, textSize.height);
        
        _cellDetailLabel.frame=textRect;
        
        _height=CGRectGetMaxY(_cellDetailLabel.frame)+10;
        
        if (_height<listCellHeight) {
            _height = listCellHeight;
        }
        
    }else if(self.cellListType == kCellListVideo){
        _cellDetailLabel.numberOfLines = 1;
            _cellDetailLabel.frame = CGRectMake(CGRectGetWidth(_cellImageView.frame) + 20, listCellHeight/2 + 4, CGRectGetWidth(self.frame) - CGRectGetWidth(_cellImageView.frame) - 30, DetailFontSize);
        _height = listCellHeight;
    }
    

    

    
    NSLog(@"%f", _height);
//    _cellDetailLabel.frame = CGRectMake(CGRectGetWidth(_cellImageView.frame) + 20, CGRectGetHeight(self.frame)/2 + 4, CGRectGetWidth(self.frame) - CGRectGetWidth(_cellImageView.frame) - 30, DetailFontSize);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected){
        _cellBadgeLabel.backgroundColor = BadgeBgColor;
    }
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted){
        _cellBadgeLabel.backgroundColor = BadgeBgColor;
    }
}

@end
