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

+ (UIViewController *)gx_objectSafeTopViewController {
    return [self gx_privateObjectSafeGetVisibleViewControllerFrom:UIApplication.sharedApplication.keyWindow.rootViewController];
}

+ (UIViewController *)gx_privateObjectSafeGetVisibleViewControllerFrom:(UIViewController *)viewController {
    if ([viewController isKindOfClass:UINavigationController.class]) {
        return [self gx_privateObjectSafeGetVisibleViewControllerFrom:[(UINavigationController *)viewController visibleViewController]];
    } else if ([viewController isKindOfClass:UITabBarController.class]) {
        return [self gx_privateObjectSafeGetVisibleViewControllerFrom:[(UITabBarController *)viewController selectedViewController]];
    } else if ([viewController isKindOfClass:UISplitViewController.class]) {
        return [self gx_privateObjectSafeGetVisibleViewControllerFrom:[(UISplitViewController *)viewController viewControllers].lastObject];
    } else {
        if (viewController.presentedViewController) {
            return [self gx_privateObjectSafeGetVisibleViewControllerFrom:viewController.presentedViewController];
        } else {
            return viewController;
        }
    }
}

@end

static NSString *_errorFoundationName;

void gx_privateObjectSafeMSafeCategorySafeMethodIMP(id self, SEL _cmd) {
#ifdef DEBUG
    NSString *className = NSStringFromClass([self class]);
    NSString *errMsg = [NSString stringWithFormat:@"异常类名：%@\n异常方法名：%@", className, _errorFoundationName];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"debug，方法缺失异常" message:errMsg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"秒懂" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [[UIWindow gx_objectSafeTopViewController] presentViewController:alert animated:YES completion:nil];
#else
    // debug handle, not handle at release, catch
#endif
}

@implementation NSObject (CGXSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [self gx_objectCategoryRunTimeSafeAlertSwizzleSystemSel:@selector(forwardInvocation:)
                                                          mySel:@selector(gx_objectCategoryRunTimeSafeAlertSwizzleForwardInvocation:)];
        
        [self gx_objectCategoryRunTimeSafeAlertSwizzleSystemSel:@selector(addObserver:forKeyPath:options:context:)
                                                          mySel:@selector(gx_object_AddObserver:forKeyPath:options:context:)];
        
        
        [self gx_objectCategoryRunTimeSafeAlertSwizzleSystemSel:@selector(removeObserver:forKeyPath:)
                                                          mySel:@selector(gx_object_removeObserver:forKeyPath:)];
        
        [self gx_objectCategoryRunTimeSafeAlertSwizzleSystemSel:@selector(methodSignatureForSelector:)
                                                          mySel:@selector(gx_object_methodSignatureForSelector:)];
        
        
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

- (NSMethodSignature *)gx_object_methodSignatureForSelector:(SEL)aSelector {
    if ([self respondsToSelector:aSelector]) {
        return [self gx_object_methodSignatureForSelector:aSelector];
    }
    _errorFoundationName = NSStringFromSelector(aSelector);
    NSMethodSignature *signature = [self gx_object_methodSignatureForSelector:aSelector];
    if (class_addMethod([self class], aSelector, (IMP)gx_privateObjectSafeMSafeCategorySafeMethodIMP, "v@:")) {
        NSLog(@"成功添加临时方法");
    }
    if (!signature) {
        signature = [self gx_object_methodSignatureForSelector:aSelector];
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
- (void)gx_object_AddObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    if (observer && keyPath.length) {
        NSLog(@"hookAddObserver invalid args: %@",self);
        @try {
            [self gx_object_AddObserver:observer forKeyPath:keyPath options:options context:context];
        }
        @catch (NSException *exception) {
            NSLog(@"hookAddObserver ex: %@", [exception callStackSymbols]);
        }
    }

}
- (void)gx_object_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath
{
    if (observer && keyPath.length) {
        NSLog(@"hookRemoveObserver invalid args: %@",self);
        @try {
            [self gx_object_removeObserver:observer forKeyPath:keyPath];
        }
        @catch (NSException *exception) {
            NSLog(@"hookRemoveObserver ex: %@", [exception callStackSymbols]);
        }
    }
}





@end
