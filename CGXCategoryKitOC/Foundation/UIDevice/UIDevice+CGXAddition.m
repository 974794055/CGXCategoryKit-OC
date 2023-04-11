//
//  UIDevice+CGXAddition.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "UIDevice+CGXAddition.h"

@implementation UIDevice (CGXAddition)
+ (CGFloat)gx_safeDistanceTop {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.top;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.top;
    }
    return 0;
}
 
// 底部安全区高度
+ (CGFloat)gx_safeDistanceBottom {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.bottom;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.bottom;
    }
    return 0;
}
 
 
//顶部状态栏高度（包括安全区）
+ (CGFloat)gx_statusBarHeight {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIStatusBarManager *statusBarManager = windowScene.statusBarManager;
        return statusBarManager.statusBarFrame.size.height;
    } else {
        return [UIApplication sharedApplication].statusBarFrame.size.height;
    }
}
 
// 导航栏高度
+ (CGFloat)gx_navigationBarHeight {
    return 44.0f;
}
 
//// 状态栏+导航栏的高度
+ (CGFloat)gx_navigationFullHeight {
    return [UIDevice gx_statusBarHeight] + [UIDevice gx_navigationBarHeight];
}
//
// 底部导航栏高度
+ (CGFloat)gx_tabBarHeight {
    return 49.0f;
}
 
// 底部导航栏高度（包括安全区）
+ (CGFloat)gx_tabBarFullHeight {
    return [UIDevice gx_tabBarHeight] + [UIDevice gx_safeDistanceBottom];
}
+ (BOOL)gx_IsIphoneX
{
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    return iPhoneXSeries;
}
@end
