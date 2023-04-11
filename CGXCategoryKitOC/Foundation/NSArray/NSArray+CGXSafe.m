//
//  NSArray+CGXSafe.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSArray+CGXSafe.h"
#import "NSObject+CGXRuntime.h"
#import <objc/runtime.h>

/* NSArray 的三个子类
 __NSArray0 : 空数组
 __NSSingleObjectArrayI : 含有一个元素的数组
 __NSArrayI : 含有多个元素的数组
 */

static const char *NSArray0 = "__NSArray0";
static const char *NSSingleObjectArrayI = "__NSSingleObjectArrayI";
static const char *NSArrayI = "__NSArrayI";

static const char *NSFrozenArrayM = "__NSFrozenArrayM";
static const char *NSArrayI_Transfer = "__NSArrayI_Transfer";
static const char *NSArrayReversed = "__NSArrayReversed";
#define SFAssert(condition, ...) \
if (!(condition)){ SFLog(__FILE__, __FUNCTION__, __LINE__, __VA_ARGS__);} \
NSAssert(condition, @"%@", __VA_ARGS__);

/**
 * 1: negative value
 *  - NSUInteger  > NSIntegerMax
 * 2: overflow
 *  - (a+ b) > a
 */
NS_INLINE NSUInteger NSSafeMaxRange(NSRange range) {
    // negative or reach limit
    if (range.location >= NSNotFound
        || range.length >= NSNotFound){
        return NSNotFound;
    }
    // overflow
    if ((range.location + range.length) < range.location){
        return NSNotFound;
    }
    return (range.location + range.length);
}


@implementation NSArray (CGXSafe)


- (NSMutableArray *)gx_removeDuplicatesWithKey:(NSString *)key {
    if (self.count < 2) {
        return [[NSMutableArray alloc] initWithArray:self];
    }
    NSMutableArray *arrayResult = [NSMutableArray new];
    NSMutableArray *arrayPk = [NSMutableArray new];
    
    NSObject *obj = self[0];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        if (key.length > 0) {
            for (NSDictionary *dic in self) {
                NSString *pk = dic[key];
                if (![arrayPk containsObject:pk]) {
                    [arrayResult addObject:dic];
                    [arrayPk addObject:pk];
                }
            }
            return arrayResult;
        } else {
            return [[NSMutableArray alloc] initWithArray:self];
        }
    } else if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]]) {
        for (NSObject *obj in self) {
            if (![arrayResult containsObject:obj]) {
                [arrayResult addObject:obj];
            }
        }
    } else {
        if (key.length > 0) {
            for (NSObject *obj in self) {
                NSString *pk = [obj valueForKey:key];
                if (![arrayPk containsObject:pk]) {
                    [arrayResult addObject:obj];
                    [arrayPk addObject:pk];
                }
            }
            return arrayResult;
        } else {
            return [[NSMutableArray alloc] initWithArray:self];
        }
    }
    return arrayResult;
}

- (NSArray *)gx_arrayByReplacingNullsWithBlanks
{
    NSMutableArray *replaced = [self mutableCopy];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    for (int idx = 0; idx < [replaced count]; idx++) {
        id object = [replaced objectAtIndex:idx];
        if (object == nul) [replaced replaceObjectAtIndex:idx withObject:blank];
        else if ([object isKindOfClass:[NSDictionary class]])
            [replaced replaceObjectAtIndex:idx withObject:[self gx_dictionaryByReplacingNullsWithBlanks:object]];
        else if ([object isKindOfClass:[NSArray class]])
            [replaced replaceObjectAtIndex:idx withObject:[object gx_arrayByReplacingNullsWithBlanks]];
    }
    return [replaced copy];
}

- (NSDictionary *)gx_dictionaryByReplacingNullsWithBlanks:(NSDictionary *)dic
{
    const NSMutableDictionary *replaced = [self mutableCopy];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    
    for (NSString *key in self) {
        id object = [dic objectForKey:key];
        if (object == nul) [replaced setValue:blank forKey:key];
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced setValue:[self gx_dictionaryByReplacingNullsWithBlanks:object] forKey:key];
        else if ([object isKindOfClass:[NSArray class]])
            [replaced setValue:[object gx_arrayByReplacingNullsWithBlanks] forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:[replaced copy]];
}


