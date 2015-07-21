//
//  SubmitButton.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/21.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "SubmitButton.h"
#import "DNADef.h"

@implementation SubmitButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect )frame withTitle:(NSString *)title withBackgroundColor:(UIColor *)bgcolor
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [self setBackgroundColor:bgcolor];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [self.layer setCornerRadius:5];
    }
    return self;
}

@end
