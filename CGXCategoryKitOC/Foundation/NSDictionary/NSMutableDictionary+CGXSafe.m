//
//  NSMutableDictionary+CGXSafe.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSMutableDictionary+CGXSafe.h"
#import "NSObject+CGXRuntime.h"
#import <objc/runtime.h>

static const char *NSDictionaryM = "__NSDictionaryM";

@implementation NSMutableDictionary (CGXSafe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [objc_getClass(NSDictionaryM) gx_swizzleClassInstanceMethodWithOriginSel:@selector(setObject:forKey:) swizzleSel:@selector(gx_dictionaryM_setObject:forKey:)];
    });
}

- (void)gx_dictionaryM_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject != nil) {
        [self gx_dictionaryM_setObject:anObject forKey:aKey];
    }
}

@end
