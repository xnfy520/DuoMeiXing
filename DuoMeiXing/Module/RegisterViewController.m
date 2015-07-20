//
//  RegisterViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/19.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "RegisterViewController.h"
#import "DNADef.h"
#import "SubmitButton.h"
#import "FormTextField.h"

@implementation RegisterViewController
{
    UITextField *firstResponderField;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"注册";
    
    [self setViewRectEdge];
    
    FormTextField *phoneField = [[FormTextField alloc] initWithFrame:CGRectMake(formFieldPadding, 20, formFieldWith, 40) withTitle:@"手机 +86" withPlaceholder:@"请输入手机号码" withLeftViewWidth:80];
    phoneField.delegate = self;
    [self.view addSubview:phoneField];
    
    SubmitButton *getCodeButton = [[SubmitButton alloc] initWithFrame:CGRectMake(submitButtonPadding, CGRectGetMaxY(phoneField.frame)+20, submitButtonWith, 40) withTitle:@"获取验证码" withTitleColor:[UIColor whiteColor] withBackgroundColor:defaultTabBarTitleColor];
//    [getCodeButton addTarget:self action:@selector(openClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getCodeButton];
    
    FormTextField *verificationField = [[FormTextField alloc] initWithFrame:CGRectMake(formFieldPadding, CGRectGetMaxY(getCodeButton.frame)+20, formFieldWith, 40) withTitle:@"验证码" withPlaceholder:@"请输验证码" withLeftViewWidth:80];
    verificationField.delegate = self;
    [self.view addSubview:verificationField];
    
    SubmitButton *regButton = [[SubmitButton alloc] initWithFrame:CGRectMake(submitButtonPadding, CGRectGetMaxY(verificationField.frame)+20, submitButtonWith, 40) withTitle:@"注册" withTitleColor:[UIColor whiteColor] withBackgroundColor:defaultTabBarTitleColor];
//    [loginButton addTarget:self action:@selector(openClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regButton];

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