- (NSMutableArray *)gx_Mutable {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSObject *obj in self) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *mDic = [self gx_MutableWith:(NSDictionary *)obj];
            [tempArray addObject:mDic];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            NSMutableArray *mArr = [(NSArray *)obj gx_Mutable];
            [tempArray addObject:mArr];
            
        } else {
            [tempArray addObject:obj];
        }
    }
    
    return tempArray;
}
#pragma mark - private
/// 字典转换为可变字典
/// @param dic 字典
- (NSMutableDictionary *)gx_MutableWith:(NSDictionary *)dic
{
    NSMutableDictionary *dicResult = [[NSMutableDictionary alloc] init];
    for (NSString *key in dic.allKeys) {
        NSObject *obj = dic[key];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *mDic = [self gx_MutableWith:(NSDictionary *)obj];
            [dicResult setValue:mDic forKey:key];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            NSMutableArray *mArr = [(NSArray *)obj gx_Mutable];
            [dicResult setValue:mArr forKey:key];
        } else {
            [dicResult setValue:obj forKey:key];
        }
    }
    return dicResult;
}


#pragma mark - load runtime

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

         /* 没内容类型是__NSArray0 */
        SEL selectorsNSArray0[9] = {
            @selector(objectAtIndex:),
            @selector(subarrayWithRange:),
            @selector(objectAtIndexedSubscript:),
            @selector(indexOfObject:inRange:),
            @selector(objectsAtIndexes:),
            @selector(enumerateObjectsAtIndexes:options:usingBlock:),
            @selector(indexOfObjectAtIndexes:options:passingTest:),
            @selector(indexesOfObjectsAtIndexes:options:passingTest:),
            @selector(indexOfObject:inSortedRange:options:usingComparator:)
        };
        for (int i = 0; i < 9;  i++) {
            SEL selector = selectorsNSArray0[i];
            NSString *newSelectorStr = [[NSString stringWithFormat:@"gx_array0_%@", NSStringFromSelector(selector)] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
            [objc_getClass(NSArray0) gx_swizzleClassInstanceMethodWithOriginSel:selector swizzleSel:NSSelectorFromString(newSelectorStr)];
        }
        
        /* 没内容类型是__NSSingleObjectArrayI */
       SEL selectorsNSSingleObjectArrayI[9] = {
           @selector(objectAtIndex:),
           @selector(subarrayWithRange:),
           @selector(objectAtIndexedSubscript:),
           @selector(indexOfObject:inRange:),
           @selector(objectsAtIndexes:),
           @selector(enumerateObjectsAtIndexes:options:usingBlock:),
           @selector(indexOfObjectAtIndexes:options:passingTest:),
           @selector(indexesOfObjectsAtIndexes:options:passingTest:),
           @selector(indexOfObject:inSortedRange:options:usingComparator:)
       };
       for (int i = 0; i < 9;  i++) {
           SEL selector = selectorsNSSingleObjectArrayI[i];
           NSString *newSelectorStr = [[NSString stringWithFormat:@"gx_singleObjectArrayI_%@", NSStringFromSelector(selector)] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
           [objc_getClass(NSSingleObjectArrayI) gx_swizzleClassInstanceMethodWithOriginSel:selector swizzleSel:NSSelectorFromString(newSelectorStr)];
       }
        
        /* 没内容类型是__NSArrayI */
       SEL selectorsNSArrayI[9] = {
           @selector(objectAtIndex:),
           @selector(subarrayWithRange:),
           @selector(objectAtIndexedSubscript:),
           @selector(indexOfObject:inRange:),
           @selector(objectsAtIndexes:),
           @selector(enumerateObjectsAtIndexes:options:usingBlock:),
           @selector(indexOfObjectAtIndexes:options:passingTest:),
           @selector(indexesOfObjectsAtIndexes:options:passingTest:),
           @selector(indexOfObject:inSortedRange:options:usingComparator:)
       };
       for (int i = 0; i < 9;  i++) {
           SEL selector = selectorsNSArrayI[i];
           NSString *newSelectorStr = [[NSString stringWithFormat:@"gx_arrayI_%@", NSStringFromSelector(selector)] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
           [objc_getClass(NSArrayI) gx_swizzleClassInstanceMethodWithOriginSel:selector swizzleSel:NSSelectorFromString(newSelectorStr)];
       }
    });
}
#pragma mark - NSArray0
- (id)gx_array0_objectAtIndex:(NSUInteger)index
{
    if (index <= self.count-1 && self.count > 0) {
        return [self gx_array0_objectAtIndex:index];
    }
    return nil;
}
- (NSArray *)gx_array0_subarrayWithRange:(NSRange)range
{
    return [self gx_array0_subarrayWithRange:[self gx_getNewRangeWith:range]];
}
- (NSUInteger)gx_array0_indexOfObject:(id)anObject inRange:(NSRange)range
{
    return [self gx_array0_indexOfObject:anObject inRange:[self gx_getNewRangeWith:range]];
}
- (NSArray *)gx_array0_objectsAtIndexes:(NSIndexSet *)indexes
{
    NSIndexSet *newIndexes = [self filterIndexSetWith:indexes];
    if (newIndexes.count == 0) {
        return nil;
    }
    return [self gx_array0_objectsAtIndexes:newIndexes];
}
- (id)gx_array0_objectAtIndexedSubscript:(NSUInteger)idx
{
    if (idx <= self.count-1 && self.count > 0) {
        return [self gx_array0_objectAtIndexedSubscript:idx];
    }
    return nil;
}
- (void)gx_array0_enumerateObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts usingBlock:(void (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))block
{}
- (NSUInteger)gx_array0_indexOfObjectAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (NS_NOESCAPE^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    return NSNotFound;
}
- (NSIndexSet *)gx_array0_indexesOfObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    return [NSIndexSet indexSet];
}
- (NSUInteger)gx_array0_indexOfObject:(id)obj inSortedRange:(NSRange)r options:(NSBinarySearchingOptions)opts usingComparator:(NSComparator NS_NOESCAPE)cmp
{
    return NSNotFound;
}

