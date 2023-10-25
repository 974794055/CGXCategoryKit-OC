//
//  NSObject+CGXSafe.m
//  CGXCategoryKitOC
//
//  Created by CGX on 2020/10/21.
//

#import "NSObject+CGXSafe.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "NSObject+CGXRuntime.h"
@implementation NSObject (CGXSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
 
        [self gx_swizzleClassInstanceMethodWithOriginSel:@selector(addObserver:forKeyPath:options:context:)
                                              swizzleSel:@selector(gx_object_hook_AddObserver:forKeyPath:options:context:)];
        
        [self gx_swizzleClassInstanceMethodWithOriginSel:@selector(removeObserver:forKeyPath:)
                                              swizzleSel:@selector(gx_object_hook_removeObserver:forKeyPath:)];
        
        [self gx_swizzleClassInstanceMethodWithOriginSel:@selector(forwardInvocation:)
                                              swizzleSel:@selector(gx_object_hook_forwardInvocation:)];

        [self gx_swizzleClassInstanceMethodWithOriginSel:@selector(methodSignatureForSelector:)
                                              swizzleSel:@selector(gx_object_hook_methodSignatureForSelector:)];
        
    });
}

- (void)gx_object_hook_AddObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    if (observer && keyPath.length) {
        @try {
            [self gx_object_hook_AddObserver:observer forKeyPath:keyPath options:options context:context];
        }
        @catch (NSException *exception) {
            NSLog(@"hookAddObserver ex: %@", [exception callStackSymbols]);
        }
    }
}
- (void)gx_object_hook_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath
{
    if (observer && keyPath.length) {
        @try {
            [self gx_object_hook_removeObserver:observer forKeyPath:keyPath];
        }
        @catch (NSException *exception) {
            NSLog(@"hookRemoveObserver ex: %@", [exception callStackSymbols]);
        }
    }
}

- (NSMethodSignature *)gx_object_hook_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature* sig = [self gx_object_hook_methodSignatureForSelector:aSelector];
    if (!sig){
        //原始的默认实现NSObject 函数指针
        IMP originIMP = class_getMethodImplementation([NSObject class], @selector(methodSignatureForSelector:));
        // 当前类自己的实现
        IMP currentClassIMP = class_getMethodImplementation(self.class, @selector(methodSignatureForSelector:));
        // If current class override methodSignatureForSelector return nil
        //当前类自己重新实现了methodSignatureForSelector:方法；
        if (originIMP != currentClassIMP){
            return nil;
        }
        // Customer method signature
        // void xxx(id,sel,id)
        //随便返回点啥签名， 只要forwardInvocation被hook拦截住不调用就不会崩溃
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    // 协议中的方法，但是没有实现， 默认返回非空
    return sig;
}

- (void)gx_object_hook_forwardInvocation:(NSInvocation *)anInvocation {
    SEL selctor = [anInvocation selector];
    if ([self respondsToSelector:selctor]) {
        [anInvocation invokeWithTarget:self];
    } else {
        [self gx_object_hook_forwardInvocation:anInvocation];
    }
    //    NSString* info = [NSString stringWithFormat:@"unrecognized selector [%@] sent to %@", NSStringFromSelector(invocation.selector), NSStringFromClass(self.class)];
    //    [[NSNotificationCenter defaultCenter] postNotificationName:NSSafeNotification object:self userInfo:@{@"invocation":invocation}];
    //    [[[NSSafeProxy new] autorelease] dealException:info];
}



@end
