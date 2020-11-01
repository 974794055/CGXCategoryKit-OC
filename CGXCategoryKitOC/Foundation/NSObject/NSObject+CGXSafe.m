//
//  NSObject+CGXSafe.m
//  CGXCategoryKitOC
//
//  Created by CGX on 2020/10/21.
//

#import "NSObject+CGXSafe.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@implementation UIWindow (CGXSafe)

+ (UIViewController *)objectSafeTopViewController {
    return [self privateObjectSafeGetVisibleViewControllerFrom:UIApplication.sharedApplication.keyWindow.rootViewController];
}

+ (UIViewController *)privateObjectSafeGetVisibleViewControllerFrom:(UIViewController *)viewController {
    if ([viewController isKindOfClass:UINavigationController.class]) {
        return [self privateObjectSafeGetVisibleViewControllerFrom:[(UINavigationController *)viewController visibleViewController]];
    } else if ([viewController isKindOfClass:UITabBarController.class]) {
        return [self privateObjectSafeGetVisibleViewControllerFrom:[(UITabBarController *)viewController selectedViewController]];
    } else if ([viewController isKindOfClass:UISplitViewController.class]) {
        return [self privateObjectSafeGetVisibleViewControllerFrom:[(UISplitViewController *)viewController viewControllers].lastObject];
    } else {
        if (viewController.presentedViewController) {
            return [self privateObjectSafeGetVisibleViewControllerFrom:viewController.presentedViewController];
        } else {
            return viewController;
        }
    }
}

@end

static NSString *_errorFoundationName;

void privateObjectSafeMSafeCategorySafeMethodIMP(id self, SEL _cmd) {
#ifdef DEBUG
    NSString *className = NSStringFromClass([self class]);
    NSString *errMsg = [NSString stringWithFormat:@"异常类名：%@\n异常方法名：%@", className, _errorFoundationName];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"debug，方法缺失异常" message:errMsg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"秒懂" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [[UIWindow objectSafeTopViewController] presentViewController:alert animated:YES completion:nil];
#else
    // debug handle, not handle at release, catch
#endif
}

@implementation NSObject (CGXSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL systemSel = @selector(methodSignatureForSelector:);
        SEL mySel = @selector(gx_objectCategoryRunTimeSafeAlertSwizzleMethodSignatureForSelector:);
        [self gx_objectCategoryRunTimeSafeAlertSwizzleSystemSel:systemSel mySel:mySel];
        
        SEL systemSel1 = @selector(forwardInvocation:);
        SEL mySel1 = @selector(gx_objectCategoryRunTimeSafeAlertSwizzleForwardInvocation:);
        [self gx_objectCategoryRunTimeSafeAlertSwizzleSystemSel:systemSel1 mySel:mySel1];
    });
}

+ (void)gx_objectCategoryRunTimeSafeAlertSwizzleSystemSel:(SEL)systemSel mySel:(SEL)mySel {
    Class clz = [self class];
    Method systemMethod = class_getInstanceMethod(clz, systemSel);
    Method myMethod = class_getInstanceMethod(clz, mySel);
    if (class_addMethod(clz, systemSel, method_getImplementation(myMethod), method_getTypeEncoding(myMethod))) {
        class_replaceMethod(clz, mySel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    } else {
        method_exchangeImplementations(systemMethod, myMethod);
    }
}

- (NSMethodSignature *)gx_objectCategoryRunTimeSafeAlertSwizzleMethodSignatureForSelector:(SEL)aSelector {
    if ([self respondsToSelector:aSelector]) {
        return [self gx_objectCategoryRunTimeSafeAlertSwizzleMethodSignatureForSelector:aSelector];
    }
    _errorFoundationName = NSStringFromSelector(aSelector);
    NSMethodSignature *signature = [self gx_objectCategoryRunTimeSafeAlertSwizzleMethodSignatureForSelector:aSelector];
    if (class_addMethod([self class], aSelector, (IMP)privateObjectSafeMSafeCategorySafeMethodIMP, "v@:")) {
        NSLog(@"成功添加临时方法");
    }
    if (!signature) {
        signature = [self gx_objectCategoryRunTimeSafeAlertSwizzleMethodSignatureForSelector:aSelector];
    }
    return signature;
}

- (void)gx_objectCategoryRunTimeSafeAlertSwizzleForwardInvocation:(NSInvocation *)anInvocation {
    SEL selctor = [anInvocation selector];
    if ([self respondsToSelector:selctor]) {
        [anInvocation invokeWithTarget:self];
    } else {
        [self gx_objectCategoryRunTimeSafeAlertSwizzleForwardInvocation:anInvocation];
    }
}

@end
