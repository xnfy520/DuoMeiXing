//
//  DNATabBar.h
//  DuoMeiXing
//
//  Created by 天陨 on 15/6/18.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DNATabBar;
@protocol DNATabBarDekegate <NSObject>

@optional
- (void)tabBar:(DNATabBar *)tabBar didSelectedButtonfrom:(NSInteger)from to:(NSInteger)to;
@end

@interface DNATabBar : UIView


@property (nonatomic, weak) id<DNATabBarDekegate>delegate;

- (void)addButtonWithItem:(UITabBarItem *)item;

@end
