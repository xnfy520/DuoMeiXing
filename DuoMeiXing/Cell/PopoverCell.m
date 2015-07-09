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

    CGRect imageViewFrame = self.imageView.frame;
    imageViewFrame.origin.x = 10;
//    imageViewFrame.origin.y = 7;
    self.imageView.frame = imageViewFrame;
    
    
    CGRect textFrame = self.textLabel.frame;
    textFrame.origin.x = CGRectGetMaxX(self.imageView.frame)+10;
    textFrame.size.width = CGRectGetWidth(self.frame)-CGRectGetMaxX(self.imageView.frame);
    self.textLabel.frame = textFrame;
    
}

@end