#pragma mark - NSSingleObjectArrayI
- (id)gx_singleObjectArrayI_objectAtIndex:(NSUInteger)index
{
    if (index <= self.count-1 && self.count > 0) {
        return [self gx_singleObjectArrayI_objectAtIndex:index];
    }
    return nil;
}
- (NSArray *)gx_singleObjectArrayI_subarrayWithRange:(NSRange)range
{
    return [self gx_singleObjectArrayI_subarrayWithRange:[self gx_getNewRangeWith:range]];
}
- (NSUInteger)gx_singleObjectArrayI_indexOfObject:(id)anObject inRange:(NSRange)range
{
    return [self gx_singleObjectArrayI_indexOfObject:anObject inRange:[self gx_getNewRangeWith:range]];
}
- (NSArray *)gx_singleObjectArrayI_objectsAtIndexes:(NSIndexSet *)indexes
{
    NSIndexSet *newIndexes = [self filterIndexSetWith:indexes];
    if (newIndexes.count == 0) {
        return nil;
    }
    return [self gx_singleObjectArrayI_objectsAtIndexes:newIndexes];
}
- (id)gx_singleObjectArrayI_objectAtIndexedSubscript:(NSUInteger)idx
{
    if (idx <= self.count-1 && self.count > 0) {
        return [self gx_singleObjectArrayI_objectAtIndexedSubscript:idx];
    }
    return nil;
}

- (void)gx_singleObjectArrayI_enumerateObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts usingBlock:(void (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))block
{
    NSIndexSet *newIndexes = [self filterIndexSetWith:s];
    if (newIndexes.count != 0) {
        [self gx_singleObjectArrayI_enumerateObjectsAtIndexes:newIndexes options:opts usingBlock:block];
    }
}
- (NSUInteger)gx_singleObjectArrayI_indexOfObjectAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (NS_NOESCAPE^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    NSIndexSet *newIndexes = [self filterIndexSetWith:s];
    if (newIndexes.count == 0) {
        return NSNotFound;
    }
    return [self gx_singleObjectArrayI_indexOfObjectAtIndexes:newIndexes options:opts passingTest:predicate];
}
- (NSIndexSet *)gx_singleObjectArrayI_indexesOfObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    NSIndexSet *newIndexes = [self filterIndexSetWith:s];
    if (newIndexes.count == 0) {
        return [NSIndexSet indexSet];
    }
    return [self gx_singleObjectArrayI_indexesOfObjectsAtIndexes:newIndexes options:opts passingTest:predicate];
}
- (NSUInteger)gx_singleObjectArrayI_indexOfObject:(id)obj inSortedRange:(NSRange)r options:(NSBinarySearchingOptions)opts usingComparator:(NSComparator NS_NOESCAPE)cmp
{
    return [self gx_singleObjectArrayI_indexOfObject:obj inSortedRange:[self gx_getNewRangeWith:r] options:opts usingComparator:cmp];
}
#pragma mark - NSArrayI
- (id)gx_arrayI_objectAtIndex:(NSUInteger)index
{
    if (index <= self.count-1 && self.count > 0) {
        return [self gx_arrayI_objectAtIndex:index];
    }
    return nil;
}
- (NSArray *)gx_arrayI_subarrayWithRange:(NSRange)range
{
    return [self gx_arrayI_subarrayWithRange:[self gx_getNewRangeWith:range]];
}
- (NSUInteger)gx_arrayI_indexOfObject:(id)anObject inRange:(NSRange)range
{
    return [self gx_arrayI_indexOfObject:anObject inRange:[self gx_getNewRangeWith:range]];
}

