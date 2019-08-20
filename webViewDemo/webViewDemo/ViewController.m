//
//  ViewController.m
//  webViewDemo
//
//  Created by DamonRao on 2019/8/12.
//  Copyright © 2019年 DR. All rights reserved.
//

#import "ViewController.h"
#import "DRWebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initWebViewController];
}

-(void)initWebViewController
{
    DRWebViewConfigration *config=[[DRWebViewConfigration alloc] init];
    config.webViewType=WebViewTypeWebKit;
    
    DRWebViewController *vc=[[DRWebViewController alloc] initWithWebViewConfiguration:config];
    vc.view.frame=self.view.bounds;
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    
    [vc.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
}
@end
