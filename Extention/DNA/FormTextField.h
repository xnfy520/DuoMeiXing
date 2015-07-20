//
//  FormTextField.h
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/21.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormTextField : UITextField

- (id)initWithFrame:(CGRect )frame withTitle:(NSString *)title withPlaceholder:(NSString *)placeholder withLeftViewWidth:(CGFloat)width;

@end
