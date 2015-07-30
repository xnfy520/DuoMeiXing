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

@implementation RegisterNextViewController
{
    UITextField *firstResponderField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"完成注册";
    
    [self setViewRectEdge];
    
    FormTextField *nicknameField = [[FormTextField alloc] initWithFrame:CGRectMake(formFieldPadding, 20, formFieldWith, 40) withTitle:@"昵称" withPlaceholder:@"请输入昵称" withLeftViewWidth:65];
    nicknameField.delegate = self;
    [self.view addSubview:nicknameField];
    
    FormTextField *passwrodField = [[FormTextField alloc] initWithFrame:CGRectMake(formFieldPadding, CGRectGetMaxY(nicknameField.frame)+20, formFieldWith, 40) withTitle:@"密码" withPlaceholder:@"请输入密码" withLeftViewWidth:65];
    passwrodField.delegate = self;
    [self.view addSubview:passwrodField];
    
    FormTextField *confirmPasswrodField = [[FormTextField alloc] initWithFrame:CGRectMake(formFieldPadding, CGRectGetMaxY(passwrodField.frame)+20, formFieldWith, 40) withTitle:@"确认密码" withPlaceholder:@"请再次输入密码" withLeftViewWidth:65];
    confirmPasswrodField.delegate = self;
    [self.view addSubview:confirmPasswrodField];
    
    SubmitButton *getCodeButton = [[SubmitButton alloc] initWithFrame:CGRectMake(submitButtonPadding, CGRectGetMaxY(confirmPasswrodField.frame)+20, submitButtonWith, 40) withTitle:@"注册" withBackgroundColor:defaultTabBarTitleColor];
    [self.view addSubview:getCodeButton];
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

@end
