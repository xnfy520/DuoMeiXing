//
//  DNABadgeButton.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/6/18.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "DNABadgeButton.h"

@implementation DNABadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    if (badgeValue) {
        self.hidden = NO;
        // 设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        // 设置frame
        CGRect frame = self.frame;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (badgeValue.length > 1) {
            NSDictionary *attributes = @{NSFontAttributeName: self.titleLabel.font};
            
            CGSize size = [badgeValue sizeWithAttributes:attributes];
            badgeW = size.width + 10;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
    }else {
        self.hidden = YES;
    }
}

@end
