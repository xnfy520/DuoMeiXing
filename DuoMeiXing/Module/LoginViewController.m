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
#import "SubmitButton.h"
#import "FormTextField.h"

@implementation LoginViewController
{
    UITextField *firstResponderField;
    FormTextField *loginIdField;
    FormTextField *passwordField;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"登录";
    
    [self setNavigationBar];
    
    [self setViewRectEdge];
    
    loginIdField = [[FormTextField alloc] initWithFrame:CGRectMake(formFieldPadding, 20, formFieldWith, 40) withTitle:@"帐号" withPlaceholder:@"手机号码/用户名/邮箱" withLeftViewWidth:35];
    loginIdField.delegate = self;
    [self.view addSubview:loginIdField];
    
    passwordField = [[FormTextField alloc] initWithFrame:CGRectMake(formFieldPadding, CGRectGetMaxY(loginIdField.frame)+20, formFieldWith, 40) withTitle:@"密码" withPlaceholder:@"密码" withLeftViewWidth:35];
    passwordField.delegate = self;
    passwordField.secureTextEntry = YES;
    [self.view addSubview:passwordField];
    
    SubmitButton *loginButton = [[SubmitButton alloc] initWithFrame:CGRectMake(submitButtonPadding, CGRectGetMaxY(passwordField.frame)+20, submitButtonWith, 40) withTitle:@"登录" withBackgroundColor:defaultTabBarTitleColor];
    [loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    NSString *dismisstype = [[NSUserDefaults standardUserDefaults] objectForKey:@"dismisstype"];

    if (dismisstype!=nil) {
        if ([dismisstype isEqualToString:@"reg"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"dismisstype"];
            [self registerView];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //判断用户是否登录,已登录跳转到首页
    [self mainViewWithAnimate:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{

    [firstResponderField resignFirstResponder];
    if (firstResponderField != nil) {
        for (UITextField *subView in [self.view subviews]) {
            if ([NSStringFromClass([subView class]) isEqualToString:NSStringFromClass([firstResponderField class]) ]) {
                [subView setText:@""];
            }
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
        NSString *loginId = loginIdField.text;
        NSString *password = passwordField.text;
        if (loginId.length > 0 && password.length > 0) {
            
            RequestLogin *requestData = [[RequestLogin alloc] init];
            requestData.loginId = loginId;
            requestData.password = password;
            
            RequestService *api = [[RequestService alloc] initReqeustUrl:appAPILogin withPostData:requestData withResponseValidator:[ResponseLogin responseValidator]];
            
            [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {

                ResponseLogin * responseData = [ResponseLogin objectWithKeyValues:[request responseJSONObject]];
                UserDataManager *manager = [[UserDataManager alloc] init];

                //登录成功,存储用户数据到数据库
                [manager initUser:[responseData JSONObject]];
//                [manager initUser:[request responseJSONObject]];
                //跳转到首页
                [self mainViewWithAnimate:YES];
                
            } failure:^(YTKBaseRequest *request) {
                // 你可以直接在这里使用 self
                
                NSLog(@"failed");
                
                NSLog(@"%@", [[request responseJSONObject] objectForKey:@"code"]);
                
            }];
        }
}



- (void)registerView
{
    RegisterViewController *registerCtrl = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerCtrl animated:YES];
}

@end
