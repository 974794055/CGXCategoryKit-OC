//
//  NSMutableSet+CGXSafe.m
//  NSObjectSafe
//
//  Created by guixin on 2023/4/9.
//  Copyright © 2023 tencent. All rights reserved.
//

#import "NSMutableSet+CGXSafe.h"
#import "NSObject+CGXRuntime.h"
#import <objc/runtime.h>
@implementation NSMutableSet (CGXSafe)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /* 普通方法 */
        NSMutableSet* obj = [NSMutableSet setWithObjects:@0, nil];
        [[obj class] gx_swizzleClassInstanceMethodWithOriginSel:@selector(addObject:) swizzleSel:@selector(hookAddObject:)];
        [[obj class] gx_swizzleClassInstanceMethodWithOriginSel:@selector(removeObject:) swizzleSel:@selector(hookRemoveObject:)];
    });
}
- (void)hookAddObject:(id)object {
    @synchronized (self) {
        if (object) {
            [self hookAddObject:object];
        } else {
            NSLog(@"NSMutableSet invalid args hookAddObject[%@]", object);
        }
    }
}

- (void)hookRemoveObject:(id)object {
    @synchronized (self) {
        if (object) {
            [self hookRemoveObject:object];
        } else {
            NSLog(@"NSMutableSet invalid args hookRemoveObject[%@]", object);
        }
    }
}
@end
