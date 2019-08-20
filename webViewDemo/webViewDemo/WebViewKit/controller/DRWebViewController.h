//
//  DRWebViewController.h
//  webViewDemo
//
//  Created by DamonRao on 2019/8/13.
//  Copyright © 2019年 DR. All rights reserved.
//

#import "ViewController.h"
#import "DRWebView.h"
NS_ASSUME_NONNULL_BEGIN

@interface DRWebViewController : ViewController

@property (nonatomic, strong) DRWebView *webView;

@property (nonatomic, strong) DRWebViewConfigration *webConfig;

- (instancetype)initWithWebViewConfiguration:(DRWebViewConfigration *)webConfig;

@end

NS_ASSUME_NONNULL_END
