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
        
//        [dictM dictionaryRuntimeMExtCategorySwizzleSystemSel:@selector(setObject:forKeyedSubscript:)
//                                                       mySel:@selector(mutableDictionaryRuntimeMExtCategorySwizzleSetObject:forKeyedSubscript:)];
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

//- (void)mutableDictionaryRuntimeMExtCategorySwizzleSetObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
//    if (!obj) {
//        obj = @"";
//    }
//    [self mutableDictionaryRuntimeMExtCategorySwizzleSetObject:obj forKeyedSubscript:key];
//}
@end
