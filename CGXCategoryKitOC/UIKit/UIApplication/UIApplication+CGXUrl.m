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


+ (void)gx_userNotificationIsEnable:(void(^)(BOOL isEnable))authorityBlock
{
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
                // 用户未授权通知
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (authorityBlock) {
                        authorityBlock(NO);
                    }
                });
            } else if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
                // 用户已授权通知
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (authorityBlock) {
                        authorityBlock(YES);
                    }
                });
            } else if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
                // 用户未判断
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (authorityBlock) {
                        authorityBlock(NO);
                    }
                });
            }
        }];
    } else {
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types  == UIUserNotificationTypeNone) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (authorityBlock) {
                    authorityBlock(NO);
                }
            });
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (authorityBlock) {
                    authorityBlock(YES);
                }
            });
        }
    }
}

+ (void)gx_goToAppSystemSetting
{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([application canOpenURL:url]) {
        if (@available(iOS 10.0, *)) {
            [application openURL:url options:@{} completionHandler:nil];
        } else {
            [application openURL:url];
        }
    }
}

+ (void)gx_registerRemoteNotificationWith:(id)centerDelegate
{
    if (TARGET_IPHONE_SIMULATOR == 1 && TARGET_OS_IPHONE == 1) {
        // 模拟器无法进行注册
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            if(@available(iOS 10.0,*)){
                UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
                center.delegate = centerDelegate;
                [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
                    if( !error ){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[UIApplication sharedApplication] registerForRemoteNotifications];
                        });
                    }
                }];
                
            } else {
                UIApplication *application = [UIApplication sharedApplication];
                if ([application
                     respondsToSelector:@selector(registerUserNotificationSettings:)]) {
                    //8.0-10.0
                    UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                            settingsForTypes:(UIUserNotificationTypeBadge |UIUserNotificationTypeSound |UIUserNotificationTypeAlert)
                                                            categories:nil];
                    [application registerUserNotificationSettings:settings];
                }
                
            }
        });
    }
}

@end
