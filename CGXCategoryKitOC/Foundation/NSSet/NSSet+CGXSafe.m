//
//  NSSet+CGXSafe.m
//  NSObjectSafe
//
//  Created by guixin on 2023/4/9.
//  Copyright © 2023 tencent. All rights reserved.
//

#import "NSSet+CGXSafe.h"
#import "NSObject+CGXRuntime.h"
#import <objc/runtime.h>
@implementation NSSet (CGXSafe)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /* 类方法 */
        [NSSet gx_swizzleClassMethodOriginSel:@selector(setWithObject:) swizzledSel:@selector(hookSetWithObject:)];
        
    });
}
+ (instancetype)hookSetWithObject:(id)object
{
    if (object){
        return [self hookSetWithObject:object];
    }
    NSLog(@"NSSet invalid args hookSetWithObject:[%@]", object);
    return nil;
}
@end
