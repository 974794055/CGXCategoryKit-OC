//
//  WKWebView+CGXExtension.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "WKWebView+CGXExtension.h"
#include <objc/runtime.h>

@interface WKWebView ()<WKNavigationDelegate>

@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation WKWebView (CGXExtension)

FOUNDATION_STATIC_INLINE void clearWebViewCacheFolderByType(NSString *cacheType) {
    
    static dispatch_once_t once;
    static NSDictionary *cachePathMap = nil;
    
    dispatch_once(&once,^{
        NSString *bundleId = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleIdentifierKey];
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
        NSString *storageFileBasePath = [libraryPath stringByAppendingPathComponent:
                                         [NSString stringWithFormat:@"WebKit/%@/WebsiteData/", bundleId]];
        
        cachePathMap = @{@"WKWebsiteDataTypeCookies":
                             [libraryPath stringByAppendingPathComponent:@"Cookies/Cookies.binarycookies"],
                         @"WKWebsiteDataTypeLocalStorage":
                             [storageFileBasePath stringByAppendingPathComponent:@"LocalStorage"],
                         @"WKWebsiteDataTypeIndexedDBDatabases":
                             [storageFileBasePath stringByAppendingPathComponent:@"IndexedDB"],
                         @"WKWebsiteDataTypeWebSQLDatabases":
                             [storageFileBasePath stringByAppendingPathComponent:@"WebSQL"]
        };
    });
    
    NSString *filePath = cachePathMap[cacheType];
    if (filePath && filePath.length > 0) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            NSError *error = nil;
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
            if (error) {
                NSLog(@"removed file fail: %@ ,error %@", [filePath lastPathComponent], error);
            }
        }
    }
}

- (void)gx_progressWKWebViewWithColor:(UIColor *)color {
    
    //进度条初始化
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    //设置进度条上进度的颜色
    self.progressView.progressTintColor = (color != nil) ? color : [UIColor redColor];
    //设置进度条背景色
    self.progressView.trackTintColor = [UIColor lightGrayColor];
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [self addSubview:self.progressView];
    
    [self addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    self.navigationDelegate = self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if(self.progressView != nil) {
        
        if (object == self && [keyPath isEqualToString:@"estimatedProgress"])
        {
            CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
            if (newprogress == 1)
            {
                self.progressView.hidden = YES;
                [self.progressView setProgress:0 animated:NO];
            }
            else
            {
                self.progressView.hidden = NO;
                [self.progressView setProgress:newprogress animated:YES];
            }
        }
    }
}

//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    //开始加载网页时展示出progressView
    if(self.progressView != nil) {
        
        self.progressView.hidden = NO;
        //开始加载网页的时候将progressView的Height恢复为1.5倍
        self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        //防止progressView被网页挡住
        [self bringSubviewToFront:self.progressView];
    }
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    //加载完成后隐藏progressView
    if(self.progressView != nil) {
        
        self.progressView.hidden = YES;
    }
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    //加载失败同样需要隐藏progressView
    if(self.progressView != nil) {
        
        self.progressView.hidden = YES;
    }
}

- (void)setProgressView:(UIProgressView *)progressView {
    
    objc_setAssociatedObject(self, &@selector(progressView), progressView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIProgressView *)progressView {
    
    UIProgressView *obj = objc_getAssociatedObject(self, &@selector(progressView));
    return obj;
}

- (void)dealloc {
    
    if(self.progressView != nil) {
        
        [self removeObserver:self forKeyPath:@"estimatedProgress"];
    }
}



+ (void)gx_clearAllWebCache{
    if ([[NSProcessInfo processInfo] operatingSystemVersion].majorVersion > 9){
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 110000
        if (@available(iOS 9.0, *)) {
            NSSet *websiteDataTypes = [NSSet setWithArray:@[
                WKWebsiteDataTypeMemoryCache,
                WKWebsiteDataTypeSessionStorage,
                WKWebsiteDataTypeDiskCache,
                WKWebsiteDataTypeOfflineWebApplicationCache,
                WKWebsiteDataTypeCookies,
                WKWebsiteDataTypeLocalStorage,
                WKWebsiteDataTypeIndexedDBDatabases,
                WKWebsiteDataTypeWebSQLDatabases
            ]];
            
            NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
            [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes
                                                       modifiedSince:dateFrom
                                                   completionHandler:^{
                NSLog(@"WKWebView (ClearWebCache) Clear All Cache Done");
            }];
        }
#endif
    } else {
        // iOS8
        NSSet *websiteDataTypes = [NSSet setWithArray:@[
            @"WKWebsiteDataTypeCookies",
            @"WKWebsiteDataTypeLocalStorage",
            @"WKWebsiteDataTypeIndexedDBDatabases",
            @"WKWebsiteDataTypeWebSQLDatabases"
        ]];
        for (NSString *type in websiteDataTypes) {
            clearWebViewCacheFolderByType(type);
        }
    }
}

- (void)gx_screenshotsImage:(void(^)(UIImage *_Nullable image))handler{
    // Put a fake Cover of View
    UIView *screenshotsView = [self snapshotViewAfterScreenUpdates:YES];
    screenshotsView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, screenshotsView.frame.size.width, screenshotsView.frame.size.height);
    [self.superview addSubview:screenshotsView];
    
    // Backup
    CGPoint bakOffset = self.scrollView.contentOffset;
    
    // Divide
    float page = floorf(self.scrollView.contentSize.height/self.bounds.size.height);
    
    UIGraphicsBeginImageContextWithOptions(self.scrollView.contentSize, NO, [UIScreen mainScreen].scale);
    
    [self gx_KAIContentScrollPageDraw:0 maxIndex:(int)page drawCallback:^{
        UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // Recover
        [self.scrollView setContentOffset:bakOffset animated:false];
        [screenshotsView removeFromSuperview];
        
        handler(resultImage);
    }];
}

//滑动画了再截图
- (void)gx_KAIContentScrollPageDraw:(int)index maxIndex:(int)maxIndex drawCallback:(void(^)(void))drawCallback{
    [self.scrollView setContentOffset:CGPointMake(0, (float)index * self.scrollView.frame.size.height)];
    
    CGRect splitFrame = CGRectMake(0, (float)index * self.scrollView.frame.size.height, self.bounds.size.width, self.bounds.size.height);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self drawViewHierarchyInRect:splitFrame afterScreenUpdates:YES];
        
        if(index<maxIndex){
            [self gx_KAIContentScrollPageDraw:index + 1 maxIndex:maxIndex drawCallback:drawCallback];
        }else{
            drawCallback();
        }
    });
}
@end
