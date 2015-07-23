//
//  WebViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/6.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "WebViewController.h"
#import "DNADef.h"

@interface WebViewController ()

@property(strong,nonatomic)UIWebView* webview;
@property(weak,nonatomic)UIViewController* parentViewCtrl;

@end

@implementation WebViewController

SINGLETON_IMPLEMENTATION(WebViewController);


+(void)showWebPageInViewCtrl:(UIViewController*)ctrl withUrl:(NSString*)url withPostData:(NSDictionary*)postDict
{
    WebViewController* webViewCtrl = [WebViewController sharedWebViewController];
    [webViewCtrl openPage:ctrl withUrl:url withPostData:postDict withViewTitle:nil];
    
}

+(void)showWebPageInViewCtrl:(UIViewController*)ctrl withUrl:(NSString*)url withPostData:(NSDictionary*)postDict withViewTitle:(NSString*)title
{
    WebViewController* webViewCtrl = [WebViewController sharedWebViewController];
    [webViewCtrl openPage:ctrl withUrl:url withPostData:postDict withViewTitle:title];
}

-(void)openPage:(UIViewController*)ctrl withUrl:(NSString*)url withPostData:(NSDictionary*)postDict withViewTitle:(NSString*)title
{
    _parentViewCtrl = ctrl;
    if(nil == url && [url isEqualToString:@""])
    {
        url = @"http://www.baidu.com";
    }
    
    if(nil!=title && ![title isEqualToString:@""])
        self.title = title;
    
    if(_webview == nil){
        _webview = [[UIWebView alloc]initWithFrame:self.view.frame];
        _webview.delegate = self;
        [self.view addSubview:_webview];
    }
    
    NSURL* nsUrl = [NSURL URLWithString:url];
    if(nil != postDict){
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: nsUrl];
        [request setHTTPMethod: @"POST"];
//        [request setHTTPBody: [postDict getWebviewPostBody]];
        [_webview loadRequest:request];
    }else{
        NSURLRequest* request = [NSURLRequest requestWithURL:nsUrl];
        [_webview loadRequest:request];
    }
    
    if(_parentViewCtrl!=nil)
        [_parentViewCtrl.navigationController pushViewController:self animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setViewRectEdge];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self closeWebView];
}

-(void)closeWebView
{
    self.title = @"";
    if(_webview != nil){
        [_webview loadHTMLString:@"" baseURL:nil];
    }
    _parentViewCtrl = nil;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSString *newUrlString =  [NSString stringWithFormat:@"%@%@",
                               webView.request.URL.host, webView.request.URL.path];
    
    
//    NSLog(@"webViewDidStartLoad:%@",newUrlString);
    
    [self showHUB];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideHUB];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self hideHUB];
}


@end
