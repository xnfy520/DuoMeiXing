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
#import "RegisterNextViewController.h"

@implementation RegisterViewController
{
    UITextField *firstResponderField;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"注册";
    
    [self setViewRectEdge];
    
    FormTextField *phoneField = [[FormTextField alloc] initWithFrame:CGRectMake(formFieldPadding, 20, formFieldWith, 40) withTitle:@"手机 +86" withPlaceholder:@"请输入手机号码" withLeftViewWidth:65];
    phoneField.delegate = self;
    [self.view addSubview:phoneField];
    
    SubmitButton *getCodeButton = [[SubmitButton alloc] initWithFrame:CGRectMake(submitButtonPadding, CGRectGetMaxY(phoneField.frame)+20, submitButtonWith, 40) withTitle:@"获取验证码" withBackgroundColor:defaultTabBarTitleColor];
    [self.view addSubview:getCodeButton];
    
    [getCodeButton addToucheHandler:^(JKCountDownButton*sender, NSInteger tag) {
        
        [self requestSMSCode];
        
        sender.enabled = NO;
        
        [sender startWithSecond:60];
        
        [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
            [countDownButton setBackgroundColor:[UIColor lightGrayColor]];
            NSString *title = [NSString stringWithFormat:@"%ds后重新获取",second];
            return title;
        }];
        
        [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
            [countDownButton setBackgroundColor:defaultTabBarTitleColor];
            countDownButton.enabled = YES;
            
            return @"点击重新获取";
        }];
        
    }];
    
    FormTextField *verificationField = [[FormTextField alloc] initWithFrame:CGRectMake(formFieldPadding, CGRectGetMaxY(getCodeButton.frame)+20, formFieldWith, 40) withTitle:@"验证码" withPlaceholder:@"请输验证码" withLeftViewWidth:65];
    verificationField.delegate = self;
    [self.view addSubview:verificationField];
    
    SubmitButton *nextButton = [[SubmitButton alloc] initWithFrame:CGRectMake(submitButtonPadding, CGRectGetMaxY(verificationField.frame)+20, submitButtonWith, 40) withTitle:@"下一步" withBackgroundColor:defaultTabBarTitleColor];
    [nextButton addTarget:self action:@selector(registerNextAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [firstResponderField resignFirstResponder];
}

- (void)requestSMSCode
{
    RequestSMS *requestData = [[RequestSMS alloc] init];
    requestData.mobile = @"15820448273";
    
    RequestService *api = [[RequestService alloc] initReqeustUrl:appAPISMS withPostData:requestData withResponseValidator:[ResponseSMS responseValidator]];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        ResponseSMS * responseData = [ResponseSMS objectWithKeyValues:[request responseJSONObject]];
        
        if ([responseData.result integerValue] == 0)
        {
            NSLog(@"获取成功");
        }else{
            NSLog(@"获取失败");
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        
        NSLog(@"failed");
        
        NSLog(@"%@", [[request responseJSONObject] objectForKey:@"code"]);
        
    }];
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

- (void)registerNextAction
{

    RegisterNextViewController *registerNextCtrl = [[RegisterNextViewController alloc] init];
    [self.navigationController pushViewController:registerNextCtrl animated:YES];
    
}

@end
