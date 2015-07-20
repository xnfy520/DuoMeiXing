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
#import "SubmitButton.h"
#import "FormTextField.h"


@implementation LoginViewController
{
    UITextField *firstResponderField;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"登录";
    
    [self setNavigationBar];
    
    [self setViewRectEdge];
    NSLog(@"%f", formFieldPadding);
    FormTextField *accountField = [[FormTextField alloc] initWithFrame:CGRectMake(formFieldPadding, 20, formFieldWith, 40) withTitle:@"帐号" withPlaceholder:@"手机号码/用户名/邮箱" withLeftViewWidth:50];
    accountField.delegate = self;
    [self.view addSubview:accountField];
    
    FormTextField *passwordField = [[FormTextField alloc] initWithFrame:CGRectMake(formFieldPadding, CGRectGetMaxY(accountField.frame)+20, formFieldWith, 40) withTitle:@"密码" withPlaceholder:@"密码" withLeftViewWidth:50];
    passwordField.delegate = self;
    passwordField.secureTextEntry = YES;
    [self.view addSubview:passwordField];
    
    SubmitButton *loginButton = [[SubmitButton alloc] initWithFrame:CGRectMake(submitButtonPadding, CGRectGetMaxY(passwordField.frame)+20, submitButtonWith, 40) withTitle:@"登录" withTitleColor:[UIColor whiteColor] withBackgroundColor:defaultTabBarTitleColor];
    [loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];

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
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"登录";
    self.navigationItem.backBarButtonItem = backItem;
    
    UIBarButtonItem *registerItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerView)];
    self.navigationItem.rightBarButtonItem = registerItem;

}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    firstResponderField = textField;
    UILabel *leftButton = (UILabel *)textField.leftView;
    leftButton.textColor = [UIColor blueColor];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    UILabel *leftButton = (UILabel *)textField.leftView;
    leftButton.textColor = [UIColor blackColor];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [firstResponderField resignFirstResponder];
}

- (void)loginAction
{
    
    [self.navigationController presentViewController:[[DNATabBarController alloc] init] animated:YES completion:^{
    }];
    
}

- (void)registerView
{
    [self.navigationController pushViewController:[[RegisterViewController alloc] init] animated:YES];
}

@end
