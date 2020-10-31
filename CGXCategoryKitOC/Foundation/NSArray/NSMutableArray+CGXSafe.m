//
//  NSMutableArray+CGXSafe.m
//  CGXCategoryKitOC
//
//  Created by CGX on 2020/10/21.
//

#import "NSMutableArray+CGXSafe.h"
#import <objc/runtime.h>
@implementation NSMutableArray (CGXSafe)

+ (void)load{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self gx_swizzlingSysMethod:@"addObject:" sysClassString:@"__NSArrayM" toCustMethod:@"gx_addObject:" targetClassString:@"NSMutableArray"];
        
        [self gx_swizzlingSysMethod:@"insertObject:atIndex:" sysClassString:@"__NSArrayM" toCustMethod:@"gx_insertObject:atIndex:" targetClassString:@"NSMutableArray"];
        
        [self gx_swizzlingSysMethod:@"removeObjectAtIndex:" sysClassString:@"__NSArrayM" toCustMethod:@"gx_removeObjectAtIndex:" targetClassString:@"NSMutableArray"];
        
        [self gx_swizzlingSysMethod:@"replaceObjectAtIndex:withObject:" sysClassString:@"__NSArrayM" toCustMethod:@"gx_safe_replaceObjectAtIndex:withObject:" targetClassString:@"NSMutableArray"];
        
        [self gx_swizzlingSysMethod:@"removeObjectsAtIndexes:" sysClassString:@"NSMutableArray" toCustMethod:@"gx_removeObjectsAtIndexes:" targetClassString:@"NSMutableArray"];
        
        [self gx_swizzlingSysMethod:@"removeObjectsInRange:" sysClassString:@"NSMutableArray" toCustMethod:@"gx_removeObjectsInRange:" targetClassString:@"NSMutableArray"];
        
        [self gx_swizzlingSysMethod:@"objectAtIndex:" sysClassString:@"__NSArrayM" toCustMethod:@"gx_objectAtIndex:" targetClassString:@"NSMutableArray"];
        
    });
    
}


- (void)gx_addObject:(id)anObject{
    if (!anObject) {
        return;
    }
    [self gx_addObject:anObject];
}

- (void)gx_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index > [self count]) {
        return;
    }
    if (!anObject) {
        return;
    }
    [self gx_insertObject:anObject atIndex:index];
}

- (void)gx_removeObjectAtIndex:(NSUInteger)index {
    if (index >= [self count]) {
        return;
    }
    
    return [self gx_removeObjectAtIndex:index];
}

- (void)safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index >= [self count]) {
        return;
    }
    if (!anObject) {
        return;
    }
    [self safe_replaceObjectAtIndex:index withObject:anObject];
}

- (void)gx_removeObjectsAtIndexes:(NSIndexSet *)indexes{
    NSMutableIndexSet * mutableSet = [NSMutableIndexSet indexSet];
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < [self count ]) {
            [mutableSet addIndex:idx];
        }
    }];
    [self gx_removeObjectsAtIndexes:mutableSet];
}

- (void)gx_removeObjectsInRange:(NSRange)range{
    //获取最大索引
    if (range.location + range.length - 1 < [self count]) {
        [self gx_removeObjectsInRange:range];
        return;
    }
    if (range.location >= [self count]) {
        return;
    }
    NSInteger tempInteger = range.location + range.length - 1;
    while (tempInteger >= [self count]) {
        tempInteger -= 1;
    }
    NSRange tempRange = NSMakeRange(range.location, tempInteger + 1 -range.location);
    [self gx_removeObjectsInRange:tempRange];
}

- (id)gx_objectAtIndex:(NSUInteger)index{
    //判断数组是否越界
    if (index >= [self count]) {
        return nil;
    }
    return [self gx_objectAtIndex:index];
}

+ (void)gx_swizzlingSysMethod:(NSString *)systemMethodString sysClassString:(NSString *)systemClassString toCustMethod:(NSString *)custMethodString targetClassString:(NSString *)targetClassString{
    
    //系统方法IMP
    Method sysMethod = class_getInstanceMethod(NSClassFromString(systemClassString), NSSelectorFromString(systemMethodString));
    
    //自定义方法的IMP
    Method safeMethod = class_getInstanceMethod(NSClassFromString(targetClassString), NSSelectorFromString(custMethodString));
    
    //通过IMP相互交换，进而交换方法的实现
    method_exchangeImplementations(safeMethod,sysMethod);
}

@end
