//
//  DRWKWebViewDelegate.h
//  webViewDemo
//
//  Created by DamonRao on 2019/8/13.
//  Copyright © 2019年 DR. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DRWebView;

@interface DRWKWebViewDelegate : NSObject<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, readonly, weak) DRWebView *webView;

@property (nonatomic, weak) UIViewController *webViewController;

- (instancetype) initWithWebView:(DRWebView *)webView;


@end

NS_ASSUME_NONNULL_END
