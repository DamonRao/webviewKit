//
//  DRWebViewController.m
//  webViewDemo
//
//  Created by DamonRao on 2019/8/13.
//  Copyright © 2019年 DR. All rights reserved.
//

#import "DRWebViewController.h"

#define IS_IPHONE_XR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE_XS_MAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPhoneX_All ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896)

#define AeraSizeHeight ((IS_IPHONE_XS_MAX || IS_IPHONE_XR || IS_IPhoneX_All) ? (34) : (0))


@interface DRWebViewController () <UIWebViewDelegate>

@property (readwrite, assign) BOOL initialized;

@end


@implementation DRWebViewController


- (void)p_init
{
    if ((self != nil) && !self.initialized) {
        
        self.initialized = YES;
    }
}

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self p_init];
    return self;
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [self p_init];
    return self;
}

- (id)init
{
    self = [super init];
    [self p_init];
    return self;
}

- (instancetype)initWithWebViewConfiguration:(DRWebViewConfigration *)webConfig
{
    self = [self init];
    
    if (self) {
        
        _webConfig = webConfig;
        
    }
    
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (!self.webView) {
        
        CGRect webViewBounds = self.view.bounds;
        
        webViewBounds.origin = self.view.bounds.origin;
        
        if (nil == _webConfig) {
            
            _webConfig = [DRWebViewConfigration defaultConfig];
            
        }
        
        _webView = [[DRWebView alloc] initWithFrame:webViewBounds configuration:_webConfig];
        
        _webView.backgroundColor = [UIColor whiteColor];
        
        _webView.webViewController = self;
        
        _webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        
        [self.view addSubview:_webView];
        
        [self.view sendSubviewToBack:_webView];
        
        webViewBounds.size.height =webViewBounds.size.height-AeraSizeHeight;
        
        _webView.frame = webViewBounds;
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
