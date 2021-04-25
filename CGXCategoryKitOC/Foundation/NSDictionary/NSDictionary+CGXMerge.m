//
//  NSDictionary+CGXMerge.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSDictionary+CGXMerge.h"

@implementation NSDictionary (CGXMerge)
/**
 *  @brief  合并两个NSDictionary
 *
 *  @param dict1 NSDictionary
 *  @param dict2 NSDictionary
 *
 *  @return 合并后的NSDictionary
 */
+ (NSDictionary *)gx_dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2 {
    NSMutableDictionary * result = [NSMutableDictionary dictionaryWithDictionary:dict1];
    NSMutableDictionary * resultTemp = [NSMutableDictionary dictionaryWithDictionary:dict1];
    [resultTemp addEntriesFromDictionary:dict2];
    [resultTemp enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
        if ([dict1 objectForKey:key]) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary * newVal = [[dict1 objectForKey: key] gx_dictionaryByMergingWith: (NSDictionary *) obj];
                [result setObject: newVal forKey: key];
            } else {
                [result setObject: obj forKey: key];
            }
        }
        else if([dict2 objectForKey:key])
        {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary * newVal = [[dict2 objectForKey: key] gx_dictionaryByMergingWith: (NSDictionary *) obj];
                [result setObject: newVal forKey: key];
            } else {
                [result setObject: obj forKey: key];
            }
        }
    }];
    return (NSDictionary *) [result mutableCopy];
    
}
/**
 *  @brief  并入一个NSDictionary
 *
 *  @param dict NSDictionary
 *
 *  @return 增加后的NSDictionary
 */
- (NSDictionary *)gx_dictionaryByMergingWith:(NSDictionary *)dict {
    return [[self class] gx_dictionaryByMerging:self with: dict];
}


/**
 合并两个字典
 
 @param dict       被合并的字典
 @param ignoredKeyArr 忽略的Key
 */
- (NSDictionary *)gx_mergingWithDictionary:(NSDictionary *)dict ignoredKeyArr:(NSArray *)ignoredKeyArr
{
    if (self.count == 0) {
        if (dict.count == 0) {
            return nil;
        }else
        {
            return dict;
        }
    }else
    {
        if (dict.count == 0) {
            return self;
        }
    }
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:self];
    for (id key in [dict allKeys]) {
        if ([ignoredKeyArr containsObject:key]) {
            continue;
        }
        id obj = [self gx_mutableDictionaryCopyIfNeeded:[dict objectForKey:key]];
        id localObj = [self gx_mutableDictionaryCopyIfNeeded:[self objectForKey:key]];
        if ([obj isKindOfClass:[NSDictionary class]] &&
            [localObj isKindOfClass:[NSMutableDictionary class]]) {
            // Recursive merge for NSDictionary
            [localObj gx_dictionaryByMergingWith:obj];
        } else if (obj) {
            [mutableDic setValue:obj forKey:key];
        }
    }
    return (NSDictionary *)mutableDic;
}

- (NSMutableDictionary *)gx_Mutable {
    NSMutableDictionary *dicResult = [[NSMutableDictionary alloc] init];
    for (NSString *key in self.allKeys) {
        NSObject *obj = self[key];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *mDic = [(NSDictionary *)obj gx_Mutable];
            [dicResult setValue:mDic forKey:key];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            NSMutableArray *mArr = [self gx_MutableWith:(NSArray *)obj];
            [dicResult setValue:mArr forKey:key];
        } else {
            [dicResult setValue:obj forKey:key];
        }
        NSLog(@"-------%@",dicResult);
    }
    return dicResult;
}

#pragma mark - private
- (NSMutableArray *)gx_MutableWith:(NSArray *)array {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSObject *obj in array) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *mDic = [(NSDictionary *)obj gx_Mutable];
            [tempArray addObject:mDic];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            NSMutableArray *mArr = [self gx_MutableWith:(NSArray *)obj];
            [tempArray addObject:mArr];
            
        } else {
            [tempArray addObject:obj];
        }
    }
    
    return tempArray;
}



- (id)gx_mutableDictionaryCopyIfNeeded:(id)dictObj
{
    if ([dictObj isKindOfClass:[NSDictionary class]] &&
        ![dictObj isKindOfClass:[NSMutableDictionary class]]) {
        dictObj = [dictObj mutableCopy];
    }
    return dictObj;
}
@end
