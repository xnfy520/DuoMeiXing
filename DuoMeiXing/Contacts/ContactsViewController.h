//
//  ContactsViewController.h
//  DuoMeiXing
//
//  Created by 天陨 on 15/6/17.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNABaseViewController.h"

@interface ContactsViewController : DNABaseViewController

@property(nonatomic, assign)BOOL notHeader;
@property(nonatomic, assign)BOOL notSearchBar;
@property(nonatomic, assign)BOOL notPopover;
@property(nonatomic, assign)BOOL hasInvitation;
@property(nonatomic, assign)BOOL notSelection;
@property(nonatomic, assign)NSUInteger listType;

@end
