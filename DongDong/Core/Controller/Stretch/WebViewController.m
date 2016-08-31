//
//  WebViewController.m
//  DongDong
//
//  Created by javalong on 16/8/26.
//  Copyright © 2016年 javalong. All rights reserved.
//

#import "WebViewController.h"

#import <WebKit/WebKit.h>

@interface WebViewController ()<UIWebViewDelegate, WKUIDelegate,WKNavigationDelegate>

@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIWebView *web = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    web.delegate = self;
//    web.backgroundColor = [UIColor redColor];
//    [self.view addSubview:web];
//
    
    
    WKWebViewConfiguration* configuration = [[NSClassFromString(@"WKWebViewConfiguration") alloc] init];
    configuration.preferences = [NSClassFromString(@"WKPreferences") new];
    configuration.userContentController = [NSClassFromString(@"WKUserContentController") new];
    configuration.preferences.javaScriptEnabled = YES;
    
    WKWebView* web = [[NSClassFromString(@"WKWebView") alloc] initWithFrame:self.view.bounds configuration:configuration];
    web.UIDelegate = self;
    web.navigationDelegate = self;
    web.backgroundColor = [UIColor redColor];
    [self.view addSubview:web];
    
//    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
//    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
//    [self callback_webViewDidStartLoad];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
//    [self callback_webViewDidFinishLoad];
}
- (void)webView:(WKWebView *) webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
//    [self callback_webViewDidFailLoadWithError:error];
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
//    [self callback_webViewDidFailLoadWithError:error];
}

#pragma mark- WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    BOOL resultBOOL = YES;//[self callback_webViewShouldStartLoadWithRequest:navigationAction.request navigationType:navigationAction.navigationType];
    WKNavigationActionPolicy p = WKNavigationActionPolicyCancel;
    if(resultBOOL)
    {
//        self.currentRequest = navigationAction.request;
        if(navigationAction.targetFrame == nil)
        {
            [webView loadRequest:navigationAction.request];
        }
        p = WKNavigationActionPolicyAllow;
    }
    if (decisionHandler) decisionHandler(p);
}






- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    NSLog(@"===%@", error);
}

@end
