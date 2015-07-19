//
//  LoginViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/19.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "LoginViewController.h"
#import "DNADef.h"
#import "RegisterViewController.h"
#import "DNATabBarController.h"


@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"登录";
    
    [self setNavigationBar];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"open" forState:UIControlStateNormal];
    button.frame = CGRectMake((screenWidth-100)/2, 150, 100, 50);
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(openClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *dismisstype = [[NSUserDefaults standardUserDefaults] objectForKey:@"dismisstype"];
    NSLog(@"%@", dismisstype);
    if (dismisstype!=nil) {
        if ([dismisstype isEqualToString:@"reg"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"dismisstype"];
            [self registerView];
        }
    }
}

- (void)setNavigationBar
{
    
//    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
//    self.navigationItem.leftBarButtonItem = cancelItem;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"登录";
    self.navigationItem.backBarButtonItem = backItem;
    
    UIBarButtonItem *registerItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerView)];
    self.navigationItem.rightBarButtonItem = registerItem;

}

- (void)openClick
{
    
    [self.navigationController presentViewController:[[DNATabBarController alloc] init] animated:YES completion:^{
    }];
    
}

- (void)cancelAction
{
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
        
    }];
}

- (void)registerView
{
    [self.navigationController pushViewController:[[RegisterViewController alloc] init] animated:YES];
}

@end
