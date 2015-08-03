//
//  WebViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/6.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "WebViewController.h"


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
        _webview.scrollView.emptyDataSetSource = self;
        _webview.scrollView.emptyDataSetDelegate = self;
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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *newUrlString =  [NSString stringWithFormat:@"%@%@",
                               webView.request.URL.host, webView.request.URL.path];
    
    if ([newUrlString isEqualToString:@""]) {
        self.failedLoading = YES;
    }else{
        self.failedLoading = NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSString *newUrlString =  [NSString stringWithFormat:@"%@%@",
                               webView.request.URL.host, webView.request.URL.path];
    
    if ([newUrlString isEqualToString:@""]) {
        self.failedLoading = YES;
    }else{
        self.failedLoading = NO;
    }
    
//    NSLog(@"webViewDidStartLoad:%@",newUrlString);
    [self showHUB];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *newUrlString =  [NSString stringWithFormat:@"%@%@",
                               webView.request.URL.host, webView.request.URL.path];
    
    if ([newUrlString isEqualToString:@""]) {
        self.failedLoading = YES;
    }else{
        self.failedLoading = NO;
    }
    [self hideHUB];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self hideHUB];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]];
    [_webview loadRequest:request];
    
    self.failedLoading = YES;
    
    
    [_webview.scrollView reloadEmptyDataSet];
    

    

    
}


#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (_webview.isLoading || !self.didFailLoading) {
        return nil;
    }
    return [UIImage imageNamed:@"placeholder_remote"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if (_webview.isLoading || !self.didFailLoading) {
        return nil;
    }
    NSString *text = @"无法连接";
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18.0],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

@end
