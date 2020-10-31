//
//  NSDictionary+CGXExtension.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSMutableDictionary+CGXExtension.h"

@implementation NSMutableDictionary (CGXExtension)




- (id)gx_objectForKey:(id<NSCopying>)key {
    if (key == nil) {
        return nil;
    }
    
    return [self objectForKey:key];
}

- (int)gx_intForKey:(id)key {
    if (key == nil) {
        return 0;
    }
    
    NSNumber *number = [self gx_numberForKey:key];
    
    return [number intValue];
}

- (double)gx_doubleForKey:(id)key {
    if (key == nil) {
        return 0;
    }
    
    NSNumber *number = [self gx_numberForKey:key];
    
    return [number doubleValue];
}

- (float)gx_floatForKey:(id)key {
    if (key == nil) {
        return 0;
    }
    
    NSNumber *number = [self gx_numberForKey:key];
    
    return [number floatValue];
}

- (NSInteger)gx_integerForKey:(id)key {
    if (key == nil) {
        return 0;
    }
    
    NSNumber *number = [self gx_numberForKey:key];
    
    return [number integerValue];
}

- (NSString *)gx_stringForKey:(id)key {
    if (key == nil) {
        return 0;
    }
    
    id obj = [self gx_objectForKey:key];
    
    if ([obj isKindOfClass:[NSString class]]) {
        return (NSString *)obj;
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@", obj];
    }
    
    return nil;
}


- (NSDictionary *)gx_dictionaryForKey:(id)key {
    if (key == nil) {
        return 0;
    }
    
    id obj = [self gx_objectForKey:key];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)obj;
    }
    
    return nil;
}

- (NSArray *)gx_arrayForKey:(id)key {
    if (key == nil) {
        return 0;
    }
    
    id obj = [self gx_objectForKey:key];
    if ([obj isKindOfClass:[NSArray class]]) {
        return (NSArray *)obj;
    }
    
    return nil;
}

- (NSNumber *)gx_numberForKey:(id)key {
    if (key == nil) {
        return 0;
    }
    
    id obj = [self gx_objectForKey:key];
    if ([obj isKindOfClass:[NSNumber class]]) {
        return (NSNumber *)obj;
    }
    
    return nil;
}

- (BOOL)gx_boolForKey:(id)key {
    if (key == nil) {
        return NO;
    }
    
    id number = [self gx_objectForKey:key];
    if ([number respondsToSelector:@selector(boolValue)]) {
        return [number boolValue];
    }
    
    return NO;
}

- (unsigned long long)gx_unsignedLongLongValue:(id<NSCopying>)key {
    if (key == nil) {
        return 0;
    }
    
    id number = [self gx_objectForKey:key];
    if ([number respondsToSelector:@selector(unsignedLongLongValue)]) {
        return [number unsignedLongLongValue];
    }
    
    return 0;
}


- (BOOL)gx_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (aKey == nil || anObject == nil) {
        return NO;
    }
    
    [self setObject:anObject forKey:aKey];
    
    return YES;
}

- (BOOL)gx_setValue:(id)value forKey:(NSString *)key {
    if (key == nil || value == nil) {
        return NO;
    }
    
    [self setValue:value forKey:key];
    
    return YES;
}







@end
