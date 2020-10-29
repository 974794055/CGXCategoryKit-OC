//
//  NSArray+CGXSafe.m
//  CGXCategoryKitOC
//
//  Created by CGX on 2020/10/21.
//

#import "NSArray+CGXSafe.h"
#import <objc/runtime.h>
@implementation NSArray (CGXSafe)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 0数组
        [objc_getClass("__NSArray0") arrayRuntimeMExtCategorySwizzleSystemSel:@selector(objectAtIndex:)
                                                                        mySel:@selector(arrayRuntimeMExtCategorySwizzleEmptyObjectAtIndex:)];
        // 1数组
        [objc_getClass("__NSSingleObjectArrayI") arrayRuntimeMExtCategorySwizzleSystemSel:@selector(objectAtIndex:)
                                                                                    mySel:@selector(arrayRuntimeMExtCategorySwizzleOnlyOneObjectAtIndex:)];
        // 常规数组取值
        id arrayI = objc_getClass("__NSArrayI");
        [arrayI arrayRuntimeMExtCategorySwizzleSystemSel:@selector(objectAtIndex:)
                                                   mySel:@selector(arrayRuntimeMExtCategorySwizzleObjectAtIndex:)];
        
        [arrayI arrayRuntimeMExtCategorySwizzleSystemSel:@selector(objectAtIndexedSubscript:)
                                                   mySel:@selector(arrayRuntimeMExtCategorySwizzleConvenientObjectAtIndexedSubscript:)];
        // 可变数组
        id arrayM = objc_getClass("__NSArrayM");
        [arrayM arrayRuntimeMExtCategorySwizzleSystemSel:@selector(objectAtIndex:)
                                                   mySel:@selector(mutableArrayRuntimeMExtCategorySwizzleObjectAtIndex:)];
        
        [arrayM arrayRuntimeMExtCategorySwizzleSystemSel:@selector(objectAtIndexedSubscript:)
                                                   mySel:@selector(mutableArrayRuntimeMExtCategorySwizzleConvenientObjectAtIndexedSubscript:)];
        
        [arrayM arrayRuntimeMExtCategorySwizzleSystemSel:@selector(setObject:atIndexedSubscript:)
                                                   mySel:@selector(mutableArrayRuntimeMExtCategorySwizzleSetObject:atIndexedSubscript:)];
        
        [arrayM arrayRuntimeMExtCategorySwizzleSystemSel:@selector(insertObject:atIndex:)
                                                   mySel:@selector(mutableArrayRuntimeMExtCategorySwizzleInsertObject:atIndex:)];
        
        [arrayM arrayRuntimeMExtCategorySwizzleSystemSel:@selector(addObjectsFromArray:)
                                                   mySel:@selector(mutableArrayRuntimeMExtCategorySwizzleAddObjectsFromArray:)];
    });
}

+ (void)arrayRuntimeMExtCategorySwizzleSystemSel:(SEL)systemSel mySel:(SEL)mySel {
    Class clz = [self class];
    Method systemMethod = class_getInstanceMethod(clz, systemSel);
    Method myMethod = class_getInstanceMethod(clz, mySel);
    if (class_addMethod(clz, systemSel, method_getImplementation(myMethod), method_getTypeEncoding(myMethod))) {
        class_replaceMethod(clz, mySel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    } else {
        method_exchangeImplementations(systemMethod, myMethod);
    }
}

#pragma mark - NSArray

// 空数组
- (id)arrayRuntimeMExtCategorySwizzleEmptyObjectAtIndex:(NSUInteger)index {
    return nil;
}

// only one
- (id)arrayRuntimeMExtCategorySwizzleOnlyOneObjectAtIndex:(NSUInteger)index {
//    NSAssert(index < self.count, @"数组越界");
    if (index) {
        return nil;
    }
    return [self arrayRuntimeMExtCategorySwizzleOnlyOneObjectAtIndex:index];
}

// 方法取值
- (id)arrayRuntimeMExtCategorySwizzleObjectAtIndex:(NSUInteger)index {
//    NSAssert(index < self.count, @"数组越界");
    if (index >= self.count) {
        return nil;
    }
    return [self arrayRuntimeMExtCategorySwizzleObjectAtIndex:index];
}

// 语法糖语法取值
- (id)arrayRuntimeMExtCategorySwizzleConvenientObjectAtIndexedSubscript:(NSUInteger)idx {
//    NSAssert(idx < self.count, @"数组越界");
    if (idx >= self.count) {
        return nil;
    }
    return [self arrayRuntimeMExtCategorySwizzleConvenientObjectAtIndexedSubscript:idx];
}

#pragma mark - NSMutableArray

// 可变数组取值
- (id)mutableArrayRuntimeMExtCategorySwizzleObjectAtIndex:(NSUInteger)index {
//    NSAssert(index < self.count, @"可变数组越界");
    if (index >= self.count) {
        return nil;
    }
    return [self mutableArrayRuntimeMExtCategorySwizzleObjectAtIndex:index];
}

// 语法糖语法取值
- (id)mutableArrayRuntimeMExtCategorySwizzleConvenientObjectAtIndexedSubscript:(NSUInteger)idx {
//    NSAssert(idx < self.count, @"可变数组越界");
    if (idx >= self.count) {
        return nil;
    }
    return [self mutableArrayRuntimeMExtCategorySwizzleConvenientObjectAtIndexedSubscript:idx];
}

// 可变数组语法糖插值
- (void)mutableArrayRuntimeMExtCategorySwizzleSetObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
//    NSAssert(obj, @"anObject 为空，插入不能");
    if (!obj) {
        return;
    }
    if (idx > self.count) {
        idx = self.count;
    }
    [self mutableArrayRuntimeMExtCategorySwizzleSetObject:obj atIndexedSubscript:idx];
}

// 方法插值
- (void)mutableArrayRuntimeMExtCategorySwizzleInsertObject:(id)anObject atIndex:(NSUInteger)index {
//    NSAssert(anObject, @"anObject 为空，插入不能");
    if (!anObject) {
        return;
    }
    if (index > self.count) {
        index = self.count;
    }
    [self mutableArrayRuntimeMExtCategorySwizzleInsertObject:anObject atIndex:index];
}

- (void)mutableArrayRuntimeMExtCategorySwizzleAddObjectsFromArray:(NSArray *)otherArray {
//    NSAssert(otherArray, @"otherArray 为空，插入不能");
    if (!otherArray || ![otherArray isKindOfClass:NSArray.class]) {
        return;
    }
    [self mutableArrayRuntimeMExtCategorySwizzleAddObjectsFromArray:otherArray];
}
@end
