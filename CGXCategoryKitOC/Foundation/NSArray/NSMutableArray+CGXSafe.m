//
//  NSMutableArray+CGXSafe.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSMutableArray+CGXSafe.h"
#import "NSObject+CGXRuntime.h"
#import <objc/runtime.h>

static const char *NSArrayM = "__NSArrayM";
static const char *NSCFArray = "__NSCFArray";

@implementation NSMutableArray (CGXSafe)

- (void)gx_addObject:(id)anObject withKey:(NSString *)key {
    if (self.count < 1) {
        [self addObject:anObject];
    } else {
        if ([anObject isKindOfClass:[NSDictionary class]]) {
            if (key.length > 0) {
                BOOL has = NO;
                for (NSDictionary *dic in self) {
                    NSString *pk = dic[key];
                    if ([pk isEqualToString:((NSDictionary *)anObject)[key]]) {
                        has = YES;
                        break;
                    }
                }
                if (!has) {
                    [self addObject:anObject];
                }
                
            } else {
                [self addObject:anObject];
            }
        } else if ([anObject isKindOfClass:[NSString class]] || [anObject isKindOfClass:[NSNumber class]]) {
            if (![self containsObject:anObject]) {
                [self addObject:anObject];
            }
        } else {
            if (key.length > 0) {
                BOOL has = NO;
                for (NSObject *obj in self) {
                    NSString *pk = [obj valueForKey:key];
                    if ([pk isEqualToString:[anObject valueForKey:key]]) {
                        has = YES;
                        break;
                    }
                }
                if (!has) {
                    [self addObject:anObject];
                }
                
            } else {
                [self addObject:anObject];
            }
        }
    }
}

#pragma mark - load runtime

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /* 没内容类型是__NSArrayI */
       SEL selectorsNSArrayI[23] = {
           @selector(addObject:),
           
           @selector(objectAtIndex:),
           @selector(subarrayWithRange:),
           @selector(objectAtIndexedSubscript:),
           @selector(indexOfObject:inRange:),
           @selector(objectsAtIndexes:),
           
           @selector(exchangeObjectAtIndex:withObjectAtIndex:),
           @selector(setObject:atIndexedSubscript:),
           @selector(enumerateObjectsAtIndexes:options:usingBlock:),
           
           @selector(indexOfObjectAtIndexes:options:passingTest:),
           @selector(indexesOfObjectsAtIndexes:options:passingTest:),
           @selector(indexOfObject:inSortedRange:options:usingComparator:),
           
           @selector(removeObjectAtIndex:),
           @selector(removeObjectsAtIndexes:),
           @selector(removeObject:inRange:),
           @selector(removeObjectsInRange:),
           @selector(removeObjectIdenticalTo:inRange:),
           
           @selector(replaceObjectAtIndex:withObject:),
           @selector(replaceObjectsInRange:withObjectsFromArray:range:),
           @selector(replaceObjectsInRange:withObjectsFromArray:),
           @selector(replaceObjectsAtIndexes:withObjects:),
           
           @selector(insertObject:atIndex:),
           @selector(insertObjects:atIndexes:),
       };
       for (int i = 0; i < 23;  i++) {
           SEL selector = selectorsNSArrayI[i];
           NSString *newSelectorStr = [[NSString stringWithFormat:@"gx_arrayM_hook_%@", NSStringFromSelector(selector)] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
           [objc_getClass(NSArrayM) gx_swizzleClassInstanceMethodWithOriginSel:selector swizzleSel:NSSelectorFromString(newSelectorStr)];
       }
        
//        for (int i = 0; i < 1;  i++) {
//            SEL selector = selectorsNSArrayI[i];
//            NSString *newSelectorStr = [[NSString stringWithFormat:@"gx_arrayM_hook_%@", NSStringFromSelector(selector)] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
//            [objc_getClass(NSCFArray) gx_swizzleClassInstanceMethodWithOriginSel:selector swizzleSel:NSSelectorFromString(newSelectorStr)];
//        }
    });
}

