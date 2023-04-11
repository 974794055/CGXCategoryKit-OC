//
//  NSOrderedSet+CGXSafe.m
//  NSObjectSafe
//
//  Created by guixin on 2023/4/9.
//  Copyright © 2023 tencent. All rights reserved.
//

#import "NSOrderedSet+CGXSafe.h"
#import "NSObject+CGXRuntime.h"
#import <objc/runtime.h>
@implementation NSOrderedSet (CGXSafe)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /* 类方法 */
        [NSObject gx_swizzleClassMethodOriginSel:@selector(orderedSetWithObject:) swizzledSel:@selector(hookOrderedSetWithObject:)];
        
        [NSClassFromString(@"__NSPlaceholderOrderedSet") gx_swizzleClassInstanceMethodWithOriginSel:@selector(initWithObject:) swizzleSel:@selector(hookInitWithObject:)];
        [NSClassFromString(@"__NSOrderedSetI") gx_swizzleClassInstanceMethodWithOriginSel:@selector(objectAtIndex:) swizzleSel:@selector(hookObjectAtIndex:)];
        
    });
}
+ (instancetype)hookOrderedSetWithObject:(id)object
{
    if (object) {
        return [self hookOrderedSetWithObject:object];
    }
    NSLog(@"NSOrderedSet invalid args hookOrderedSetWithObject:[%@]", object);
    return nil;
}
- (instancetype)hookInitWithObject:(id)object
{
    if (object){
        return [self hookInitWithObject:object];
    }
    NSLog(@"NSOrderedSet invalid args hookInitWithObject:[%@]", object);
    return nil;
}
- (id)hookObjectAtIndex:(NSUInteger)idx
{
    @synchronized (self) {
        if (idx < self.count){
            return [self hookObjectAtIndex:idx];
        }
        return nil;
    }
}
@end
