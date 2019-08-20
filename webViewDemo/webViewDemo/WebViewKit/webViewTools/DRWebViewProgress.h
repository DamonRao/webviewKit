//
//  DRWebViewProgress.h
//  webViewDemo
//
//  Created by DamonRao on 2019/8/13.
//  Copyright © 2019年 DR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#undef ic_weak
#if __has_feature(objc_arc_weak)
#define dr_weak weak
#else
#define dr_weak unsafe_unretained
#endif

NS_ASSUME_NONNULL_BEGIN

extern const float DRInitialProgressValue;
extern const float DRInteractiveProgressValue;
extern const float DRFinalProgressValue;

typedef void (^DRWebViewProgressBlock)(float progress);
@protocol DRWebViewProgressDelegate;

@interface DRWebViewProgress : NSObject<UIWebViewDelegate>

@property (nonatomic, dr_weak) id<DRWebViewProgressDelegate>progressDelegate;
@property (nonatomic, dr_weak) id<UIWebViewDelegate>webViewProxyDelegate;
@property (nonatomic, copy) DRWebViewProgressBlock progressBlock;
@property (nonatomic, readonly) float progress;

- (void)reset;

@end

@protocol DRWebViewProgressDelegate <NSObject>
- (void)webViewProgress:(DRWebViewProgress *)webViewProgress updateProgress:(float)progress;
@end

NS_ASSUME_NONNULL_END
