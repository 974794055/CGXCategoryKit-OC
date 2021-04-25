//
//  NSDictionary+CGXSafe.m
//  CGXCategoryKitOC
//
//  Created by CGX on 2020/10/21.
//

#import "NSDictionary+CGXSafe.h"
#import <objc/runtime.h>
@implementation NSDictionary (CGXSafe)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 便利构造方法
        [objc_getClass("__NSPlaceholderDictionary") dictionaryRuntimeMExtCategorySwizzleSystemSel:@selector(initWithObjects:forKeys:count:)
                                                                                            mySel:@selector(dictionaryRuntimeMExtCategorySwizzleInitWithObjects:forKeys:count:)];
        id dictM = objc_getClass("__NSDictionaryM");
        [dictM dictionaryRuntimeMExtCategorySwizzleSystemSel:@selector(setObject:forKey:)
                                                       mySel:@selector(mutableDictionaryRuntimeMExtCategorySwizzleSetObject:forKey:)];
        
        [dictM dictionaryRuntimeMExtCategorySwizzleSystemSel:@selector(setObject:forKeyedSubscript:)
                                                       mySel:@selector(mutableDictionaryRuntimeMExtCategorySwizzleSetObject:forKeyedSubscript:)];
    });
}

+ (void)dictionaryRuntimeMExtCategorySwizzleSystemSel:(SEL)systemSel mySel:(SEL)mySel {
    Class clz = [self class];
    Method systemMethod = class_getInstanceMethod(clz, systemSel);
    Method myMethod = class_getInstanceMethod(clz, mySel);
    if (class_addMethod(clz, systemSel, method_getImplementation(myMethod), method_getTypeEncoding(myMethod))) {
        class_replaceMethod(clz, mySel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    } else {
        method_exchangeImplementations(systemMethod, myMethod);
    }
}

// 便利构造方法
- (instancetype)dictionaryRuntimeMExtCategorySwizzleInitWithObjects:(id *)objects forKeys:(id<NSCopying> *)keys count:(NSUInteger)cnt {
    for (NSUInteger i = 0; i < cnt; i++) {
        if (!keys[i]) {
            keys[i] = @"";
        }
        if (!objects[i]) {
            objects[i] = @"";
        }
    }
    return [self dictionaryRuntimeMExtCategorySwizzleInitWithObjects:objects forKeys:keys count:cnt];
}

- (void)mutableDictionaryRuntimeMExtCategorySwizzleSetObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!anObject) {
        anObject = @"";
    }
    [self mutableDictionaryRuntimeMExtCategorySwizzleSetObject:anObject forKey:aKey];
}

- (void)mutableDictionaryRuntimeMExtCategorySwizzleSetObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (!obj) {
        obj = @"";
    }
    [self mutableDictionaryRuntimeMExtCategorySwizzleSetObject:obj forKeyedSubscript:key];
}




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



- (NSDictionary *)gx_dictionaryByReplacingNullsWithBlanks {
    const NSMutableDictionary *replaced = [self mutableCopy];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    
    for (NSString *key in self) {
        id object = [self objectForKey:key];
        if (object == nul) [replaced setValue:blank forKey:key];
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced setValue:[object gx_dictionaryByReplacingNullsWithBlanks] forKey:key];
        else if ([object isKindOfClass:[NSArray class]])
            [replaced setValue:[self gx_arrayByReplacingNullsWithBlanksWith:object] forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:[replaced copy]];
}

- (NSArray *)gx_arrayByReplacingNullsWithBlanksWith:(NSArray *)tempArr
{
    NSMutableArray *replaced = [tempArr mutableCopy];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    for (int idx = 0; idx < [replaced count]; idx++) {
        id object = [replaced objectAtIndex:idx];
        if (object == nul) [replaced replaceObjectAtIndex:idx withObject:blank];
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced replaceObjectAtIndex:idx withObject:[object gx_dictionaryByReplacingNullsWithBlanks]];
        else if ([object isKindOfClass:[NSArray class]]) [replaced replaceObjectAtIndex:idx withObject:[self gx_arrayByReplacingNullsWithBlanksWith:object]];
    }
    return [replaced copy];
}



@end