- (void)gx_arrayM_hook_addObject:(id)anObject {
    @synchronized (self) {
        if (anObject) {
            [self gx_arrayM_hook_addObject:anObject];
        } else {
            NSLog(@"NSMutableArray invalid args hookAddObject:[%@]", anObject);
        }
    }
}
#pragma mark - NSArrayM
- (id)gx_arrayM_hook_objectAtIndex:(NSUInteger)index
{
    @synchronized (self) {
        if (index <= self.count-1 && self.count > 0) {
            return [self gx_arrayM_hook_objectAtIndex:index];
        }
        return nil;
    }
}
- (NSArray *)gx_arrayM_hook_subarrayWithRange:(NSRange)range
{
    @synchronized (self) {
        return [self gx_arrayM_hook_subarrayWithRange:[self getNewRangeWith:range]];
    }
}
- (NSUInteger)gx_arrayM_hook_indexOfObject:(id)anObject inRange:(NSRange)range
{
    @synchronized (self) {
        return [self gx_arrayM_hook_indexOfObject:anObject inRange:[self getNewRangeWith:range]];
    }
}
- (NSArray *)gx_arrayM_hook_objectsAtIndexes:(NSIndexSet *)indexes
{
    @synchronized (self) {
        NSIndexSet *newIndexes = [self filterIndexSetWith:indexes];
        if (newIndexes.count == 0) {
            return nil;
        }
        return [self gx_arrayM_hook_objectsAtIndexes:newIndexes];
    }
}
- (id)gx_arrayM_hook_objectAtIndexedSubscript:(NSUInteger)idx
{
    @synchronized (self) {
        if (idx <= self.count-1 && self.count > 0) {
            return [self gx_arrayM_hook_objectAtIndexedSubscript:idx];
        }
        return nil;
    }
}
- (void)gx_arrayM_hook_enumerateObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts usingBlock:(void (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))block
{
    @synchronized (self) {
        NSIndexSet *newIndexes = [self filterIndexSetWith:s];
        if (newIndexes.count != 0) {
            [self gx_arrayM_hook_enumerateObjectsAtIndexes:newIndexes options:opts usingBlock:block];
        }
    }
}
- (NSUInteger)gx_arrayM_hook_indexOfObjectAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (NS_NOESCAPE^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    @synchronized (self) {
        NSIndexSet *newIndexes = [self filterIndexSetWith:s];
        if (newIndexes.count == 0) {
            return NSNotFound;
        }
        return [self gx_arrayM_hook_indexOfObjectAtIndexes:newIndexes options:opts passingTest:predicate];
    }
}
- (NSIndexSet *)gx_arrayM_hook_indexesOfObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    @synchronized (self) {
        NSIndexSet *newIndexes = [self filterIndexSetWith:s];
        if (newIndexes.count == 0) {
            return [NSIndexSet indexSet];
        }
        return [self gx_arrayM_hook_indexesOfObjectsAtIndexes:newIndexes options:opts passingTest:predicate];
    }
}
- (NSUInteger)gx_arrayM_hook_indexOfObject:(id)obj inSortedRange:(NSRange)r options:(NSBinarySearchingOptions)opts usingComparator:(NSComparator NS_NOESCAPE)cmp
{
    @synchronized (self) {
        return [self gx_arrayM_hook_indexOfObject:obj inSortedRange:[self getNewRangeWith:r] options:opts usingComparator:cmp];
    }
}
- (void)gx_arrayM_hook_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    @synchronized (self) {
        if (index >= 0 && index <= self.count && anObject != nil) {
            [self gx_arrayM_hook_insertObject:anObject atIndex:index];
        }
    }
}
- (void)gx_arrayM_hook_removeObjectAtIndex:(NSUInteger)index
{
    @synchronized (self) {
        if (index >= 0 && index < self.count) {
            [self gx_arrayM_hook_removeObjectAtIndex:index];
        }
    }
}
- (void)gx_arrayM_hook_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    @synchronized (self) {
        if (index >= 0 && index < self.count && anObject != nil) {
            [self gx_arrayM_hook_replaceObjectAtIndex:index withObject:anObject];
        }
    }
}
- (void)gx_arrayM_hook_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2
{
    @synchronized (self) {
        if ((idx1 >= 0 && idx1 < self.count) && (idx2 >= 0 && idx2 < self.count)) {
            [self gx_arrayM_hook_exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
        }
    }
}
- (void)gx_arrayM_hook_removeObject:(id)anObject inRange:(NSRange)range
{
    @synchronized (self) {
        [self gx_arrayM_hook_removeObject:anObject inRange:[self getNewRangeWith:range]];
    }
}
- (void)gx_arrayM_hook_removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range
{
    @synchronized (self) {
        [self gx_arrayM_hook_removeObjectIdenticalTo:anObject inRange:[self getNewRangeWith:range]];
    }
}
- (void)gx_arrayM_hook_removeObjectsInRange:(NSRange)range
{
    @synchronized (self) {
        [self gx_arrayM_hook_removeObjectsInRange:[self getNewRangeWith:range]];
    }
}
- (void)gx_arrayM_hook_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray range:(NSRange)otherRange
{
    @synchronized (self) {
        [self gx_arrayM_hook_replaceObjectsInRange:[self getNewRangeWith:range] withObjectsFromArray:otherArray range:[self getNewRangeWith:otherRange count:otherArray.count]];
    }
}
- (void)gx_arrayM_hook_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray
{
    @synchronized (self) {
        [self gx_arrayM_hook_replaceObjectsInRange:[self getNewRangeWith:range] withObjectsFromArray:otherArray];
    }
}
- (void)gx_arrayM_hook_insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes
{
    @synchronized (self) {
        NSMutableIndexSet *mutableIndexSet = [NSMutableIndexSet indexSet];
        [indexes enumerateRangesUsingBlock:^(NSRange range, BOOL * _Nonnull stop) {
            if (range.location == NSNotFound || range.length == NSNotFound) {
                
            }else if (range.location <= self.count)
            {
                NSRange newRange = NSMakeRange(range.location, objects.count);
                [mutableIndexSet addIndexesInRange:newRange];
            }
        }];
        if (mutableIndexSet.count > 0) {
            [self gx_arrayM_hook_insertObjects:objects atIndexes:mutableIndexSet];
        }
    }
}
- (void)gx_arrayM_hook_removeObjectsAtIndexes:(NSIndexSet *)indexes
{
    @synchronized (self) {
        NSIndexSet *newIndexes = [self filterIndexSetWith:indexes];
        if (newIndexes.count > 0) {
            [self gx_arrayM_hook_removeObjectsAtIndexes:newIndexes];
        }
    }
}
- (void)gx_arrayM_hook_replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects
{
    @synchronized (self) {
        NSIndexSet *newIndexes = [self filterIndexSetWith:indexes];
        if (newIndexes.count > 0 && objects.count > 0) {
            [self gx_arrayM_hook_replaceObjectsAtIndexes:newIndexes withObjects:objects];
        }
    }
}
- (void)gx_arrayM_hook_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx
{
    @synchronized (self) {
        if (idx >=0 && idx <= self.count && obj != nil) {
            [self gx_arrayM_hook_setObject:obj atIndexedSubscript:idx];
        }
    }
}
#pragma mark - private
/// 筛选NSIndexSet
- (NSIndexSet *)filterIndexSetWith:(NSIndexSet *)indexSet
{
    NSMutableIndexSet *mutableIndexSet = [NSMutableIndexSet indexSet];
    [indexSet enumerateRangesUsingBlock:^(NSRange range, BOOL * _Nonnull stop) {
        if (range.location == NSNotFound || range.length == NSNotFound) {
            
        }else if (range.location == self.count-1) {
            NSRange newRange = NSMakeRange(range.location, 1);
            [mutableIndexSet addIndexesInRange:newRange];
        }else if (range.location < self.count && range.location + range.length > self.count) {
            NSRange newRange = NSMakeRange(range.location, self.count - range.location);
            [mutableIndexSet addIndexesInRange:newRange];
        }else {
            [mutableIndexSet addIndexesInRange:range];
        }
    }];
    return mutableIndexSet;
}

- (BOOL)rangeIsAvailable:(NSRange)range max:(NSInteger)max
{
    BOOL flag = true;
    if (range.location > max) {
        flag = false;
       
    }
    return flag;
}
- (NSRange)getNewRangeWith:(NSRange)range
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
- (NSRange)getNewRangeWith:(NSRange)range count:(NSUInteger)count
{
    NSUInteger location = range.location;
    NSUInteger length = range.length;
    
    if (location > count) {
        return NSMakeRange(count, 0);
    } else {
        if (length + location > count) {
            length = count - location;
        }
        return NSMakeRange(location, length);
    }
}


@end
