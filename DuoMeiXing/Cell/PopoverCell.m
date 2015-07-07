//
//  PopoverCell.m
//  DuoMeiXing
//
//  Created by 雪念飞叶 on 15/7/7.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "PopoverCell.h"

@implementation PopoverCell

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGRect tmpFrame = self.imageView.frame;
    tmpFrame.origin.x = 10;
    self.imageView.frame = tmpFrame;
    
    CGRect tmpTextFrame = self.textLabel.frame;
    tmpTextFrame.origin.x = CGRectGetMaxX(self.imageView.frame)+10;
    tmpTextFrame.size.width = CGRectGetWidth(self.frame)-CGRectGetMaxX(self.imageView.frame);
    self.textLabel.frame = tmpTextFrame;
    
}

@end
