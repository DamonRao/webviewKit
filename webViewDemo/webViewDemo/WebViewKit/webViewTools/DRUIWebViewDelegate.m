//
//  DRUIWebViewDelegate.m
//  webViewDemo
//
//  Created by DamonRao on 2019/8/13.
//  Copyright © 2019年 DR. All rights reserved.
//

#import "DRUIWebViewDelegate.h"
#import "DRWebView.h"
@implementation DRUIWebViewDelegate

- (instancetype)initWithWebView:(DRWebView *)webView
{
    self = [super init];
    if (self) {
        _webView = webView;
    }
    return self;
}

#pragma mark -- WebView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    __strong id<UIWebViewDelegate> strongDelegate = (id<UIWebViewDelegate>)_webViewController;
    
    NSURL *url = [request URL];
    
    if ([[url absoluteString] rangeOfString:@"weixin://wap/pay"].length > 0 )
    {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[request URL] absoluteString]] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
        }];
        return NO;
    }
   else if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        return [strongDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    } else {
        return YES;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    __strong id<UIWebViewDelegate> strongDelegate = (id<UIWebViewDelegate>)_webViewController;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [strongDelegate webViewDidFinishLoad:webView];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

    __strong id<UIWebViewDelegate> strongDelegate = (id<UIWebViewDelegate>)_webViewController;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [strongDelegate webView:webView didFailLoadWithError:error];
    }
    
//    NSDictionary *userInfo=error.userInfo;
//
//    if(userInfo && [userInfo.allKeys containsObject:@"NSErrorFailingURLStringKey"])
//    {
//        NSString *fialurl=[userInfo objectForKey:@"NSErrorFailingURLStringKey"];
//
//        [[NSNotificationCenter defaultCenter] postNotificationName:ICBrowerLoadingResultNotification object:fialurl];
//    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    __strong id<UIWebViewDelegate> strongDelegate = (id<UIWebViewDelegate>)_webViewController;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [strongDelegate webViewDidStartLoad:webView];
    }
}
@end
