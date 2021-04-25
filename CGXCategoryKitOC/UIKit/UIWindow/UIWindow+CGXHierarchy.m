//
//  UIWindow+CGXHierarchy.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "UIWindow+CGXHierarchy.h"

@implementation UIWindow (CGXHierarchy)
- (UIViewController*)gx_topMostController
{
    UIViewController *topController = [self rootViewController];
    
    //  Getting topMost ViewController
    while ([topController presentedViewController])	topController = [topController presentedViewController];
    
    //  Returning topMost ViewController
    return topController;
}

- (UIViewController*)gx_currentViewController;
{
    UIViewController *currentViewController = [self gx_topMostController];
    
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    
    return currentViewController;
}

+ (UIWindow *)gx_getCurrentWindow
{
    NSArray *windows = [[UIApplication sharedApplication] windows];
    UIWindow *tmpWin;
    for(NSInteger i = windows.count - 1; i >= 0; i --)
    {
        tmpWin = windows[i];
        if (tmpWin.windowLevel == UIWindowLevelNormal && tmpWin.rootViewController)
        {
            return tmpWin;
        }
    }
    return nil;
}

+ (UIViewController *)gx_topViewController
{
    UIWindow *window = [UIWindow gx_getCurrentWindow];
    UIViewController *result = nil;
    id nextResponder = nil;
    UIView *frontView = nil;
    for (NSInteger i = window.subviews.count - 1; i >= 0; i --) {
        frontView = window.subviews[i];
        if ([frontView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
            frontView = [frontView.subviews lastObject];
        }
        nextResponder = [frontView nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
            result = nextResponder;
        else {
            frontView = nil;
            continue;
        }
        result = [UIWindow topViewController:result];
        break;
    }
    if (frontView == nil) {
        result = window.rootViewController;
        result = [UIWindow topViewController:result];
    }
    return result;
}

+ (UIViewController *)gx_visibleViewController
{
    UIViewController *rootViewController =[[[[UIApplication sharedApplication] delegate] window] rootViewController];
    return [UIWindow getVisibleViewControllerFrom:rootViewController];
}

#pragma mark - private
+ (UIViewController *)topViewController:(UIViewController *)result
{
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [result valueForKeyPath:@"topViewController"];
    } else if ([result isKindOfClass:[UITabBarController class]]) {
        result = [result valueForKeyPath:@"selectedViewController"];
    } else {
        return result;
    }
    return [UIWindow topViewController:result];
}
+ (UIViewController *) getVisibleViewControllerFrom:(UIViewController *) vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [UIWindow getVisibleViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [UIWindow getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [UIWindow getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
}

@end
