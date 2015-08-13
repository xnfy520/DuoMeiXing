//
//  DisplayViewController.h
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/16.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNABaseViewController.h"
#import "DNADef.h"

@interface DisplayViewController : DNABaseViewController<UIScrollViewDelegate, UITextFieldDelegate>

@property (nonatomic, assign) BOOL haveViedo;

@property (nonatomic, strong) NSString *videoId;

@property (nonatomic, strong) ResponseVideo *videoData;

@property (nonatomic, assign) NSInteger pannelIndex;

@end
