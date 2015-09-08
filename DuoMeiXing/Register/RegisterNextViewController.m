//
//  RegisterNextViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/31.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "RegisterNextViewController.h"
#import "DNADef.h"
#import "SubmitButton.h"
#import "FormTextField.h"
#import "RequstData.h"
#import "RegisterData.h"

@implementation RegisterNextViewController
{
    UITextField *firstResponderField;
    FormTextField *nicknameField;
    FormTextField *passwrodField;
    FormTextField *confirmPasswrodField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"完成注册";
    
    [self setViewRectEdge];
    
    nicknameField = [[FormTextField alloc] initWithFrame:CGRectMake(formFieldPadding, 20, formFieldWith, 40) withTitle:@"昵称" withPlaceholder:@"请输入昵称" withLeftViewWidth:65];
    nicknameField.delegate = self;
    [self.view addSubview:nicknameField];
    
    passwrodField = [[FormTextField alloc] initWithFrame:CGRectMake(formFieldPadding, CGRectGetMaxY(nicknameField.frame)+20, formFieldWith, 40) withTitle:@"密码" withPlaceholder:@"请输入密码" withLeftViewWidth:65];
    passwrodField.delegate = self;
    passwrodField.secureTextEntry = YES;
    [self.view addSubview:passwrodField];
    
    confirmPasswrodField = [[FormTextField alloc] initWithFrame:CGRectMake(formFieldPadding, CGRectGetMaxY(passwrodField.frame)+20, formFieldWith, 40) withTitle:@"确认密码" withPlaceholder:@"请再次输入密码" withLeftViewWidth:65];
    confirmPasswrodField.delegate = self;
    confirmPasswrodField.secureTextEntry = YES;
    [self.view addSubview:confirmPasswrodField];
    
    SubmitButton *submitButton = [[SubmitButton alloc] initWithFrame:CGRectMake(submitButtonPadding, CGRectGetMaxY(confirmPasswrodField.frame)+20, submitButtonWith, 40) withTitle:@"注册" withBackgroundColor:defaultTabBarTitleColor];
    [submitButton addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [firstResponderField resignFirstResponder];
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

- (void)requstApi
{
    
    RequestRegister* reqRegister  = [[RegisterData sharedRegisterData] reqRegister];

    RequestService *request = [RequestService registerReqeustPostData:reqRegister];
    
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSLog(@"success");
        NSLog(@"%@", [request responseJSONObject]);

    } failure:^(YTKBaseRequest *request) {
        NSLog(@"failure");
        NSLog(@"%@", [[request responseJSONObject] objectForKey:@"code"]);
        
    }];
    
}

- (void)submitAction
{
    NSString *nickname = nicknameField.text;
    NSString *password = passwrodField.text;
    NSString *confirmPassword = confirmPasswrodField.text;
    if ([nickname isEqualToString:@""]) {
        [self showTips:@"请输入昵称"];
        return;
    }
    if ([password isEqualToString:@""]) {
        [self showTips:@"请输入密码"];
        return;
    }
    if ([confirmPassword isEqualToString:@""]) {
        [self showTips:@"请输入确认密码"];
        return;
    }
    if (![password isEqualToString:confirmPassword]) {
        [self showTips:@"两次密码输入不一致"];
        return;
    }
    RequestRegister* reqRegister  = [[RegisterData sharedRegisterData]reqRegister];
    if ( reqRegister== nil) {
        reqRegister = [[RequestRegister alloc]init];
    }
    reqRegister.nickname = nickname;
    reqRegister.password = password;
    [RegisterData sharedRegisterData].reqRegister = reqRegister;
    
    NSLog(@"%@", [reqRegister JSONObject]);
    
    NSLog(@"%@", [[RegisterData sharedRegisterData].reqRegister JSONObject]);
    
    [self requstApi];
    
}

@end
