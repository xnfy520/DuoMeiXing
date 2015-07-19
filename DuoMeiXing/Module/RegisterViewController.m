//
//  RegisterViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/19.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "RegisterViewController.h"
#import "DNADef.h"

@implementation RegisterViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"注册";
    
    [self setNavigationBar];
}

- (void)setNavigationBar
{
    
//    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
//    self.navigationItem.leftBarButtonItem = cancelItem;
    
//    UIBarButtonItem *loginItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(loginView)];
//    self.navigationItem.rightBarButtonItem = loginItem;
    
}

//- (void)cancelAction
//{
//    [self.navigationController dismissViewControllerAnimated:NO completion:^{
//        
//    }];
//}

//- (void)loginView
//{
//    [self.navigationController dismissViewControllerAnimated:NO completion:^{
//        postEvent(globalLoginView);
//    }];
//}

@end
