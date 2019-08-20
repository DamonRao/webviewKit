//
//  DRWebViewProtocol.h
//  webViewDemo
//
//  Created by DamonRao on 2019/8/13.
//  Copyright © 2019年 DR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DRWebViewProtocol<NSObject>

@optional
@property (nonatomic, readonly, strong) UIScrollView *scrollView;
@property (nonatomic, readonly, getter=canGoBack) BOOL canGoBack;
@property (nonatomic, readonly, getter=canGoForward) BOOL canGoForward;
@property (nonatomic, readonly, getter=isLoading) BOOL loading;

@property (nonatomic, readonly, copy) NSString *title;

@property (nonatomic, readonly) double estimatedProgress;

@property (nonatomic, readonly) float pageHeight;

@property (nonatomic, readonly, copy) NSArray * images;

- (void)loadRequest:(NSURLRequest *)request;
- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL;
- (void)reload;
- (void)stopLoading;
- (void)goBack;
- (void)goForward;
- (void)dr_evaluateJavaScript:(NSString*)javaScriptString completionHandler:(void (^)(id, NSError*))completionHandler;

@end

NS_ASSUME_NONNULL_END
