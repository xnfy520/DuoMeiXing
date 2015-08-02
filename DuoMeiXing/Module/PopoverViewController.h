//
//  PopoverViewController.h
//  DuoMeiXing
//
//  Created by 雪念飞叶 on 15/7/7.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNABaseViewController.h"

@protocol popoverClickDelegate <NSObject>

- (void)getPopoverClickType:(NSUInteger) type;

@end

@interface PopoverViewController : DNABaseViewController

@property (nonatomic, weak)id<popoverClickDelegate>delegate;

@end
