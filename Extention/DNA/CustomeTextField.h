//
//  CustomeTextField.h
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/19.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DoneActionBlock)(id);

@interface CustomeTextField : UITextField

@property(nonatomic,retain) UIButton* doneButton;
@property(nonatomic,retain) NSString* buttonTitle;
@property(nonatomic,copy) DoneActionBlock doneEven;

@end
