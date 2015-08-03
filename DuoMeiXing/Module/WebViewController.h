//
//  WebViewController.h
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/6.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNABaseViewController.h"
#import "DNADef.h"
#import "Singleton.h"

@interface WebViewController : DNABaseViewController<UIWebViewDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

SINGLETON_INTERFACE(WebViewController);

+(void)showWebPageInViewCtrl:(UIViewController*)ctrl withUrl:(NSString*)url withPostData:(NSDictionary*)postDict;
+(void)showWebPageInViewCtrl:(UIViewController*)ctrl withUrl:(NSString*)url withPostData:(NSDictionary*)postDict withViewTitle:(NSString*)title;

-(void)openPage:(UIViewController*)ctrl withUrl:(NSString*)url withPostData:(NSDictionary*)postDict withViewTitle:(NSString*)title;


@end
