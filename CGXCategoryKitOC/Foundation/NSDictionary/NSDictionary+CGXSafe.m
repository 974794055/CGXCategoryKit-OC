//
//  NSDictionary+CGXSafe.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSDictionary+CGXSafe.h"
#import <objc/runtime.h>
#import "NSObject+CGXRuntime.h"

@implementation NSDictionary (CGXSafe)

#pragma mark - public
- (NSString *)gx_stringForKey:(NSString *)key {
    id tmpValue = [self objectForKey:key];
    if (tmpValue == nil || tmpValue == [NSNull null]) {
        return @"";
    }
    if ([tmpValue isKindOfClass:[NSString class]]) {
        return tmpValue;
    } else {
        @try {
            return [NSString stringWithFormat:@"%@",tmpValue];
        }
        @catch (NSException *exception) {
            return @"";
        }
    }
}

- (NSInteger)gx_integerForKey:(NSString *)key {
    id tmpValue = [self objectForKey:key];
    if (tmpValue == nil || tmpValue == [NSNull null]) {
        return 0;
    }
    if ([tmpValue isKindOfClass:[NSNumber class]]) {
        return [tmpValue integerValue];
    } else {
        @try {
            return [tmpValue integerValue];
        }
        @catch (NSException *exception) {
            return 0;
        }
    }
}

- (float)gx_floatForKey:(NSString *)key {
    id tmpValue = [self objectForKey:key];
    if (tmpValue == nil || tmpValue == [NSNull null]) {
        return 0.0;
    }
    if ([tmpValue isKindOfClass:[NSNumber class]]) {
        return [tmpValue floatValue];
    } else {
        @try {
            return [tmpValue floatValue];
        }
        @catch (NSException *exception) {
            return 0.0;
        }
    }
}

- (BOOL)gx_boolForKey:(NSString *)key {
    id tmpValue = [self objectForKey:key];
    if (tmpValue == nil || tmpValue == [NSNull null]) {
        return false;
    }
    if ([tmpValue isKindOfClass:[NSNumber class]]) {
        return [tmpValue boolValue];
    } else {
        @try {
            return [tmpValue boolValue];
        }
        @catch (NSException *exception) {
            return false;
        }
    }
}

- (NSMutableArray *)gx_arrayForKey:(NSString *)key {
    id tmpValue = [self objectForKey:key];
    if (tmpValue == nil || tmpValue == [NSNull null]) {
        return [NSMutableArray new];
    }
    if ([tmpValue isKindOfClass:[NSArray class]]) {
        if ([tmpValue isKindOfClass:[NSMutableArray class]]) {
            return tmpValue;
        } else {
            return [[NSMutableArray alloc] initWithArray:(NSArray *)tmpValue];
        }
    } else {
        return [NSMutableArray new];
    }
}

- (NSMutableDictionary *)gx_dictionaryKey:(NSString *)key {
    id tmpValue = [self objectForKey:key];
    if (tmpValue == nil || tmpValue == [NSNull null]) {
        return [NSMutableDictionary new];
    }
    if ([tmpValue isKindOfClass:[NSDictionary class]]) {
        if ([tmpValue isKindOfClass:[NSMutableDictionary class]]) {
            return tmpValue;
        } else {
            return [[NSMutableDictionary alloc] initWithDictionary:(NSDictionary *)tmpValue];
        }
    } else {
        return [NSMutableDictionary new];
    }
}

- (long long)gx_longLongForKey:(NSString *)key {
    id tmpValue = [self objectForKey:key];
    if (tmpValue == nil || tmpValue == [NSNull null]) {
        return 0.0;
    }
    if ([tmpValue isKindOfClass:[NSNumber class]]) {
        return [tmpValue longLongValue];
    } else {
        @try {
            return [tmpValue longLongValue];
        }
        @catch (NSException *exception) {
            return 0.0;
        }
    }
}







- (id)gx_mutableDictionaryCopyIfNeeded:(id)dictObj
{
    if ([dictObj isKindOfClass:[NSDictionary class]] &&
        ![dictObj isKindOfClass:[NSMutableDictionary class]]) {
        dictObj = [dictObj mutableCopy];
    }
    return dictObj;
}


+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject gx_swizzleClassInstanceMethodWithOriginSel:@selector(dictionaryWithObject:forKey:) swizzleSel:@selector(gx_hookDictionaryWithObject:forKey:)];
        [NSObject gx_swizzleClassInstanceMethodWithOriginSel:@selector(dictionaryWithObjects:forKeys:count:) swizzleSel:@selector(gx_hookDictionaryWithObjects:forKeys:count:)];
    });
}
+ (instancetype)gx_hookDictionaryWithObject:(id)object forKey:(id)key
{
    if (object && key) {
        return [self gx_hookDictionaryWithObject:object forKey:key];
    }
    NSLog(@"NSDictionary invalid args hookDictionaryWithObject:[%@] forKey:[%@]", object, key);
    return nil;
}

+ (instancetype)gx_hookDictionaryWithObjects:(id  _Nonnull const[])objects forKeys:(id<NSCopying>  _Nonnull const[])keys count:(NSUInteger)cnt
{
    NSInteger index = 0;
    id ks[cnt];
    id objs[cnt];
    for (NSInteger i = 0; i < cnt ; ++i) {
        if (keys[i] && objects[i]) {
            ks[index] = keys[i];
            objs[index] = objects[i];
            ++index;
        }
    }
    return [self gx_hookDictionaryWithObjects:objs forKeys:ks count:index];
}

@end
