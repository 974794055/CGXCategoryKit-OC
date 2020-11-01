//
//  NSObject+CGXExtension.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "NSObject+CGXExtension.h"

@implementation NSObject (CGXExtension)

- (NSString *)gx_toJSONString {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                     error:nil];
    
    if (data == nil) {
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    return string;
}

- (NSString *)gx_toReadableJSONString {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    
    if (data == nil) {
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    return string;
}

- (NSData *)gx_toJSONData {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    
    return data;
}

+ (NSMutableData *)gx_toJSONDataWithObject:(id)object {
    NSMutableData *jsonData = nil;
    
    if ([NSJSONSerialization isValidJSONObject:object]) {
        NSError *error = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
        if (error) {
            NSLog(@"error: %@", error.description);
        } else {
            jsonData = [[NSMutableData alloc] initWithData:data];
        }
    }
    
    return jsonData;
}

+ (NSString *)gx_toJSONStringWithObject:(id)object {
    NSMutableData *data = [self gx_toJSONDataWithObject:object];
    
    if (data.length) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    return nil;
}


+ (id)gx_tofilterNullNilFromObject:(id)object {
    if ([object isKindOfClass:[NSDictionary class]]) {
        return [self gx_removeNullNilFromDict:(NSDictionary *)object];
    } else if ([object isKindOfClass:[NSArray class]]) {
        return [self gx_removeNullFromArray:(NSArray *)object];
    } else if ([object isKindOfClass:[NSSet class]]) {
        return [self gx_removeNullFromSet:(NSSet *)object];
    } else if ([object isKindOfClass:[NSNull class]] || object == nil) {
        return nil;
    }
    
    return object;
}
#pragma mark - Private
+ (NSDictionary *)gx_removeNullNilFromDict:(NSDictionary *)dict {
    if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionaryWithCapacity:dict.count];
    for (id key in dict.allKeys) {
        id object = [dict objectForKey:key];
        
        if ([object isKindOfClass:[NSNull class]] || object == nil) {
            // 不添加
        } else if ([object isKindOfClass:[NSDictionary class]]) {
            object = [self gx_removeNullNilFromDict:(NSDictionary *)object];
            
            if (object != nil) {
                [resultDict setObject:object forKey:key];
            }
        } else if ([object isKindOfClass:[NSArray class]]) {
            object = [self gx_removeNullFromArray:(NSArray *)object];
            
            if (object != nil) {
                [resultDict setObject:object forKey:key];
            }
        } else if ([object isKindOfClass:[NSSet class]]) {
            object = [self gx_removeNullFromSet:(NSSet *)object];
            
            if (object != nil && ![object isKindOfClass:[NSNull class]]) {
                [resultDict setObject:object forKey:key];
            }
        } else {
            [resultDict setObject:object forKey:key];
        }
    }
    
    return resultDict;
}

+ (NSArray *)gx_removeNullFromArray:(NSArray *)array {
    if (array == nil || [array isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    if (array.count == 0) {
        return array;
    }
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:array.count];
    
    for (NSUInteger i = 0; i < array.count; ++i) {
        id object = array[i];
        
        if ([object isKindOfClass:[NSNull class]] || object == nil) {
            // 不添加
        } else if ([object isKindOfClass:[NSDictionary class]]) {
            object = [self gx_removeNullNilFromDict:(NSDictionary *)object];
            
            if (object != nil && ![object isKindOfClass:[NSNull class]]) {
                [resultArray addObject:object];
            }
        } else if ([object isKindOfClass:[NSArray class]]) {
            object = [self gx_removeNullFromArray:(NSArray *)object];
            
            if (object != nil && ![object isKindOfClass:[NSNull class]]) {
                [resultArray addObject:object];
            }
        } else if ([object isKindOfClass:[NSSet class]]) {
            object = [self gx_removeNullFromSet:(NSSet *)object];
            
            if (object != nil && ![object isKindOfClass:[NSNull class]]) {
                [resultArray addObject:object];
            }
        } else {
            [resultArray addObject:object];
        }
    }
    
    return resultArray;
}

+ (NSSet *)gx_removeNullFromSet:(NSSet *)set {
    if (set == nil || [set isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    if (set.count == 0) {
        return set;
    }
    
    NSMutableSet *resultSet = [[NSMutableSet alloc] initWithCapacity:set.count];
    
    [set enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        id object = obj;
        
        if ([object isKindOfClass:[NSNull class]] || object == nil) {
            // 不添加
        } else if ([object isKindOfClass:[NSDictionary class]]) {
            object = [self gx_removeNullNilFromDict:(NSDictionary *)object];
            
            if (object != nil && ![object isKindOfClass:[NSNull class]]) {
                [resultSet addObject:object];
            }
        } else if ([object isKindOfClass:[NSArray class]]) {
            object = [self gx_removeNullFromArray:(NSArray *)object];
            
            if (object != nil && ![object isKindOfClass:[NSNull class]]) {
                [resultSet addObject:object];
            }
        } else if ([object isKindOfClass:[NSSet class]]) {
            object = [self gx_removeNullFromSet:(NSSet *)object];
            
            if (object != nil && ![object isKindOfClass:[NSNull class]]) {
                [resultSet addObject:object];
            }
        } else {
            [resultSet addObject:object];
        }
    }];
    
    return resultSet;
}

@end
