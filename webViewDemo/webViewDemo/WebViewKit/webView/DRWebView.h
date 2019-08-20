//
//  DRWebView.h
//  webViewDemo
//
//  Created by DamonRao on 2019/8/13.
//  Copyright © 2019年 DR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRWebViewConfigration.h"
#import "DRWebViewProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface DRWebView : UIView <DRWebViewProtocol>

@property (nonatomic,strong) id<DRWebViewProtocol>webView;

//webView 所在视图控制器 weak 修饰防止循环引用
@property (nonatomic, weak) UIViewController *webViewController;

@property (nonatomic, strong) DRWebViewConfigration *webConfig;

- (instancetype)initWithFrame:(CGRect)frame configuration:(DRWebViewConfigration *)webConfig;

- (void)evaluateJavaScript:(NSString*)javaScriptString completionHandler:(void (^)(id, NSError*))completionHandler;


@end

NS_ASSUME_NONNULL_END