- (NSArray *)gx_arrayI_objectsAtIndexes:(NSIndexSet *)indexes
{
    NSIndexSet *newIndexes = [self filterIndexSetWith:indexes];
    if (newIndexes.count == 0) {
        return nil;
    }
    return [self gx_arrayI_objectsAtIndexes:newIndexes];
}

- (id)gx_arrayI_objectAtIndexedSubscript:(NSUInteger)idx
{
    /*
    -objectAtIndexedSubscript：提供对obj-c下标的支持的方法。换句话说，这个方法是编译器使用的方法，如果你说数组[3]。但是对于NSArray *，它与-objectAtIndex：完全相同。为什么它是一个不同的方法的原因是其他类可以实现这一点，以便支持obj-c下标，而不必使用通用命名的-objectAtIndex：。
    */
    if (idx <= self.count-1 && self.count > 0) {
        return [self gx_arrayI_objectAtIndexedSubscript:idx];
    }
    return nil;
}

- (void)gx_arrayI_enumerateObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts usingBlock:(void (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))block
{
    NSIndexSet *newIndexes = [self filterIndexSetWith:s];
    if (newIndexes.count != 0) {
        [self gx_arrayI_enumerateObjectsAtIndexes:newIndexes options:opts usingBlock:block];
    }
}
- (NSUInteger)gx_arrayI_indexOfObjectAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (NS_NOESCAPE^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    NSIndexSet *newIndexes = [self filterIndexSetWith:s];
    if (newIndexes.count == 0) {
        return NSNotFound;
    }
    return [self gx_arrayI_indexOfObjectAtIndexes:newIndexes options:opts passingTest:predicate];
}
- (NSIndexSet *)gx_arrayI_indexesOfObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    NSIndexSet *newIndexes = [self filterIndexSetWith:s];
    if (newIndexes.count == 0) {
        return [NSIndexSet indexSet];
    }
    return [self gx_arrayI_indexesOfObjectsAtIndexes:newIndexes options:opts passingTest:predicate];
}
- (NSUInteger)gx_arrayI_indexOfObject:(id)obj inSortedRange:(NSRange)r options:(NSBinarySearchingOptions)opts usingComparator:(NSComparator NS_NOESCAPE)cmp
{
    return [self gx_arrayI_indexOfObject:obj inSortedRange:[self gx_getNewRangeWith:r] options:opts usingComparator:cmp];
}



- (NSRange)gx_getNewRangeWith:(NSRange)range
{
    NSUInteger location = range.location;
    NSUInteger length = range.length;
    
    if (location > self.count) {
        return NSMakeRange(self.count, 0);
    } else {
        if (length + location > self.count) {
            length = self.count - location;
        }
        return NSMakeRange(location, length);
    }
}

/// 筛选NSIndexSet
- (NSIndexSet *)filterIndexSetWith:(NSIndexSet *)indexSet
{
    NSMutableIndexSet *mutableIndexSet = [NSMutableIndexSet indexSet];
    [indexSet enumerateRangesUsingBlock:^(NSRange range, BOOL * _Nonnull stop) {
        if (range.location == NSNotFound || range.length == NSNotFound) {
            
        }else if (range.location == self.count-1)
        {
            NSRange newRange = NSMakeRange(range.location, 1);
            [mutableIndexSet addIndexesInRange:newRange];
        }else if (range.location < self.count && range.location + range.length > self.count)
        {
            NSRange newRange = NSMakeRange(range.location, self.count - range.location);
            [mutableIndexSet addIndexesInRange:newRange];
        }else
        {
            [mutableIndexSet addIndexesInRange:range];
        }
    }];
    return mutableIndexSet;
}


@end
