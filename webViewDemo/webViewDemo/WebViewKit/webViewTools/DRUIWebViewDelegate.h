//
//  DRUIWebViewDelegate.h
//  webViewDemo
//
//  Created by DamonRao on 2019/8/13.
//  Copyright © 2019年 DR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DRWebView;

@interface DRUIWebViewDelegate : NSObject<UIWebViewDelegate>

@property (nonatomic, readonly, weak) DRWebView *webView;

@property (nonatomic, weak) UIViewController *webViewController;

- (instancetype) initWithWebView:(DRWebView *)webView;

@end

