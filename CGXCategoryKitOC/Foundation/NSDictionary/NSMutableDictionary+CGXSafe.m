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

@implementation NSMutableDictionary (CGXSafe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [NSObject gx_swizzleClassInstanceMethodWithOriginSel:@selector(setObject:forKey:) swizzleSel:@selector(gx_dictionaryM_setObject:forKey:)];
        
        [NSObject gx_swizzleClassInstanceMethodWithOriginSel:@selector(removeObjectForKey:) swizzleSel:@selector(gx_dictionaryM_removeObjectForKey:)];
        
        [NSObject gx_swizzleClassInstanceMethodWithOriginSel:@selector(setObject:forKeyedSubscript:) swizzleSel:@selector(gx_dictionaryM_setObject:forKeyedSubscript:)];
    });
}
- (void)gx_dictionaryM_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    @synchronized (self) {
        if (anObject && aKey) {
            [self gx_dictionaryM_setObject:anObject forKey:aKey];
        } else {
            NSLog(@"NSMutableDictionary invalid args hookSetObject:[%@] forKey:[%@]", anObject, aKey);
        }
    }
}
- (void)gx_dictionaryM_removeObjectForKey:(id)aKey {
    @synchronized (self) {
        if (aKey) {
            [self gx_dictionaryM_removeObjectForKey:aKey];
        } else {
            NSLog(@"NSMutableDictionary invalid args hookRemoveObjectForKey:[%@]", aKey);
        }
    }
}
- (void)gx_dictionaryM_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key
{
    @synchronized (self) {
        if (key){
            [self gx_dictionaryM_setObject:obj forKeyedSubscript:key];
        } else {
            NSLog(@"NSMutableDictionary invalid args hookSetObject:forKeyedSubscript:");
        }
    }
}

@end
