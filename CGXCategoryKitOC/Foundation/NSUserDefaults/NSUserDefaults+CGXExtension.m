//
//  NSUserDefaults+CGXExtension.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSUserDefaults+CGXExtension.h"

@implementation NSUserDefaults (CGXExtension)

- (BOOL)gx_SaveSafeObject:(id)value forKey:(NSString *)key {
    if (key == nil) {
        return NO;
    }
    
    if (value == nil || [value isKindOfClass:[NSNull class]]) {
        [self removeObjectForKey:key];
        
        return YES;
    }
    
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        [self setObject:value forKey:key];
        [self synchronize];
        return YES;
    } else {
        id result = [NSObject gx_tofilterNullNilFromObject:value];
        if (result) {
            [self setObject:result forKey:key];
            [self synchronize];
            
            return YES;
        }
    }
    
    return NO;
}

/**
 存自定义对象到Userdefault
 
 @param value 自定义对象
 @param defaultName key
 */
- (void)gx_setObject:(id<NSCoding>)value forKey:(NSString *)defaultName
{
    NSData *customObjectData = [NSKeyedArchiver archivedDataWithRootObject:value];

    [self setObject:customObjectData forKey:defaultName];
}

/**
 获取自定义对象
 
 @param defaultName key
 @return 自定义对象
 */
- (id)gx_objectForKey:(NSString *)defaultName
{
    NSData *customObjectData = [self objectForKey:defaultName];

    id object = [NSKeyedUnarchiver unarchiveObjectWithData:customObjectData];
    
    return object;
}

@end
