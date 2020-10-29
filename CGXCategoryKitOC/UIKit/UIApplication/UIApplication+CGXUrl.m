//
//  UIApplication+CGXUrl.m
//  CGXCategoryKitOC
//
//  Created by CGX on 2020/10/21.
//

#import "UIApplication+CGXUrl.h"

@implementation UIApplication (CGXUrl)

#pragma mark - 类方法

+ (BOOL)gx_openURL:(NSURL *)url {
    if (url == nil) {
        return NO;
    }
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]==NO) {
        return NO;
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return [app openURL:url];
#pragma clang diagnostic pod
}

+ (BOOL)gx_openPath:(NSString *)path{
    return [[UIApplication sharedApplication] gx_openPath:path];
}

+ (void)gx_openURL:(NSURL *)url completionHandler:(void(^)(BOOL isSuccess))completion {
    [[self sharedApplication] gx_openURL:url completionHandler:completion];
}

+ (void)gx_openPath:(NSString *)path completionHandler:(void(^)(BOOL isSuccess))completion {
    [[self sharedApplication] gx_openPath:path completionHandler:completion];
}

#pragma mark - 实例方法

- (BOOL)gx_openPath:(NSString *)path{
    if (path == nil) {
        return NO;
    }
    NSURL *url = [NSURL URLWithString:path];
    if (url == nil) {
        return NO;
    }
    if ([self canOpenURL:url]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [self openURL:url];
#pragma clang diagnostic pod
    }
    return NO;
}
- (void)gx_openURL:(NSURL *)url completionHandler:(void (^)(BOOL))completion{
    if (url == nil) {
        if (completion) {
            completion(false);
        }
        return;
    }
    if ([self canOpenURL:url]==NO) {
        if (completion) {
            completion(false);
        }
        //return;
    }
    if (@available(iOS 10.0, *)) {
        [self openURL:url options:@{} completionHandler:completion];
    } else {
        // Fallback on earlier versions
    }
}
- (void)gx_openPath:(NSString *)path completionHandler:(void(^)(BOOL isSuccess))completion{
    if (path == nil) {
        if (completion) {
            completion(false);
        }
        return;
    }
    [self gx_openURL:[NSURL URLWithString:path] completionHandler:completion];
}

@end
