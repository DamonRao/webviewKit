//
//  DRWebView.m
//  webViewDemo
//
//  Created by DamonRao on 2019/8/13.
//  Copyright © 2019年 DR. All rights reserved.
//

#import "DRWebView.h"
#import <WebKit/WebKit.h>
#import "DRWKWebViewDelegate.h"
#import "DRUIWebViewDelegate.h"

@interface DRWKWebView : WKWebView <DRWebViewProtocol>

@end

@implementation DRWKWebView

-(void)dr_evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id, NSError *))completionHandler
{
    [self evaluateJavaScript:javaScriptString completionHandler:completionHandler];
}
@end

#pragma mark - DRUIWebView

@interface DRUIWebView : UIWebView <DRWebViewProtocol>

@end

@implementation DRUIWebView

-(void)dr_evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id, NSError *))completionHandler
{
    NSString* result = [self stringByEvaluatingJavaScriptFromString:javaScriptString];
    if (completionHandler) {
        completionHandler(result,nil);
    }
}
@end

@interface DRWebView()

@property (nonatomic, strong) DRUIWebViewDelegate *uiWebViewDelegate;
@property (nonatomic, strong) DRWKWebViewDelegate *wkWebViewDelegate;

@property (nonatomic,assign) double estimatedProgress;
@property (nonatomic,assign) float pageHeight;
@property (nonatomic,copy) NSArray *images;

@end
@implementation DRWebView

- (instancetype)initWithFrame:(CGRect)frame configuration:(DRWebViewConfigration *)webConfig
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _webConfig = webConfig;
        
        CGRect webviewRect = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        if (_webConfig.webViewType == WebViewTypeUIKit) {
            
            _webView = [[DRUIWebView alloc] initWithFrame:webviewRect];
            
            _uiWebViewDelegate = [[DRUIWebViewDelegate alloc] initWithWebView:self];
            
            [(DRUIWebView *)_webView setDelegate:_uiWebViewDelegate];
            
            //设置适应屏幕宽度
            [(DRUIWebView *)_webView setScalesPageToFit:YES];
            
            [(DRUIWebView *)_webView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
            
            [self addSubview:(DRUIWebView *)_webView];
            
        } else {
            
            _webView = [[DRWKWebView alloc] initWithFrame:webviewRect];
            _wkWebViewDelegate = [[DRWKWebViewDelegate alloc] initWithWebView:self];
            [(DRWKWebView *)_webView setUIDelegate:_wkWebViewDelegate];
            [(DRWKWebView *)_webView setNavigationDelegate:_wkWebViewDelegate];
            [(DRWKWebView *)_webView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
            
            [(DRWKWebView *)_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
            [self addSubview:(DRWKWebView *)_webView];
            
        }
        
    }
    return self;
}

-(void)dealloc
{
    if (_webConfig.webViewType == WebViewTypeWebKit) {
        [(DRWKWebView *)_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    }
}


#pragma mark - EMMWebViewProtocol

- (void)reload
{
    [_webView reload];
}
- (void)stopLoading
{
    [_webView stopLoading];
}
- (void)goBack
{
    [_webView goBack];
}
- (void)goForward
{
    [_webView goForward];
}
-(BOOL)canGoBack
{
    return _webView.canGoBack;
}
-(BOOL)canGoForward
{
    return _webView.canGoForward;
}
-(BOOL)isLoading
{
    return _webView.isLoading;
}

- (void)loadRequest:(NSURLRequest *)request
{
    [_webView loadRequest:request];
}

- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL
{
    [_webView loadHTMLString:string baseURL:baseURL];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.estimatedProgress = [change[NSKeyValueChangeNewKey] doubleValue];
    }
}


#pragma mark - Actions

- (void)evaluateJavaScript:(NSString*)javaScriptString completionHandler:(void (^)(id, NSError*))completionHandler
{
    [_webView dr_evaluateJavaScript:javaScriptString completionHandler:completionHandler];
}

@end
