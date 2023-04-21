//
//  WKWebView+CGXExtension.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (CGXExtension)
//显示加载网页的进度条
- (void)gx_progressWKWebViewWithColor:(UIColor *)color;

+ (void)gx_clearAllWebCache;

/**
 网页截长图
 */
- (void)gx_screenshotsImage:(void(^)(UIImage *_Nullable image))handler;
@end

NS_ASSUME_NONNULL_END
