//
//  UIApplication+CGXUrl.h
//  CGXCategoryKitOC
//
//  Created by CGX on 2020/10/21.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (CGXUrl)
#pragma mark - 类方法

+ (BOOL)gx_openURL:(NSURL *)url;
+ (BOOL)gx_openPath:(NSString *)path;
+ (void)gx_openURL:(NSURL *)url completionHandler:(void(^)(BOOL isSuccess))completion;
+ (void)gx_openPath:(NSString *)path completionHandler:(void(^)(BOOL isSuccess))completion;

#pragma mark - 实例方法

- (BOOL)gx_openPath:(NSString *)path;
- (void)gx_openURL:(NSURL *)url completionHandler:(void (^)(BOOL))completion;
- (void)gx_openPath:(NSString *)path completionHandler:(void(^)(BOOL isSuccess))completion;


/// 通知是否启用
+ (void)gx_userNotificationIsEnable:(void(^)(BOOL isEnable))authorityBlock;

/// 跳转App系统通知设置
+ (void)gx_goToAppSystemSetting;

/// 注册通知
/// @param centerDelegate 协议对象
+ (void)gx_registerRemoteNotificationWith:(id)centerDelegate;



@end

NS_ASSUME_NONNULL_END
