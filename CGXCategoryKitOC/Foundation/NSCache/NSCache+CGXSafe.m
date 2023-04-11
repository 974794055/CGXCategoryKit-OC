//
//  NSCache+CGXSafe.m
//  NSObjectSafe
//
//  Created by guixin on 2023/4/9.
//  Copyright © 2023 tencent. All rights reserved.
//

#import "NSCache+CGXSafe.h"
#import "NSObject+CGXRuntime.h"
#import <objc/runtime.h>
@implementation NSCache (CGXSafe)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [[NSCache class] gx_swizzleClassInstanceMethodWithOriginSel:@selector(setObject:forKey:) swizzleSel:@selector(hookSetObject:forKey:)];
        [[NSCache class] gx_swizzleClassInstanceMethodWithOriginSel:@selector(setObject:forKey:cost:) swizzleSel:@selector(hookSetObject:forKey:cost:)];
    });
}
- (void)hookSetObject:(id)obj forKey:(id)key // 0 cost
{
    if (obj) {
        [self hookSetObject:obj forKey:key];
    }else {
        NSLog(@"NSCache invalid args hookSetObject:[%@] forKey:[%@]", obj, key);
    }
}
- (void)hookSetObject:(id)obj forKey:(id)key cost:(NSUInteger)g
{
    if (obj) {
        [self hookSetObject:obj forKey:key cost:g];
    }else {
        NSLog(@"NSCache invalid args hookSetObject:[%@] forKey:[%@] cost:[%@]", obj, key, @(g));
    }
}
@end
