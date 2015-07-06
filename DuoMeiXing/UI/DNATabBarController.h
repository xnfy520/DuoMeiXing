//
//  DNATabBarController.h
//  DuoMeiXing
//
//  Created by 天陨 on 15/6/18.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNATabBar.h"
#import "DNANavigationViewController.h"

#import "MainViewController.h"
#import "ContactsViewController.h"
#import "DiscoverViewController.h"
#import "MineViewController.h"

@interface DNATabBarController : UITabBarController<DNATabBarDekegate, UITabBarControllerDelegate>

@property (nonatomic, weak) DNATabBar *customTabBar;
@property (nonatomic, weak) MainViewController * main;

+ (DNANavigationViewController *)setCtrl:(UIViewController *)ctrl;

@end
