//
//  DRWKWebViewDelegate.m
//  webViewDemo
//
//  Created by DamonRao on 2019/8/13.
//  Copyright © 2019年 DR. All rights reserved.
//

#import "DRWKWebViewDelegate.h"
#import "DRWebView.h"

@interface DRWKWebViewDelegate ()

@property (nonatomic, copy) NSString *webviewCookies;

@end

@implementation DRWKWebViewDelegate

- (instancetype)initWithWebView:(DRWebView *)webView
{
    self = [super init];
    if (self) {
        _webView = webView;
    }
    return self;
}
#pragma mark - WKNavigationDelegate
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURL *actionUrl = [[navigationAction request] URL];

    __strong id<WKNavigationDelegate> strongDelegate = (id<WKNavigationDelegate>)_webViewController;
    
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:decidePolicyForNavigationAction:decisionHandler:)]) {
        
        [strongDelegate webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
        
    } else {
        
        decisionHandler(WKNavigationActionPolicyAllow);
        
    }
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    
    if ([navigationResponse canShowMIMEType]) {
        decisionHandler(WKNavigationResponsePolicyAllow);
    } else {
        decisionHandler(WKNavigationResponsePolicyCancel);
    }
    
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    __strong id<WKNavigationDelegate> strongDelegate = (id<WKNavigationDelegate>)_webViewController;
    
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:didReceiveServerRedirectForProvisionalNavigation:)]) {
        
        [strongDelegate webView:webView didReceiveServerRedirectForProvisionalNavigation:navigation];
        
    }
}


// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    __strong id<WKNavigationDelegate> strongDelegate = (id<WKNavigationDelegate>)_webViewController;
    
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:didStartProvisionalNavigation:)]) {
        
        [strongDelegate webView:webView didStartProvisionalNavigation:navigation];
        
    }
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    __strong id<WKNavigationDelegate> strongDelegate = (id<WKNavigationDelegate>)_webViewController;
    
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:didCommitNavigation:)]) {
        
        [strongDelegate webView:webView didCommitNavigation:navigation];
        
    }
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    __strong id<WKNavigationDelegate> strongDelegate = (id<WKNavigationDelegate>)_webViewController;
    
    [webView evaluateJavaScript:@"document.cookie;" completionHandler:^(NSString *result, NSError *error)
     {
         if (nil == error && result && result.length > 0) {
             _webviewCookies = result;
         }
     }];
    
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:didFinishNavigation:)]) {
        
        [strongDelegate webView:webView didFinishNavigation:navigation];
        
    }
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    __strong id<WKNavigationDelegate> strongDelegate = (id<WKNavigationDelegate>)_webViewController;
    
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:didFailProvisionalNavigation:withError:)]) {
        
        [strongDelegate webView:webView didFailProvisionalNavigation:navigation withError:error];
        
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
//页面加载完成后，跳转失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    __strong id<WKNavigationDelegate> strongDelegate = (id<WKNavigationDelegate>)_webViewController;
    
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:didFailNavigation:withError:)]) {
        
        [strongDelegate webView:webView didFailNavigation:navigation withError:error];
        
    }
    
    
}
// 如果需要证书验证，与使用AFN进行HTTPS证书验证是一样的
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler
{
    __strong id<WKNavigationDelegate> strongDelegate = (id<WKNavigationDelegate>)_webViewController;
    
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:didReceiveAuthenticationChallenge:completionHandler:)]) {
        
        [strongDelegate webView:webView didReceiveAuthenticationChallenge:challenge completionHandler:completionHandler];
        
    } else {
        
        if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
            
            NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
            
            completionHandler(NSURLSessionAuthChallengeUseCredential,card);
            
        }
        
    }
}
//9.0才能使用，web内容处理中断时会触发
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    __strong id<WKNavigationDelegate> strongDelegate = (id<WKNavigationDelegate>)_webViewController;
    
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webViewWebContentProcessDidTerminate:)]) {
        
        [strongDelegate webViewWebContentProcessDidTerminate:webView];
        
    } else {
        
        [webView reload];
        
    }
}

#pragma mark - WKUIDelegate

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    if (![frameInfo isMainFrame]) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param frame             主窗口
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
    [_webViewController presentViewController:alertController animated:YES completion:^{}];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    
    [_webViewController presentViewController:alertController animated:YES completion:^{}];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([alertController.textFields.firstObject text]) {
            completionHandler([alertController.textFields.firstObject text]);
        } else {
            completionHandler(defaultText);
        };
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(nil);
    }]];
    
    [_webViewController presentViewController:alertController animated:YES completion:^{}];
}

@end
