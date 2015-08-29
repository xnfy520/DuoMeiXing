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
@property (nonatomic, getter=didFailLoading) BOOL failedLoading;
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
        _webview = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _webview.delegate = self;
//        _webview.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:_webview];
    }
    
    NSURL* nsUrl = [NSURL URLWithString:url];
    if(nil != postDict){
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: nsUrl];
        [request setHTTPMethod: @"POST"];
//        [request setHTTPBody: [postDict getWebviewPostBody]];
        [_webview loadRequest:request];
    }else{
        [self loadUrl:nsUrl];
    }
    
    if(_parentViewCtrl!=nil)
        [_parentViewCtrl.navigationController pushViewController:self animated:YES];
}

- (void)loadUrl:(NSURL *)url
{
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];

    // 定義 cookie 要設定的 host
    NSURL *cookieHost = [NSURL URLWithString:apiBaseUrl];
    
    // 設定 cookie
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:
                            [NSDictionary dictionaryWithObjectsAndKeys:
                             [cookieHost host], NSHTTPCookieDomain,
                             [cookieHost path], NSHTTPCookiePath,
                             sessionIdKey,  NSHTTPCookieName,
                             [NSString stringWithFormat:@"%@=%@;%@=%@",
                              sessionIdKey,
                              [UserDataManager sharedUserDataManager].sessionId,
                              sessionIdName,
                              [UserDataManager sharedUserDataManager].token], NSHTTPCookieValue,
                             nil]];
    
    // 設定 cookie 到 storage 中
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    
    [_webview loadRequest:request];
    
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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@", request.URL);

//    [self loadUrl:request.URL];
    
    NSHTTPCookie *cookie;
    
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    NSArray *cookieAry = [cookieJar cookiesForURL: request.URL];
    
    for (cookie in cookieAry) {
        
        
        NSLog(@"%@", [cookie value]);
//        [cookieJar deleteCookie: cookie];
        
        
        
    }
    
    
    
    NSMutableURLRequest* requests = [NSMutableURLRequest requestWithURL:request.URL];
    
    [requests setValue: [NSString stringWithFormat:@"%@=%@;%@=%@",
                        sessionIdKey,
                        [UserDataManager sharedUserDataManager].sessionId,
                        sessionIdName,
                        [UserDataManager sharedUserDataManager].token] forHTTPHeaderField: @"Cookie"];

    return YES;
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
    NSString *newUrlString =  [NSString stringWithFormat:@"%@%@",
                               webView.request.URL.host, webView.request.URL.path];
    
    [self hideHUB];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self hideHUB];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]];
    [_webview loadRequest:request];
    
//    self.failedLoading = YES;
    
    
//    [_webview.scrollView reloadEmptyDataSet];
    

    

    
}


@end
