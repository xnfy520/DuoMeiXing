//
//  FormTextField.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/21.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "FormTextField.h"

@implementation FormTextField
{
    UILabel *leftLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect )frame withTitle:(NSString *)title withPlaceholder:(NSString *)placeholder withLeftViewWidth:(CGFloat)width
{
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholder = placeholder;
        self.font = [UIFont systemFontOfSize:16];
        self.borderStyle = UITextBorderStyleRoundedRect;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, CGRectGetHeight(frame)-10)];
        leftLabel.textAlignment = NSTextAlignmentLeft;
        leftLabel.text = title;
        leftLabel.font = [UIFont systemFontOfSize:16];
        self.leftView = leftLabel;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect leftRect = [super leftViewRectForBounds:bounds];
    leftRect.origin.x += 10;// 右偏10
    return leftRect;
}

@end
