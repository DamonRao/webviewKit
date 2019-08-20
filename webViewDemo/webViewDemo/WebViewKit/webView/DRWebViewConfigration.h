//
//  DRWebViewConfigration.h
//  webViewDemo
//
//  Created by DamonRao on 2019/8/13.
//  Copyright © 2019年 DR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,WebViewType) {
    WebViewTypeUIKit,    //  UIWebView
    WebViewTypeWebKit,   //  WKWebView
};
@interface DRWebViewConfigration : NSObject
//  Webview 类型，默认为 ICWebViewTypeWebKit。
@property (nonatomic, assign) WebViewType webViewType;

+ (DRWebViewConfigration *)defaultConfig;
@end

NS_ASSUME_NONNULL_END
