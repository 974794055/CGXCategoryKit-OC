//
//  NSMutableOrderedSet+CGXSafe.m
//  NSObjectSafe
//
//  Created by guixin on 2023/4/9.
//  Copyright © 2023 tencent. All rights reserved.
//

#import "NSMutableOrderedSet+CGXSafe.h"
#import "NSObject+CGXRuntime.h"
#import <objc/runtime.h>
@implementation NSMutableOrderedSet (CGXSafe)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /* 普通方法 */
        NSMutableOrderedSet* obj = [NSMutableOrderedSet orderedSetWithObjects:@0, nil];
        [[obj class] gx_swizzleClassInstanceMethodWithOriginSel:@selector(objectAtIndex:) swizzleSel:@selector(hookObjectAtIndex:)];
        
        [[obj class] gx_swizzleClassInstanceMethodWithOriginSel:@selector(addObject:) swizzleSel:@selector(hookAddObject:)];
        [[obj class] gx_swizzleClassInstanceMethodWithOriginSel:@selector(removeObjectAtIndex:) swizzleSel:@selector(hookRemoveObjectAtIndex:)];
        [[obj class] gx_swizzleClassInstanceMethodWithOriginSel:@selector(insertObject:atIndex:) swizzleSel:@selector(hookInsertObject:atIndex:)];
        [[obj class] gx_swizzleClassInstanceMethodWithOriginSel:@selector(replaceObjectAtIndex:withObject:) swizzleSel:@selector(hookReplaceObjectAtIndex:withObject:)];
    });
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
- (void)hookAddObject:(id)object {
    @synchronized (self) {
        if (object) {
            [self hookAddObject:object];
        } else {
            NSLog(@"NSMutableOrderedSet invalid args hookAddObject:[%@]", object);
        }
    }
}
- (void)hookInsertObject:(id)object atIndex:(NSUInteger)idx
{
    @synchronized (self) {
        if (object && idx <= self.count) {
            [self hookInsertObject:object atIndex:idx];
        }else{
            NSLog(@"NSMutableOrderedSet invalid args hookInsertObject:[%@] atIndex:[%@]", object, @(idx));
        }
    }
}
- (void)hookRemoveObjectAtIndex:(NSUInteger)idx
{
    @synchronized (self) {
        if (idx < self.count){
            [self hookRemoveObjectAtIndex:idx];
        }else{
            NSLog(@"NSMutableOrderedSet invalid args hookRemoveObjectAtIndex:[%@]", @(idx));
        }
    }
}
- (void)hookReplaceObjectAtIndex:(NSUInteger)idx withObject:(id)object
{
    @synchronized (self) {
        if (object && idx < self.count) {
            [self hookReplaceObjectAtIndex:idx withObject:object];
        }else{
            NSLog(@"NSMutableOrderedSet invalid args hookReplaceObjectAtIndex:[%@] withObject:[%@]", @(idx), object);
        }
    }
}
@end
