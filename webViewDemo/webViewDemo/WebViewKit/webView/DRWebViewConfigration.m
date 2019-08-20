//
//  DRWebViewConfigration.m
//  webViewDemo
//
//  Created by DamonRao on 2019/8/13.
//  Copyright © 2019年 DR. All rights reserved.
//

#import "DRWebViewConfigration.h"

@implementation DRWebViewConfigration
- (instancetype)init
{
    self = [super init];
    if (self) {
        _webViewType = WebViewTypeWebKit;
    }
    return self;
}


-(void)setWebViewType:(WebViewType)webViewType
{
    _webViewType=webViewType;
}

+ (DRWebViewConfigration *)defaultConfig
{
    return [[DRWebViewConfigration alloc] init];
}
@end
